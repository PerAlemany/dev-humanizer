Asunto: Errores en la API de facturación ayer, de 18:00 a 18:40

Hola, Laura:

Ayer, jueves 12, entre las 18:00 y las 18:40, la API de facturación devolvió errores 502 en torno al 60 % de las peticiones. En los logs del balanceador vemos 214 peticiones vuestras con 502 en ese intervalo.

Esas peticiones no llegaron a la aplicación, así que no quedó ninguna factura a medias. Las que recibieron un 200 se crearon con normalidad. Vuestra integración reintenta tres veces y parte de las que fallaron entraron en algún reintento. Las que agotaron los tres intentos se pueden reenviar sin riesgo de duplicados, porque la API es idempotente por número de factura.

La causa fue un cambio en el health check del balanceador de carga, hecho a las 17:55. El check nuevo consultaba una ruta que dos de nuestros tres nodos aún no tenían. El balanceador los dio por caídos aunque funcionaban bien, y de ahí los 502. Revertimos el cambio a las 18:38 y a las 18:40 ya no había errores.

Hemos añadido una alerta que avisa cuando quedan menos de dos nodos sanos. Hasta ahora solo saltaba por la tasa de errores. Además, desde hoy cualquier cambio en el balanceador necesita un segundo revisor.

Un saludo,
