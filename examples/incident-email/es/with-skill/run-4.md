Asunto: Errores 502 en la API de facturación ayer entre las 18:00 y las 18:40

Hola, Laura:

Ayer jueves, entre las 18:00 y las 18:40 aproximadamente, la API de facturación devolvió errores 502 en torno al 60 % de las peticiones. En ese rato, 214 peticiones vuestras recibieron un 502. Vuestra integración reintenta tres veces, así que parte de ellas entró después. Las que no entraron podéis reenviarlas sin riesgo de duplicar facturas, porque la API es idempotente por número de factura.

No hay ninguna factura a medias. Las peticiones que recibieron un 502 no llegaron a la aplicación, y todas las facturas que recibieron un 200 están creadas.

El fallo vino de un cambio nuestro. A las 17:55 modificamos la comprobación de salud del balanceador de carga y la apuntamos a una ruta que dos de los servidores de la API todavía no tenían. El balanceador los dio por caídos aunque funcionaban bien, y las peticiones que les mandaba fallaban. A las 18:40 revertimos el cambio y los errores desaparecieron.

Ya tenemos una alerta que salta en cuanto hay menos de dos servidores sanos detrás del balanceador. Hasta ahora solo avisábamos por la tasa de errores. Además, desde hoy cualquier cambio en el balanceador necesita la revisión de una segunda persona.

Sentimos las molestias.

Un saludo,
