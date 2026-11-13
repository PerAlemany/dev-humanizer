**Para:** Laura Gómez (Logística Norte)
**Asunto:** Incidencia en billing-api del jueves 12 de noviembre: errores 502 entre las 17:55 y las 18:40

Hola, Laura:

Te escribo por la incidencia que tuvo ayer, jueves 12 de noviembre, nuestra API de facturación (billing-api). Os afectó directamente: durante unos 45 minutos parte de vuestras peticiones recibió un error 502.

**Qué pasó**

A las 17:55 aplicamos un cambio en la configuración del balanceador que tenemos delante de billing-api. El cambio modificaba la comprobación de salud (health check) que usa el balanceador para saber qué servidores están disponibles. Dos de nuestros tres servidores no respondían en la nueva ruta de comprobación, así que el balanceador los dio por caídos, aunque en realidad estaban funcionando con normalidad. A partir de ahí, alrededor del 60 % de las peticiones recibió un 502.

Saltó la alarma a las 18:02. Tras localizar la causa, revertimos el cambio y a las 18:40 los tres servidores volvían a estar operativos y la tasa de errores había bajado a cero. La reversión tardó más de lo que debería por un bloqueo en nuestra herramienta de despliegue de infraestructura, que tuvimos que liberar a mano.

**Cómo os afectó**

- Según los registros del balanceador, 214 peticiones de Logística Norte recibieron un 502 durante la incidencia.
- Esas peticiones no llegaron a la aplicación. No se creó ninguna factura a medias ni duplicada.
- Las peticiones que recibieron una respuesta correcta (200) se registraron bien. Lo hemos comprobado en nuestra tabla de facturas.
- Vuestra integración reintenta cada petición hasta 3 veces, así que una parte de esas 214 entró en algún reintento. Las que agotaron los 3 intentos no se procesaron.

**Qué os pedimos**

Revisad qué facturas de ayer entre las 17:55 y las 18:40 acabaron en error después de los reintentos y volved a enviarlas. Reenviarlas es seguro: la API es idempotente por número de factura, así que una factura que ya entró no se creará dos veces. Si os viene mejor, podemos ayudaros a cruzar vuestro listado con lo que tenemos registrado.

**Qué hemos cambiado**

- Hemos añadido una alerta que salta en cuanto haya menos de dos servidores sanos detrás del balanceador. Hasta ahora solo nos avisaba la tasa de errores, que llega más tarde.
- Desde hoy, cualquier cambio en la configuración del balanceador necesita la revisión de una segunda persona antes de aplicarse.

Sentimos las molestias que esto os haya causado. Si te surge cualquier duda o necesitas ayuda con el reenvío, escríbeme directamente.

Un saludo,

[Tu nombre]
[Cargo] · [Teléfono]
