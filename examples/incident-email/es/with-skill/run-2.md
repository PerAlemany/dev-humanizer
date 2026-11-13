Asunto: Errores 502 en la API de facturación ayer entre las 18:00 y las 18:40

Hola, Laura:

Ayer jueves, entre las 18:00 y las 18:40, la API de facturación devolvió errores 502 en torno al 60 % de las peticiones. De las vuestras fueron 214. Vuestra integración reintenta tres veces, así que una parte entró en los reintentos. Las que no entraron se pueden reenviar sin problema: la API es idempotente por número de factura y no se crearán duplicados.

No ha quedado nada a medias. Las peticiones que recibieron un 502 no llegaron a la aplicación, y todas las que recibieron un 200 en ese rato tienen su factura creada.

La causa fue un cambio que hicimos a las 17:55 en el health check de nuestro balanceador. El check nuevo consultaba una ruta que dos de los tres nodos no tienen, así que el balanceador los dio por caídos aunque funcionaban bien. Revertimos el cambio a las 18:38 y a las 18:40 ya no había errores.

Desde anoche tenemos una alerta que salta si quedan menos de dos nodos sanos. Hasta ahora solo avisábamos por la tasa de errores. Además, desde hoy cualquier cambio en el balanceador necesita un segundo revisor.

Sentimos las molestias.

Un saludo,
