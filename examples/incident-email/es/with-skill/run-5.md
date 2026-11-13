Asunto: Errores en la API de facturación el jueves 12 de noviembre, de 18:00 a 18:40

Hola, Laura:

Ayer, jueves, entre las 18:00 y las 18:40 aproximadamente, nuestra API de facturación devolvió un error 502 en torno al 60 % de las peticiones. De las vuestras fueron 214.

Ninguna factura ha quedado a medias. Las peticiones que recibieron un 502 no llegaron a la aplicación, y todas las que recibieron un 200 en ese rato están registradas. Vuestra integración reintenta tres veces, así que parte de esas 214 entró después. Las que no entraron se pueden reenviar sin riesgo de duplicados, porque la API es idempotente por número de factura.

La causa fue un cambio en el health check del balanceador de carga, hecho a las 17:55. La nueva comprobación consultaba una ruta que dos de nuestros tres servidores no tienen, y el balanceador los dio por caídos aunque funcionaban bien. Revertimos el cambio a las 18:38 y a las 18:40 ya no había errores.

Desde anoche tenemos una alerta que salta si quedan menos de dos servidores sanos. Hasta ahora solo avisábamos por la tasa de errores. Y desde hoy cualquier cambio en el balanceador necesita la revisión de una segunda persona.

Un saludo,
