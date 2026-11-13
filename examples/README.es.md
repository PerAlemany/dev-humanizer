# Ejemplos

[English](README.md) | Español

Todas las ejecuciones detrás del ejemplo del [README principal](../README.es.md), para que puedas compararlo con las notas y con las demás ejecuciones.

`incident-email/` tiene una carpeta por idioma. En cada una están las notas de guardia que recibió el modelo (`notes.txt`), la petición (`prompt.txt`) y cinco correos por lado: `without-skill/` con la petición tal cual y `with-skill/` con la misma petición más «Escríbelo como un humano.». Los diez salieron de Claude Opus 5.5 en Claude Code, cada uno en una ejecución de agente aparte con su propia copia de las notas. Las ejecuciones con la skill usaron la versión actual.

El README enseña la ejecución de longitud mediana en caracteres de cada lado, fijada por esa regla y no por haberlas leído: en español, la 4 sin la skill y la 3 con ella; en inglés, la 4 y la 5.

## Cómo se eligió el ejemplo

Se probaron ocho tipos de tarea en los dos idiomas, con dos variantes cada uno: descripciones de PR, notas de versión, resúmenes semanales, correos a clientes, comentarios de revisión, commits, respuestas en Slack y cambios de código. Claude Fable 5.2 diseñó las tareas y juzgó los resultados, pero no escribió ninguno de los textos comparados.

1. Dos evaluadores a ciegas por idioma leyeron cada par sin etiquetas y dijeron de cada texto si lo había escrito una IA o una persona. Algunos pares eran trampas, con los dos textos del mismo lado.
2. Una tarea seguía adelante si los dos evaluadores veían de IA el texto sin la skill, con seguridad 4 o 5, y veían humano el texto con la skill, sin encontrarle rastros.
3. Las tareas que siguieron se ejecutaron cinco veces por lado. Con las etiquetas a la vista, los evaluadores contaron los rastros de los diez textos. Una tarea solo pasaba si al menos cuatro de los cinco textos sin la skill tenían dos rastros o más y ninguno de los cinco con ella tenía ninguno.
4. Los mismos evaluadores compararon el par que se enseña con las notas: el texto con la skill no puede perder nada que necesite su lector ni decir nada que no esté en las notas.

La skill se corrigió dos veces durante el proceso, a partir de lo que encontraron los evaluadores. La primera versión aún dejaba rótulos con dos puntos, huecos como «[tu nombre]» y frases de cierre de manual. La segunda quitaba hallazgos reales de los comentarios de revisión y convertía «parte entró en un reintento» en «muchas». Las dos correcciones están en la versión actual, y los cinco correos con la skill de cada idioma se escribieron con ella.

Tras la última corrección, el correo de incidencia pasó todos los pasos en los dos idiomas. Los comentarios de revisión, las respuestas en Slack, las descripciones de PR, las notas de versión y los resúmenes semanales pasaron algunos pasos, pero no todos, y en los cambios de código apenas hubo diferencia. En los commits, la única diferencia que salió siempre fue la línea de atribución a la IA.

## Límites

- El lado con la skill recibe además la frase «Escríbelo como un humano.», y no hubo ninguna ejecución con esa frase y sin la skill. Parte de la diferencia puede deberse solo a la frase.
- Solo el par que se enseña se comprobó línea a línea con las notas. En `es/with-skill/run-4.md` el cambio se revierte a las 18:40; las notas dicen 18:38.
- Cinco ejecuciones por lado es una muestra pequeña, y los rastros los contaron modelos, no personas.
