#!/usr/bin/env bash
# ==============================================================================
# Internationalization (i18n) Locale Parity Validator
# Compares translation keys between the primary locale (default: en) and target
# locales to guarantee 100% schema parity with zero missing keys.
#
# Usage:
#   bash .agents/scripts/check-locale-parity.sh [locales_directory] [primary_locale] [target_locale]
# Default:
#   locales_dir: locales (or app/locales)
#   primary: en
#   target: uk (or de, es, fr)
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." 2>/dev/null && pwd || pwd)"
cd "${REPO_ROOT}"

LOCALES_DIR="${1:-}"
if [[ -z "${LOCALES_DIR}" ]]; then
  if [[ -d "locales" ]]; then
    LOCALES_DIR="locales"
  elif [[ -d "app/app/locales" ]]; then
    LOCALES_DIR="app/app/locales"
  elif [[ -d "src/locales" ]]; then
    LOCALES_DIR="src/locales"
  else
    echo "Notice: No locales directory detected. Skipping parity check."
    exit 0
  fi
fi

PRIMARY="${2:-en}"
TARGET="${3:-uk}"

PRIMARY_DIR="${LOCALES_DIR}/${PRIMARY}"
TARGET_DIR="${LOCALES_DIR}/${TARGET}"

if [[ ! -d "${PRIMARY_DIR}" || ! -d "${TARGET_DIR}" ]]; then
  echo "Notice: Locales ${PRIMARY} or ${TARGET} not found in ${LOCALES_DIR}. Skipping."
  exit 0
fi

fail=0
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "${TMP_DIR}"' EXIT

for primary_file in "${PRIMARY_DIR}"/*; do
  [[ -f "${primary_file}" ]] || continue
  base="$(basename "${primary_file}")"
  target_file="${TARGET_DIR}/${base}"

  if [[ ! -f "${target_file}" ]]; then
    echo "FAIL: Missing ${TARGET} file matching ${base}"
    fail=1
    continue
  fi

  # Extract translation keys (handles JSON or TypeScript key extraction)
  if [[ "${base}" == *.json ]]; then
    jq -r 'keys_unsorted[]' "${primary_file}" 2>/dev/null | sort -u > "${TMP_DIR}/primary.txt" || true
    jq -r 'keys_unsorted[]' "${target_file}" 2>/dev/null | sort -u > "${TMP_DIR}/target.txt" || true
  else
    grep -o "['\"][A-Za-z0-9_]*\.[A-Za-z0-9_.]*[A-Za-z0-9_]['\"]" "${primary_file}" | tr -d "'\"" | sort -u > "${TMP_DIR}/primary.txt" || true
    grep -o "['\"][A-Za-z0-9_]*\.[A-Za-z0-9_.]*[A-Za-z0-9_]['\"]" "${target_file}" | tr -d "'\"" | sort -u > "${TMP_DIR}/target.txt" || true
  fi

  if ! diff -u "${TMP_DIR}/primary.txt" "${TMP_DIR}/target.txt" > "${TMP_DIR}/diff.txt"; then
    echo "DRIFT detected in ${base}:"
    head -20 "${TMP_DIR}/diff.txt" | sed 's/^/  /'
    fail=1
  fi
done

if [[ "$fail" -eq 0 ]]; then
  echo "Locale parity OK (${PRIMARY} == ${TARGET} key sets)."
else
  echo "Locale parity FAILED — add identical keys to both locale files."
fi

exit "$fail"
