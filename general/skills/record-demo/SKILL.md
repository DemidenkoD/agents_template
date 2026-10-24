---
name: record-demo
description: Build, record, mux and verify a narrated Playwright demo video for a course project.
---

# Skill: record-demo

Use when asked to create, re-record, or fix a demo/training video.
Companion rule: `general/rules/playwright-recording-and-demo.md`.

## Operator workflow

Follow in order: **build → record → mux → verify**. Stop and report at the first failing gate.

### 1. Build

```bash
<project>/scripts/demo.sh validate --topic <topic> --locale <locale>
TTS_STUB=1 <project>/scripts/demo.sh synth --topic <topic> --locale <locale>  # no TTS key in CI
```

Gate: YAML validates (`version: 1`, increasing `at`, unique ids); audio stubs exist.

### 2. Record (sequential, one topic at a time)

```bash
E2E_BASE_URL=<base-url> TRAINING_UI_LOCALE=<locale> TRAINING_SLOWMO=150 \
  npx playwright test e2e/tests/demos/<topic>.spec.ts --config playwright.demos.config.ts
```

Gate: `schedule-spec.json` written; every mark drift `< 3s`.

### 3. Mux

```bash
<project>/scripts/demo.sh mux --topic <topic> --locale <locale>
```

Gate: final file exists at `<project>/demos/<topic>.<locale>.webm` (1920x1080).

### 4. Verify

```bash
<project>/scripts/demo.sh summary --topic <topic> --locale <locale>
ls -la <project>/demos/<topic>.<locale>.webm
```

Gate: summary JSON reports drift `< 3s`, non-empty video + audio tracks.

## Commands with placeholders

| Need | Command |
|---|---|
| List topics | `<project>/scripts/demo.sh list` |
| Full pipeline, one topic | `<project>/scripts/demo.sh all --topic <topic> --locale <locale>` |
| Re-record single locale | `TRAINING_UI_LOCALE=<locale> npx playwright test e2e/tests/demos/<topic>.spec.ts` |

## Rules

- Never run two recordings in parallel.
- Never overwrite raw captures; mux writes a new file.
- No snapshot/text asserts in recording specs — drift + file gates only.
- Auth via `loginViaApi` fixture; credentials from env, never in the spec.
