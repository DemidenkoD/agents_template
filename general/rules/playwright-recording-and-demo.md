# Rule: Playwright Recording and Demo Pipeline

- **Trigger:** course project needs a narrated UI demo video (walkthrough, feature demo, training clip).
- **Scope:** any Playwright + ffmpeg repo. Agent-driven, no manual video editing.

## 5-step pipeline

Keep this order. Each step is a scriptable command with placeholders:

1. `validate / synth` — validate narration YAML + topic assets; synthesize narration audio (or stub in CI).
2. `record` — run Playwright spec(s) headless at 1920x1080, capture raw video + schedule marks.
3. `mux` — offset audio tracks onto raw video with ffmpeg, produce final `.mp4`/`.webm`.
4. `summary` — assert durations, drift, and file sizes; emit a short JSON report.
5. `catalog` — append entry (topic, locale, duration, paths) to a catalog JSON/YAML.

Example shape (adapt names to `<project>`):

```bash
<project>/scripts/demo.sh validate --topic <topic> --locale <locale>
<project>/scripts/demo.sh record   --topic <topic> --locale <locale>
<project>/scripts/demo.sh mux      --topic <topic> --locale <locale>
<project>/scripts/demo.sh summary  --topic <topic> --locale <locale>
```

## Narration YAML contract (v1 excerpt)

```yaml
version: 1
topic: <topic>
locale: <locale>            # e.g. en | uk
voice: <voice-id>           # TTS voice; stubbed when no API key
segments:
  - id: intro
    text: "<narration text>"
    at: 2.0                 # seconds from video start
  - id: step-1
    text: "<narration text>"
    at: 8.5
```

Validate: `version == 1`, `at` strictly increasing, every `id` unique.

## Spec protocol: mark / awaitSchedule

Specs declare timed marks; the runner waits for them so narration stays in sync:

```ts
await mark('step-1');            // record timestamp into schedule-spec.json
await guidedClick(page, 'Next'); // HUD-visible action helper
await awaitSchedule('step-2', { timeoutMs: 15000, maxDriftMs: 3000 });
```

- `schedule-spec.json` holds `{ mark, expectedAt, actualAt }` per mark.
- Fail the run when `|actualAt - expectedAt| > 3s` (drift gate).
- Keep all timing in one helper module (e.g. `training-effects.ts`).

## Mux offsets formula

```
audio_start = segment.at + global_offset - video_start
final_duration = max(video_duration, last(audio_start + audio_duration))
```

- `global_offset`: single per-topic shift (silence trim / preroll), stored in topic config.
- Never hand-tune per-segment offsets to fix drift — fix the spec timing instead.

## Env vars

| Var | Purpose | Default |
|---|---|---|
| `E2E_BASE_URL` | app under test | `http://localhost:3000` |
| `TRAINING_UI_LOCALE` | `en` / second locale | `en` |
| `TRAINING_SCHEDULE` | path to `schedule-spec.json` | `./schedule-spec.json` |
| `TRAINING_SLOWMO` | ms between actions (readability) | `150` |
| `ELEVENLABS_API_KEY` | TTS; absent = stubbed silence | _(empty)_ |
| `FFMPEG` | ffmpeg binary path | `ffmpeg` |
| `LD_LIBRARY_PATH` | codec libs if bundled ffmpeg | _(empty)_ |

Video target: `1920x1080`, VP8/Vorbis in `.webm` (or H264/AAC in `.mp4`).

## HUD helpers (minimal set)

Implement once in `e2e/helpers/training-effects.ts`:

- `initPermanentHud(page, { topic, locale })` — persistent badge (topic + step counter).
- `guidedClick(page, name)` — spotlight + cursor move + click.
- `spotlight(page, selector)` — dim overlay except target.
- `showStep(page, n, text)` — step toast, also calls `mark(step-n)`.

Auth: reuse a single `loginViaApi(page, { user, password })` fixture; never hardcode real credentials.

## Gotchas

- Record topics **sequentially** — parallel runs corrupt timing and audio mux.
- Keep the **raw capture untouched**; mux to a new file, never overwrite raw.
- **No snapshot/text assertions** inside recording specs — they flake under slowmo/HUD. Assert schedule drift + file existence in the `summary` step instead.
- One spec file per topic (`e2e/tests/demos/<topic>.spec.ts`); shared helpers stay out of specs.
