# Examples

English | [Español](README.es.md)

Every run behind the example in the [main README](../README.md), so you can check it against the notes and against the other runs.

`incident-email/` has one folder per language. Each holds the on-call notes the model was given (`notes.txt`), the request (`prompt.txt`), and five emails per side: `without-skill/` from the request as written, and `with-skill/` from the same request with "Write it like a human." added. All ten came from Claude Opus 5.5 in Claude Code, each in a separate agent run with its own copy of the notes. The with-skill runs used the current version of the skill.

The README shows the run of median length in characters on each side, fixed by that rule rather than by reading them: run 4 without the skill and run 5 with it in English, run 4 and run 3 in Spanish.

## How the example was chosen

Eight kinds of task were tried in both languages, with two variants each: PR descriptions, release notes, weekly updates, client emails, review comments, commits, Slack replies and code changes. Claude Fable 5.2 designed the tasks and judged the results; it wrote none of the compared texts.

1. Two blind evaluators per language read each pair without labels and said, for each text, whether an AI or a person wrote it. Some pairs were decoys, with both texts from the same side.
2. A task moved on when both evaluators called the text without the skill AI with confidence 4 or 5, and called the text with the skill human with no tells found.
3. The tasks that moved on were run five times per side. With labels visible, the evaluators counted the tells in all ten texts. A task passed only if at least four of the five texts without the skill had two or more tells and none of the five with it had any.
4. The same evaluators checked the shown pair against the notes: the text with the skill must drop nothing its reader needs and state nothing the notes don't say.

The skill was revised twice during this process, from what the evaluators found. The first version still left labels with a colon, placeholders like "[your name]" and catch-all closing lines. The second dropped real findings from review comments and turned "some went through on a retry" into "many". Both fixes are in the current version, and the five with-skill emails in each language were written with it.

After the last revision, the incident email passed every step in both languages. Review comments, Slack replies, PR descriptions, release notes and weekly updates passed some steps but not all, and code changes showed little difference. In commits, the only difference that showed up every time was the AI attribution trailer.

## Limits

- The with-skill side also gets the sentence "Write it like a human.", and there was no run with that sentence and no skill. Part of the difference may come from the sentence alone.
- Only the shown pair was checked line by line against the notes. In `es/with-skill/run-4.md` the revert is at 18:40; the notes say 18:38.
- Five runs per side is a small sample, and the tells were counted by models, not by people.
