# Pattern catalog

Patterns that make outbound text read as machine-written, grouped by kind. Each one describes a default choice a model makes because it fits the widest range of readers; a human writer chooses for one reader. Any single pattern can be a deliberate human choice, so judge a passage by how many show up together, and leave quotations, proper names and text that discusses a phrase alone.

The structures carry across languages. Examples are given in English and Spanish; for other languages, look for the equivalent construction.

## Contents

- A. Staging instead of stating
- B. Chat residue and leftovers
- C. Inflation
- D. Rhythm and formatting by rule
- E. Filler and hedging
- F. Wrong reader
- G. Developer-specific tells
- H. Workplace message tells
- I. Translationese (non-English text)

---

## A. Staging instead of stating

Strongest tells. One sighting justifies an edit.

**A1. Not X but Y.** "It's not just a fix, it's a rethink of the flow." / "No es solo un cambio de API, es una nueva forma de trabajar." Also the split version ("This doesn't mean X. It means Y.") and the clipped tail ("..., no guessing" / "..., sin complicaciones"). Keep a contrast only when the reader actually believes the negative half.

> Before: This isn't just a performance tweak; it's a fundamental change to how we cache.
> After: This changes the cache key from user ID to session ID, which cuts misses by about half.

**A2. One-line closers.** A short final sentence that restates the paragraph: "That's the real win." / "Y eso marca la diferencia." / "Simple, but effective." Cut it, or replace it with a consequence the paragraph didn't state.

**A3. Deep-sounding framing.** "The real question is", "At its core", "What really matters", "En el fondo", "La clave está en". Replace with the specific claim.

**A4. Run-ups.** "Let's dive in", "Here's the thing:", "Quick note:", "Heads up:", "Vamos al lío", "Te cuento:". Start with the point. (A real "heads up" in a Slack message about an outage is fine; the tell is the staged opener before a routine statement.)

**A5. Arguing with no one.** "To be clear, this isn't about blame", "I'm not saying the old approach was wrong", "No quiero decir que...", "One might be tempted to...". Remove the defense against an objection nobody raised.

## B. Chat residue and leftovers

Remove outright.

**B1. Chatbot wrappers.** "Certainly!", "Great question!", "Here's the updated...", "I hope this helps", "Let me know if you'd like me to...", "Feel free to reach out", "¡Por supuesto!", "Aquí tienes...", "Espero que te sea útil", "No dudes en contactarme". Particularly damaging when they leak into commits, code comments or PRs.

**B2. Knowledge-limit disclaimers.** "As of my last update", "Based on the available information", "Según la información disponible". State what isn't known, or cut it.

**B3. Writing about the document.** "This PR aims to address...", "The following changes were made:", "In this email I'd like to...", "El objetivo de este PR es...", "A continuación se detallan...". Say the thing.

**B4. Change narration in the artifact.** Comments or docs that describe the edit instead of the code: "Updated to use the new client", "Refactored for clarity", "Added error handling as requested", "Modificado para usar...". The commit message is where change history goes.

**B5. AI attribution.** `Co-Authored-By: Claude ...`, `Generated with [tool]`, "🤖", session URLs. See SKILL.md for the one exception.

## C. Inflation

The fact underneath is usually fine. Keep it, drop the dressing.

**C1. AI vocabulary.** English: delve, leverage, utilize, robust, comprehensive, seamless, crucial, pivotal, paramount, meticulous, intricate, holistic, streamline, enhance, elevate, empower, foster, bolster, showcase, underscore, highlight (verb), landscape (abstract), ecosystem (figurative), tapestry, testament, game-changing, cutting-edge. Spanish: robusto, integral, exhaustivo, fluido/sin fisuras, potenciar, impulsar, optimizar (as filler), fundamental, crucial, clave (as adjective), garantizar (as filler), "cabe destacar", "en el panorama actual", "un antes y un después". Technical uses are fine: "robust regression", "optimize the query plan".

**C2. Inflated significance.** "marks a pivotal step", "plays a key role", "lays the foundation for", "representa un hito", "sienta las bases". Ordinary changes are ordinary.

**C3. Sales voice.** "powerful", "blazing fast", "effortless", "a diverse array of", "potente", "de última generación". Describe what it does and, if you have them, the numbers.

