**Para:** Laura Gómez (Logística Norte)
**Asunto:** Incidencia en la API de facturación ayer, 12 de noviembre, de 17:55 a 18:40: 214 peticiones vuestras con error 502

Hola, Laura:

Ayer por la tarde, entre las 17:55 y las 18:40, la API de facturación devolvió errores 502 a una parte de las peticiones. En los registros de nuestro balanceador vemos **214 peticiones de Logística Norte que recibieron un 502** en ese intervalo.

**Lo que tenéis que revisar:** vuestra integración reintenta 3 veces, así que muchas de esas facturas entraron en un reintento posterior. Las que no llegaron a entrar podéis reenviarlas sin miedo: la API es idempotente por número de factura, así que si alguna ya existe no se duplica. Si os resulta útil, os mandamos el listado de las 214 peticiones con su hora para que lo crucéis con vuestro sistema.

**No se ha perdido ni corrompido ningún dato.** Hemos revisado las facturas creadas en ese intervalo: todas las que recibieron un 200 están registradas correctamente. Las peticiones que recibieron un 502 no llegaron a la aplicación, así que no hay ninguna factura a medias.

**Qué pasó:** a las 17:55 aplicamos un cambio en la comprobación de salud del balanceador. La nueva comprobación usaba una ruta que dos de nuestros tres servidores no tenían, así que el balanceador los dio por caídos aunque funcionaban con normalidad. Durante ese tiempo, alrededor del 60 % de las peticiones fallaron. Revertimos el cambio a las 18:38 y a las 18:40 la tasa de errores ya estaba a cero. Desde entonces el servicio funciona con normalidad.

**Qué hemos cambiado para que no se repita:**

- Ya tenemos una alerta que salta en cuanto quedan menos de dos servidores sanos detrás del balanceador. Hasta ayer solo nos avisaba la tasa de errores.
- Desde hoy, cualquier cambio en el balanceador necesita la revisión de una segunda persona antes de aplicarse.
- Estamos revisando por qué los servidores no tenían la misma versión, que es lo que hizo que el cambio fallara solo en dos de ellos.

Sentimos las molestias. Si veis alguna factura que no cuadre o necesitáis el listado, dímelo y lo miramos enseguida.

Un saludo,

[Tu nombre]
[Cargo / equipo]
[Teléfono de contacto]
