# MathTrainer · Grade 10

A fast, offline-friendly Grade 10 Mathematics practice app.
Questions are stored **locally** in the app (instant, zero data cost). Accounts and
scores can optionally sync to a free cloud dashboard (Supabase).

---

## 1. What you need (one time)

Install **Node.js version 20.19 or newer** (the LTS version is perfect):
👉 https://nodejs.org

Check it is installed — open a terminal and run:

```bash
node -v
npm -v
```

You should see version numbers. If `node -v` is below 20.19, install the newer LTS first.

> Tip: In VS Code, open this project folder, then open the built-in terminal with
> **Terminal → New Terminal**.

---

## 2. Run the app on your computer

Inside the project folder, run these three commands one after another:

```bash
npm install
npm run dev
```

Then open the link it prints (usually **http://localhost:5173**) in your browser.
The app reloads automatically whenever you save a file.

To stop it, press **Ctrl + C** in the terminal.

---

## 3. If `npm install` fails on Windows (EPERM / ERR_INVALID_ARG_TYPE)

This is almost always caused by **where the folder is**, not the code.
Open **`WINDOWS-FIX.txt`** for the full picture. Short version:

1. Move the project to a simple path with **no spaces and no brackets**,
   and **not** inside Downloads/OneDrive. Example: `C:\dev\mathtrainer`
2. Close VS Code and pause OneDrive.
3. Delete the `node_modules` folder and `package-lock.json`.
4. Double-click **`setup-windows.bat`** (or run the commands below).

```bash
npm cache clean --force
npm install
npm run dev
```

On macOS / Linux the equivalent reset is:

```bash
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

---

## 4. Make a production build

```bash
npm run build
```

This creates a **`dist/`** folder containing a single `index.html` with everything
inlined. You can:
- open `dist/index.html` directly in a browser, or
- host it on any free static host (Netlify, Vercel, GitHub Pages, Firebase Hosting).

Preview the built version locally with:

```bash
npm run preview
```

---

## 5. Optional: cloud dashboard & email codes

The app runs fully without these. To switch them on, copy `.env.example` to `.env`
and fill in the keys:

- **Supabase** (view every learner's scores from a web dashboard) — see the
  in-app **Profile → Cloud dashboard** panel for the one-time SQL to run.
- **EmailJS** (send sign-up codes) — only if you want email verification.

After editing `.env`, stop and restart `npm run dev`.

---

## 6. Putting it on the Google Play Store

A Vite app is a website, so it is wrapped into an Android app with **Capacitor**.
Do this only after `npm run build` works.

```bash
# one-time setup
npm install @capacitor/core @capacitor/cli @capacitor/android
npx cap init "MathTrainer" "com.yourname.mathtrainer" --web-dir=dist
npx cap add android

# every time you change the app
npm run build
npx cap sync
npx cap open android
```

The last command opens **Android Studio**. From there:
1. Let it finish syncing Gradle.
2. **Build → Generate Signed Bundle / APK → Android App Bundle (.aab)**.
3. Create a keystore when asked and **keep it safe** (you need the same key for every update).
4. Upload the `.aab` file in the [Google Play Console](https://play.google.com/console)
   (one-time $25 developer registration).

You will need: an app icon, a few screenshots, a short description and a privacy
policy URL — the Play Console guides you through each step.

---

## Collecting reviews & feedback from users

The app has a built-in **Feedback** screen (💬 in the menu, and a prompt on the
Dashboard). Students pick 👍 / 💡 / 🐛, give a star rating, and leave a note.
It sends to you with **no server to run** — pick whichever is easiest:

- **On Netlify (recommended, zero setup):** nothing to configure. Submissions
  appear in your Netlify site → **Forms** tab. (Netlify auto-detects the form.)
- **Web3Forms (emails you):** make a free key at web3forms.com and put it in
  `.env` as `VITE_WEB3FORMS_KEY`, then rebuild. Reviews arrive in your inbox.
- **Fallback:** if neither is set, set `VITE_FEEDBACK_EMAIL` and the form opens
  the user's email app addressed to you.

> Tip for testers: share your Netlify link and ask them to use the 💬 Feedback
> button. You'll see every rating and comment in one place.

## Project structure

```
src/
  components/   screens & UI (Dashboard, Practice, Arena, Admin, …)
  data/         LOCAL question bank, papers, formulas (JSON/TS)
  context/      sign-in + live session state
  services/     cloud (Supabase) & email (EmailJS) — both optional
  types/        shared types + local storage helpers
```

Admin console: open the footer link **Admin console** (default PIN `2468` — change
`ADMIN_PIN` in `src/components/AdminConsole.tsx` before sharing).
