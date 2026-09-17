# Yohan Lewis — personal site

Everything for the site lives in this folder. `index.html` is the whole thing: styles, scripts,
Justice, and the game are all inside that one file. There is nothing to install and no build step.

## Run it

```powershell
powershell -ExecutionPolicy Bypass -File .\serve.ps1
```

It opens http://localhost:8080 in your browser. Press Ctrl+C in that window to stop it.

**Don't just double-click `index.html`.** That opens it as a `file://` address, and browsers refuse
to give a `file://` page access to a microphone. Justice's voice input only works over
`http://localhost`, which is what `serve.ps1` gives you.

If port 8080 is busy, the script quietly moves to 8081, 8082, and so on, and prints the address it
settled on.

## Add your headshot

Drop a photo in this folder named exactly `headshot.jpg`.

It appears inside the animated rings in the hero automatically. Square works best, roughly 600×600
or larger. Until the file exists, the page shows the animated mark instead, so nothing looks broken
while you wait.

To use a different filename or a `.png`, change the `src` on the `<img id="headshot">` tag near the
top of the body in `index.html`.

## Justice, the voice assistant

Justice answers questions about you and the business, by voice or by typing, and reads the answer
back out loud.

Running locally, Justice uses a built-in knowledge base of about eighteen answers written into
`index.html`. Search for `var KB = [` to find them. Each entry is a list of trigger keywords and the
answer to give. Add or edit entries there as things change.

On the published claude.ai version, Justice runs on Claude instead and can answer anything, falling
back to this same knowledge base if Claude isn't available.

The facts Justice works from are in the `FACTS` variable just above the knowledge base. **Keep that
list current.** It is the single source of truth for what Justice will say about you.

## Publishing it for real

The file is self-contained, so any static host works. Netlify, Cloudflare Pages, and GitHub Pages
all accept a drag-and-drop of this folder. Point `lewisautomations.co` at whichever you pick.

One thing to check before you publish: the guarantee in the "Why this is a low-risk yes" section
says you don't charge the setup fee if a build misses its approved blueprint. That is a real
commitment. Make sure you still mean it.

## Editing

`index.html` is the file to edit. The order of the page is:

1. Hero with your name and the orbiting mark
2. Stats
3. Justice
4. Lewis Automations
5. How I can help, the free Leak Audit, and the ROI section
6. Experience and campus leadership
7. Skills and education
8. Auto-Reply, the game
9. Contact

Colors and fonts are defined once as CSS variables at the very top of the `<style>` block. Change
`--clay` to recolor every accent on the page at once.
