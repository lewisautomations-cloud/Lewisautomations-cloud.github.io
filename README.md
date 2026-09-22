# Yohan Lewis — personal site

**Live at [lewisautomations-cloud.github.io](https://lewisautomations-cloud.github.io/)** — that is the
link to share. It is served by GitHub Pages from `index.html` on the `main` branch of this repo.

Everything for the site lives in this folder. `index.html` is the whole thing: styles, scripts,
Justice, and the game are all inside that one file. There is nothing to install and no build step.

## Publishing a change

Edit `index.html`, then:

```powershell
git add index.html
git commit -m "What changed"
git push
```

GitHub Pages rebuilds on its own and the live site updates about a minute later.

`lewisautomations.co` does not point here yet. To move it, add a `CNAME` file containing the domain
and set the matching DNS records at your registrar.

## Running it on your own machine

This is only for previewing edits before you push them. It has nothing to do with the live site.

```powershell
powershell -ExecutionPolicy Bypass -File .\serve.ps1
```

That starts a small web server on your own computer and opens `http://localhost:8080`.

**`http://localhost:8080` is not a public address.** It means "this computer," so it only works
while `serve.ps1` is actually running in front of you, and it will never work for anyone else or
from your phone. If the page does not open, the server is not running — start it with the command
above, or just use the live link at the top.

If port 8080 is busy, the script quietly moves to 8081, 8082, and so on, and prints the address it
settled on.

**Don't just double-click `index.html`.** That opens it as a `file://` address, and browsers refuse
to give a `file://` page access to a microphone. Justice's voice input needs `http://localhost` or
the live HTTPS site.

## Add your headshot

Drop a photo in this folder named exactly `headshot.jpg`, then commit and push it.

It appears inside the animated rings in the hero automatically. Square works best, roughly 600×600
or larger. Until the file exists, the page shows the animated mark instead, so nothing looks broken
while you wait — which is what the live site is doing right now.

To use a different filename or a `.png`, change the `src` on the `<img id="headshot">` tag near the
top of the body in `index.html`.

## Justice, the voice assistant

Justice answers questions about you and the business, by voice or by typing, and reads the answer
back out loud.

On the live site and on your own machine, Justice uses a built-in knowledge base of about eighteen
answers written into `index.html`. Search for `var KB = [` to find them. Each entry is a list of
trigger keywords and the answer to give. Add or edit entries there as things change.

Only the claude.ai version runs Justice on Claude itself, where it can answer anything and falls
back to this same knowledge base. GitHub Pages serves a plain static file, so the knowledge base is
all it has. Keeping the knowledge base good is what keeps Justice good.

The facts Justice works from are in the `FACTS` variable just above the knowledge base. **Keep that
list current.** It is the single source of truth for what Justice will say about you.

One thing to keep honest now that the site is public: the guarantee in the "Why this is a low-risk
yes" section says you don't charge the setup fee if a build misses its approved blueprint. That is a
real commitment. Make sure you still mean it.

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
