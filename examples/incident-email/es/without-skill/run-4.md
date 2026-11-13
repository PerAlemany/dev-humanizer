**Asunto:** Errores 502 en billing-api ayer, 12 de noviembre, entre las 18:00 y las 18:40

Hola, Laura:

Ayer por la tarde, entre las 18:00 y las 18:40, billing-api devolvió errores 502 a una parte de las peticiones. Desde las 18:40 funciona con normalidad. Te cuento qué pasó y qué tenéis que revisar.

**Cómo os afectó**

En ese rato nos llegaron 214 peticiones vuestras que recibieron un 502. Vuestra integración reintenta tres veces, así que muchas entraron en uno de los reintentos. Las que agotaron los tres intentos no llegaron a registrarse.

Esas se pueden reenviar tal cual. La API es idempotente por número de factura: si reenviáis una que sí entró, no se crea un duplicado. Si no tenéis claro cuáles entraron en un reintento, podéis reenviar todas las que dieron error.

Hemos revisado la tabla de facturas. Todas las que recibieron un 200 en ese intervalo están guardadas. Las peticiones que recibieron un 502 no llegaron a la aplicación, así que no hay ninguna factura a medias.

**Qué pasó**

A las 17:55 cambiamos la configuración del health check de nuestro balanceador. El check nuevo consultaba una ruta que dos de nuestros tres servidores todavía no tenían. Los servidores estaban bien, pero el balanceador los dio por caídos y respondió con 502 a la parte del tráfico que les tocaba, alrededor del 60 %.

Saltó la alerta a las 18:02. Tardamos en revertir el cambio porque una tarea automática bloqueaba la herramienta con la que aplicamos la configuración. A las 18:38 el balanceador volvió a ver sanos los tres servidores, y a las 18:40 ya no había errores.

**Qué cambiamos**

- Desde anoche tenemos una alerta que salta en cuanto el balanceador ve menos de dos servidores sanos. Hasta ayer solo avisábamos por tasa de errores.
- Desde hoy, cualquier cambio en el balanceador necesita la revisión de una segunda persona antes de aplicarse.

Siento las molestias. Si al reenviar veis algo raro, o queréis que miremos alguna petición concreta, escríbeme y lo vemos.

Un saludo,

[Tu nombre]
