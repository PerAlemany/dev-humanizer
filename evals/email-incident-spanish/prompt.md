---
tags: [skill-creator]
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Skill, Write, Edit, Bash]
---

Redacta como si fueras humano un correo para Laura Gómez, responsable de sistemas de nuestro cliente Logística Norte, sobre la incidencia de ayer: entre las 18:00 y las 18:40 la API de facturación devolvió errores 502 porque un cambio de configuración en el balanceador dejó fuera dos de los tres nodos. Lo revertimos a las 18:38 y no se perdió ninguna factura: las peticiones fallidas se pueden reenviar. Hemos añadido una alerta y una revisión obligatoria para los cambios en el balanceador. Guárdalo en email.md
