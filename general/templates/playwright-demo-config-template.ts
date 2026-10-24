// Template: minimal Playwright demo-recording config + one example spec pattern.
// Copy to <project>/playwright.demos.config.ts and adapt env defaults.
// Companion rule: general/rules/playwright-recording-and-demo.md
import { defineConfig } from '@playwright/test';

const baseURL = process.env.E2E_BASE_URL ?? 'http://localhost:3000';
const locale = process.env.TRAINING_UI_LOCALE ?? 'en';

export default defineConfig({
  testDir: './e2e/tests/demos',
  timeout: 120_000,
  use: {
    baseURL,
    locale,
    viewport: { width: 1920, height: 1080 },
    video: 'on',
    trace: 'retain-on-failure',
  },
  // Sequential: recording specs must NOT run in parallel (timing/audio mux).
  workers: 1,
  fullyParallel: false,
});

// ---- Example spec: e2e/tests/demos/<topic>.spec.ts -----------------------
// import { test } from '@playwright/test';
// import { loginViaApi } from '../../fixtures/auth';
// import { initPermanentHud, guidedClick, showStep, mark, awaitSchedule } from '../../helpers/training-effects';
//
// test('<topic> demo', async ({ page }) => {
//   await loginViaApi(page, { user: process.env.E2E_USER ?? 'demo@<project>.local' });
//   await initPermanentHud(page, { topic: '<topic>', locale: process.env.TRAINING_UI_LOCALE ?? 'en' });
//   await page.goto('/');
//   await mark('intro');
//   await showStep(page, 1, 'Open the dashboard');
//   await guidedClick(page, 'Dashboard');
//   await awaitSchedule('step-1', { timeoutMs: 15000, maxDriftMs: 3000 });
//   // No snapshot/text assertions here — drift + file gates live in the summary step.
// });