**C4. Avoiding simple verbs.** "serves as", "functions as", "boasts", "features", "se erige como", "cuenta con" (when "tiene" works). Use is/has, es/tiene.

**C5. Shallow -ing tails.** "..., ensuring a smooth experience", "..., highlighting the importance of tests", "..., garantizando una experiencia fluida". Cut the tail or turn it into a real claim.

## D. Rhythm and formatting by rule

**D1. Forced triads.** "fast, reliable, and scalable", "rápido, seguro y escalable", three examples where one would do. Keep three only when there are really three.

**D2. Em dashes everywhere.** Replace em dashes (—) with commas, periods, colons or parentheses. En dashes in ranges (18:00–18:40, pages 3–7) are fine. Spanish uses the raya (—) legitimately for dialogue and some incisos in edited prose, but in technical and workplace text a stream of them is still a tell. Leave hyphens in code, flags, paths and compound words alone.

**D3. Bold as decoration.** Bold on terms throughout a paragraph, and bullet lists where every item starts with a bold label and colon (`- **Security:** ...`). Remove the bold; turn label lists into a sentence when the labels carry no information.

**D4. Template headings.** "Overview / Key Features / Benefits / Conclusion", "Resumen / Características principales / Conclusión", title case headings ("Getting Started With The API"), emoji headings, a horizontal rule between every section. Use sentence case and only the headings the reader needs.

**D5. Uniform structure.** Every paragraph the same length, every list exactly three items, every sentence 15 to 20 words. Real writing is uneven.

**D6. Curly quotes in plain-text targets.** “...” in commits, code, or Markdown that uses straight quotes elsewhere. Weak alone.

**D7. Comma chains.** One sentence carrying three or four ideas joined by commas and subordinate clauses: "Cuando el pedido se cancela, el sistema, si el pago ya se ha capturado, emite el reembolso, notificando al cliente por email, y libera el stock." Split into sentences of one idea each, and cut the clauses the reader doesn't need. A long sentence is fine when it reads easily; a sentence you have to read twice is not.

## E. Filler and hedging

**E1. Filler phrases.** "It's worth noting that", "It's important to mention", "In order to", "At the end of the day", "Es importante destacar que", "Cabe mencionar que", "Con el fin de", "A día de hoy". Delete; the sentence usually survives.

**E2. Hedge stacks.** "might potentially", "could possibly help in some cases", "podría llegar a ayudar en determinados casos". Keep one qualifier when the doubt is real.

**E3. Generic conclusions.** "In summary, these changes improve the overall quality of the codebase." / "En resumen, estos cambios mejoran la calidad general del código." End on the last concrete point.

**E4. Synonym cycling.** Calling the same thing "the service", "the module", "the component" and "the solution" in one paragraph. Pick the name the codebase uses and stick to it.

## F. Wrong reader

**F1. Re-explaining what the reader knows.** A review reply that restates the problem, walks through the diagnosis and shows proof before reaching the decision. A PR description that explains the architecture to the team that built it. Lead with the decision; keep only the fact the reader lacks and what they need to act.

> Before: You're right that this is a workaround. The underlying problem is that MergeService doesn't update pipeline_id when it reparents a child, which I confirmed by checking the audit log, where 6 of 123 merges are affected. Since MergeService is shared, I'd prefer a separate ticket.
> After: Agreed, it's a workaround. I'd rather fix MergeService in a separate ticket since it's shared code; only 6 rows need a backfill.

**F2. Over-complete answers to small questions.** A teammate asks "is staging down?" and gets five paragraphs. Answer the question; offer more if needed.

## G. Developer-specific tells

G1 to G4, G6 and G7 are about text and apply whenever the outbound switch is on, to text you write now. G5 and G8 change the code itself and apply only in code mode, to new code.

**G1. Narrating comments.** `# Import libraries`, `// Loop through items`, `# Return the result`, `# Paso 1: validar la entrada`. Delete; comment the why.

**G2. Tautological docstrings.** `"""Get user by ID."""` on `get_user_by_id`, "This function calculates the total". Say what the name doesn't: errors, side effects, units, edge cases. Or follow the project's convention if it requires a one-liner.

**G3. Exhaustive parameter docs** for obvious parameters in a codebase that doesn't do that elsewhere.

**G4. Chatty logs and errors.** (New messages only: existing strings may be matched by tests, alerts or clients.) `print("✅ Successfully processed all items!")`, `raise ValueError("Oops! Something went wrong. Please try again.")`. Match the project's log format; error messages state what failed and with which value.

