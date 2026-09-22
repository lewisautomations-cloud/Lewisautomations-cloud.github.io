---
name: class-notes
description: Turn an Otter.ai class recording or transcript into study notes. Use when Yohan says "make my notes", "notes from class", "write up today's lecture", or hands over an Otter transcript, .txt/.docx export, or pasted transcript text from a class.
---

# Class notes from an Otter transcript

Yohan records every class in Otter.ai. Otter gives back a wall of raw speech.
This turns that into something worth reading a week later, when the exam is close
and the recording is 70 minutes long.

## Getting the transcript

Ask for the file if it wasn't provided. In order of preference:

1. A path to an exported transcript (Otter → open the conversation → Export → Text).
2. Pasted transcript text.
3. A folder to look in — check `~/Desktop/class-notes/` and `~/Downloads/` for the
   most recent `.txt` or `.docx`, and confirm which one before writing anything.

Never guess at content that isn't in the transcript. If the recording is partial,
say so at the top of the notes rather than filling the gap.

## What to write

Write to `~/Desktop/class-notes/<COURSE>/<YYYY-MM-DD>.md`, creating folders as
needed. Course code from the transcript if it's said aloud, otherwise ask.

Order matters. Put what costs him points first, not what happened first.

1. **Deadlines and anything graded.** Date, what's due, and where it gets turned
   in. Quote the professor exactly for anything with a deadline or a point value
   attached — his words, not a paraphrase. If a date was said but garbled, write
   the fragment and mark it `[verify]` rather than dropping it.
2. **The gist.** Three to five sentences. What was this class actually about?
3. **What was covered.** Organized by topic, not in the order it was said. A
   lecture circles back; the notes shouldn't.
4. **Terms and definitions.** Only ones actually defined in class, in the
   professor's framing, since that's the framing the exam will use.
5. **Emphasised.** Anything repeated, slowed down for, written on a board, or
   flagged as important or exam-relevant. This section is the study guide.
6. **Action items.** What Yohan personally has to do, with dates.
7. **Unclear.** Questions to bring to office hours or ask a classmate. Better an
   honest gap than a confident invention.

## Rules that matter

- **Otter mishears jargon and names constantly.** Technical terms, product names
  and people's names come back wrong: "Claude" as "cloud", "n8n" as "eight in",
  "API" as "a P I". Correct them silently when the intended word is obvious from
  context. When it isn't, keep the raw text and mark it `[sic — Otter]`.
- **Crosstalk and filler get cut.** Nobody needs "um", the side conversation, or
  three false starts of the same sentence.
- **Attribute correctly.** Professor's claim, classmate's question and Yohan's own
  comment carry different weight. Keep them distinguishable.
- **Don't pad.** A thin class gets short notes. Length is not the point.
- **Never invent a deadline, a grade weight or a citation.** If it isn't in the
  transcript, it doesn't go in the notes.

## Then

Print the deadlines section to the terminal after writing the file — that's the
part with a clock on it, and it should not require opening a file to see.
