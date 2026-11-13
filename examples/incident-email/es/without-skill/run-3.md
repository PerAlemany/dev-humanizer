**Para:** Laura Gómez (Logística Norte)
**Asunto:** Incidencia en la API de facturación de ayer, 12 de noviembre (17:55–18:40)

Hola, Laura:

Te escribo para contarte qué pasó ayer por la tarde con la API de facturación y cómo os afectó.

**Qué pasó**

Entre las 17:55 y las 18:40, alrededor del 60 % de las peticiones a la API recibieron un error 502. A las 17:55 cambiamos la configuración del balanceador de carga para que comprobara el estado de los servidores en una ruta nueva. Dos de los tres servidores todavía no tenían esa ruta, así que el balanceador los dio por caídos aunque funcionaban bien, y las peticiones que les correspondían fallaron. Deshicimos el cambio a las 18:38 y a las 18:40 ya no había errores.

**Cómo os afectó**

En ese tiempo, 214 peticiones vuestras recibieron un 502. Esas peticiones se quedaron en el balanceador y no llegaron a la aplicación, así que no se procesaron ni a medias: no hay facturas incompletas ni duplicadas. Hemos comprobado que todas las facturas que recibieron un 200 en ese tiempo están registradas.

Vuestra integración reintenta tres veces, así que parte de esas 214 entró en un reintento posterior. Las que no hayan entrado se pueden reenviar sin riesgo, porque la API identifica cada factura por su número y no la crea dos veces. Si os sirve, os pasamos el listado de las 214 peticiones con su hora para que podáis cruzarlo con lo vuestro.

**Qué hemos cambiado**

- Hasta ahora solo saltaba una alerta cuando subía la tasa de errores. Desde ayer también salta en cuanto quedan menos de dos servidores sanos, así que un caso como este lo veríamos antes.
- Desde hoy, cualquier cambio en el balanceador necesita la revisión de una segunda persona antes de aplicarse.

Siento las molestias. Si tenéis cualquier duda o queréis revisar algún caso concreto, dímelo.

Un saludo,

[Tu nombre]
