**Asunto:** Errores 502 en billing-api ayer, de 17:55 a 18:40

Hola, Laura:

Te escribo por los errores 502 que vuestra integración recibió ayer por la tarde en billing-api. Sentimos las molestias.

Ayer a las 17:55 cambiamos la comprobación de salud del balanceador que está delante de billing-api. La comprobación nueva consultaba una ruta que solo existe en la versión más reciente del servicio, y dos de los tres servidores todavía tenían la anterior. Aunque esos dos funcionaban bien, el balanceador los dio por caídos y respondió con 502 a cerca del 60 % de las peticiones. Lo vimos a las 18:02 por las alertas. Revertir el cambio nos llevó más de lo que debería por un bloqueo en nuestra herramienta de despliegue, y quedó deshecho a las 18:38. Desde las 18:40 no ha vuelto a haber errores.

Sobre vuestras facturas: las peticiones que recibieron un 502 no llegaron a la aplicación, así que no hay ninguna factura creada a medias. Hemos comprobado que todas las que recibieron un 200 en ese rato están guardadas. En los logs del balanceador hay 214 peticiones vuestras con 502. Como vuestra integración reintenta tres veces, una parte entró en algún reintento. Las que no entraron podéis reenviarlas sin riesgo de duplicados, porque billing-api reconoce el número de factura y no crea la misma dos veces. Si os viene mejor, cruzamos nosotros esas 214 peticiones con las facturas guardadas y os pasamos la lista de las que faltan.

Para que no se repita, hemos añadido una alerta que salta en cuanto quedan menos de dos servidores sanos (hasta ayer solo avisábamos por el porcentaje de errores), y desde hoy cualquier cambio en el balanceador necesita que lo revise una segunda persona antes de aplicarse. Nos queda averiguar por qué los tres servidores no tenían la misma versión; cuando lo sepamos te lo cuento.

Si tienes cualquier duda, dime.

Un saludo,
[tu nombre]
