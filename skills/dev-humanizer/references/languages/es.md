# Español

Léelo cuando el usuario te hable en español o cuando el texto que vas a escribir esté en español. Completa `SKILL.md` y `patterns.md`; no los sustituye.

## Cómo lo piden

Reconoce la petición por lo que significa, no por las palabras exactas. Estas son las formas habituales:

| Modo | Peticiones típicas |
|---|---|
| Redacción | «humaniza este commit», «humaniza redacción», «humaniza a partir de ahora», «escribe como un humano», «que no parezca IA» |
| Código | «humaniza código», «programa como un humano», «escribe el código como un humano», «que el código no parezca de IA» |
| Conversación | «humaniza conversación», «háblame como un humano», «no me hables como un robot» |
| Todo | «humanízate», «humanízalo todo», «modo completo» |

«Humaniza» sin más es el modo redacción. «Humanízate» lo activa todo. «Explícame como un humano» va sobre tu respuesta, así que es el modo conversación.

Para apagar: «sin modo código» apaga el código y mantiene la redacción; «sin modo conversación» apaga la conversación; «sin modo redacción» apaga la redacción y, con ella, el código; «vuelve a lo normal» o «deja de humanizar» lo apagan todo.

Cuánto dura:

- Una tarea concreta vale solo para esa tarea: «humaniza este commit», «escribe como un humano un mensaje para mi jefa», «explícame como un humano la arquitectura de esta app».
- Sin tarea, o dicho en general, dura hasta que digan lo contrario: «escribe como un humano», «háblame como un humano», «a partir de ahora programa como un humano», «humanízate». «A partir de ahora escribe como un humano y haz el commit» también es general.
- Con un límite explícito, se respeta: «durante esta tarde», «hasta que hagamos merge», «solo para los correos», «solo en este repo».

No la activan las tareas de formato de datos, como «humaniza el formato de las fechas» o «añade una función humanize() para los tamaños en bytes».

## La línea de estado

Los modos se llaman Redacción, Código y Conversación, como en el README en español.

```text
dev-humanizer: activado para la redacción y la conversación. Código apagado.
Añádelo con «humaniza código»; apaga un modo con «sin modo conversación», o todo con «vuelve a lo normal».
```

```text
dev-humanizer: activado solo para este commit. Di «a partir de ahora» para mantenerlo.
```

```text
dev-humanizer: apagado, ya ha terminado la tarde.
```

## Rastros de IA en español

Las mismas familias que en `patterns.md`, con su forma en español.

- **A1. «No es X, es Y».** «No es solo un cambio de API, es una nueva forma de trabajar», y la coletilla final («…, sin complicaciones»).
- **A2. Frases de cierre.** «Y eso marca la diferencia.»
- **A3. Profundidad impostada.** «En el fondo», «La clave está en».
- **A4. Arranques.** «Vamos al lío», «Te cuento:».
- **A5. Discutir con nadie.** «No quiero decir que…».
- **B1. Restos de chat.** «¡Por supuesto!», «¡Claro!», «Aquí tienes…», «Espero que te sea útil», «No dudes en contactarme».
- **B2. Límites del modelo.** «Según la información disponible».
- **B3. Hablar del propio texto.** «El objetivo de este PR es…», «A continuación se detallan…», «En este mensaje os quiero comentar…».
- **B4. Narrar el cambio en el código.** «Modificado para usar…».
- **C1. Vocabulario de IA.** robusto, integral, exhaustivo, fluido o «sin fisuras», potenciar, impulsar, optimizar (de relleno), fundamental, crucial, clave (como adjetivo), garantizar (de relleno), «cabe destacar», «en el panorama actual», «un antes y un después».
- **C2. Importancia inflada.** «representa un hito», «sienta las bases».
- **C3. Tono de anuncio.** «potente», «de última generación».
- **C4. Evitar los verbos simples.** «se erige como», «cuenta con» cuando basta con «tiene». Usa «es» y «tiene».
- **C5. Coletillas en gerundio.** «…, garantizando una experiencia fluida».
- **D1. Tríadas forzadas.** «rápido, seguro y escalable».
- **D4. Títulos de plantilla.** «Resumen / Características principales / Conclusión». En español, los títulos llevan mayúscula solo en la primera palabra.
- **D7. Frases encadenadas con comas.** «Cuando el pedido se cancela, el sistema, si el pago ya se ha capturado, emite el reembolso, notificando al cliente por email, y libera el stock.»
- **E1. Relleno.** «Es importante destacar que», «Cabe mencionar que», «Con el fin de», «A día de hoy».
- **E2. Cautelas apiladas.** «podría llegar a ayudar en determinados casos».
- **E3. Conclusiones genéricas.** «En resumen, estos cambios mejoran la calidad general del código.»
- **H1. Saludos de manual.** «Espero que estés bien» como primera línea automática a un compañero, «Quería comentaros que».
- **H4. Despedidas de manual.** «Quedo a vuestra disposición para cualquier duda».
- **Rótulos con dos puntos.** «Lo que cambia:», «Para que no vuelva a pasar:». Dilo en una frase normal: «Además, ahora…».

