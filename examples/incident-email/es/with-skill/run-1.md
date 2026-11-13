Asunto: Errores 502 en la API de facturación el jueves 12, de 18:00 a 18:40

Hola, Laura:

Ayer, entre las 18:00 y las 18:40, la API de facturación devolvió errores 502 en alrededor del 60 % de las peticiones. En ese rato, 214 peticiones vuestras recibieron un 502. Vuestra integración reintenta tres veces, así que parte de ellas entraron después, pero puede que algunas facturas no se dieran de alta.

Esas facturas se pueden reenviar sin problema. El alta es idempotente por número de factura: si reenviáis una que ya había entrado, no se duplica. Tampoco ha quedado nada a medias. Las peticiones que recibieron un 502 no llegaron a la aplicación, y todas las facturas que recibieron un 200 en ese intervalo están guardadas.

La causa fue un cambio que hicimos a las 17:55 en el health check del balanceador. El check nuevo consultaba una ruta que no existe en dos de nuestros tres nodos, y el balanceador los dio por caídos aunque estaban bien. Revertimos el cambio a las 18:38 y a las 18:40 ya no había errores.

Para que no se repita, hemos añadido una alerta que salta si quedan menos de dos nodos sanos. Hasta ahora solo avisábamos por la tasa de errores. Además, desde hoy cualquier cambio en el balanceador necesita la revisión de una segunda persona.

Perdona las molestias.

Un saludo,