**G5. Defensive clutter.** (Code mode only.) try/except around code that can't raise, `if x is not None` on non-optional values, fallback branches for impossible states, input re-validation after a type-checked boundary. Only if the codebase doesn't do this elsewhere.

**G6. Commit inflation.** `feat: implement comprehensive and robust error handling system` for a three-line change. Bodies that list every file touched.

**G7. PR boilerplate.** "## Summary / ## Changes / ## Benefits / ## Conclusion" with bold-label bullets, a "Benefits" section, and a closing line like "This PR significantly improves maintainability."

**G8. Generic names.** (Code mode only.) `data`, `result`, `info`, `handle_logic`, `process_data_helper`, `manager`, `utils2` where the domain has a better word.

## H. Workplace message tells

**H1. Formulaic openers.** "I hope this message finds you well", "I wanted to reach out to", "Espero que estés bien" as an automatic first line in a work message to a colleague, "Quería comentaros que". In an email to an external contact a brief greeting is normal; it's the stock phrase that reads machine-made.

**H2. Buried ask.** Context paragraph, then background, then the request in the last sentence. Put the ask or the news first.

**H3. Over-structured Slack.** Headings, bold labels and bullet lists in a three-line message. Write it as a message.

**H4. Formulaic closers.** "Please don't hesitate to reach out if you have any questions", "Quedo a vuestra disposición para cualquier duda", "Thanks in advance for your understanding!". Use a normal sign-off or none, as the channel calls for.

**H5. Emoji as structure.** 🚀 ✅ 📌 💡 at the start of lines. An emoji the team actually uses (a reaction, a :tada: on a launch) is fine.

## I. Translationese (non-English text)

Models often compose in English and render the result in the target language. The grammar is correct but the text sounds translated, and native readers notice at once. Write the way a native professional would. The examples are Spanish; every language has its own equivalents.

**I1. Calques.** Expressions translated word by word:

| Calque | Natural Spanish |
|---|---|
| golpear el servidor / la API | saturar, sobrecargar, hacer peticiones a |
| hace sentido | tiene sentido |
| jugar un rol / un papel clave | servir para, ser importante en |
| a nivel de código / a nivel de equipo | en el código, en el equipo (or drop it) |
| eventualmente (= finally) | al final, finalmente |
| en base a / basado en (everywhere) | según, a partir de, con |
| aplicar a un puesto | solicitar, presentarse a |
| asumir (= suppose) | suponer, dar por hecho |
| remover un archivo | quitar, eliminar, borrar |
| es por esto que | por eso |
| tomar ventaja de | aprovechar |
| fue implementado por el equipo | lo implementó el equipo / se implementó |

**I2. The trailing gerund.** A gerund tacked on at the end to add a consequence or a later action: "El servicio cayó, provocando errores en los pagos", "emite el reembolso, notificando al cliente por email". It mirrors the English -ing clause. In Spanish it's often incorrect (gerundio de posterioridad) and always heavy. Use a new sentence or a conjunction: "El servicio cayó y los pagos empezaron a fallar."

**I3. Unnecessary anglicisms.** English words where a common Spanish one exists: performance (rendimiento), feedback (comentarios, opinión), testear (probar), mergear (fusionar, integrar), deployar (desplegar), trackear (seguir, registrar), issue in prose to non-developers (incidencia, problema), random (aleatorio), approach (enfoque), workaround (solución provisional, apaño), update as a noun (novedades, actualización). Keep the terms that are standard in the field or that the team uses (jitter, backoff, commit, pull request, deploy, staging, endpoint). The test: would a senior Spanish-speaking engineer writing to this reader use the English word? If not, translate it.

**I4. English punctuation and casing.** Title Case In Headings, missing opening ¿ and ¡, quotes in "..." where the team uses «...», decimal points where the reader expects commas (0.5 s vs 0,5 s in prose), and a colon followed by a capital letter in ordinary text.

**I5. English word order and possessives.** "Su contraseña ha sido cambiada" (se ha cambiado tu contraseña), "por favor encuentre adjunto" (te adjunto), "mi equipo y yo estamos encantados de anunciar" (estrenamos...). Address the reader as the team does (tú or usted) and keep it consistent.