Una frase, una idea. Antes:

```
# Renovamos el token a los 50 minutos, aunque caduca a la hora,
# porque si una petición sale justo antes de la caducidad, el
# servidor la rechaza, obligando al cliente a repetirla.
```

Después:

```
# El token caduca a la hora. Lo renovamos a los 50 minutos para
# que ninguna petición salga con un token a punto de caducar.
```

## Traducción literal

El modelo suele componer en inglés y pasarlo al español. La gramática sale bien, pero suena a traducción y quien lo lee en su idioma lo nota enseguida.

**Calcos.**

| Calco | En español |
|---|---|
| golpear el servidor / la API | saturar, sobrecargar, hacer peticiones a |
| hace sentido | tiene sentido |
| jugar un rol / un papel clave | servir para, ser importante en |
| a nivel de código / a nivel de equipo | en el código, en el equipo (o quitarlo) |
| eventualmente (= al final) | al final, finalmente |
| en base a / basado en (para todo) | según, a partir de, con |
| aplicar a un puesto | solicitar, presentarse a |
| asumir (= suponer) | suponer, dar por hecho |
| remover un archivo | quitar, eliminar, borrar |
| es por esto que | por eso |
| tomar ventaja de | aprovechar |
| fue implementado por el equipo | lo implementó el equipo / se implementó |

**El gerundio de posterioridad.** Un gerundio al final que añade una consecuencia o algo que pasa después: «El servicio cayó, provocando errores en los pagos», «emite el reembolso, notificando al cliente por email». Copia la oración en -ing del inglés. En español suele ser incorrecto y siempre pesa. Usa otra frase o una conjunción: «El servicio cayó y los pagos empezaron a fallar.»

**Anglicismos innecesarios.** Palabras inglesas donde hay una española de uso común: performance (rendimiento), feedback (comentarios, opinión), testear (probar), mergear (fusionar, integrar), deployar (desplegar), trackear (seguir, registrar), issue en un texto para quien no programa (incidencia, problema), random (aleatorio), approach (enfoque), workaround (solución provisional, apaño), update como sustantivo (novedades, actualización). Se quedan los términos que son estándar en el oficio o que usa el equipo: jitter, backoff, commit, pull request, deploy, staging, endpoint. La prueba: ¿usaría esa palabra en inglés un ingeniero sénior hispanohablante que escribe a este lector? Si no, tradúcela.

**Puntuación y mayúsculas inglesas.** Mayúscula En Cada Palabra De Un Título, signos de apertura ¿ y ¡ que faltan, comillas "…" donde el equipo usa «…», punto decimal donde el lector espera coma (0,5 s en un texto, no 0.5 s) y mayúscula después de dos puntos en un texto normal.

**Orden y posesivos del inglés.** «Su contraseña ha sido cambiada» (se ha cambiado tu contraseña), «por favor encuentre adjunto» (te adjunto), «mi equipo y yo estamos encantados de anunciar» (estrenamos…). Trata al lector como lo hace el equipo, de tú o de usted, y mantenlo.
