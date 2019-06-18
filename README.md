# README

## General
Contar con
- Versión Ruby: 2.6.2
- Versión Rails: 6.0.0.rc1
- Motor de base de datos: Postgresql
- Motor tareas en segundo plano: Redis

## Intrucciones de uso

Recomendaciones para la ejecución de la aplicación mediante el uso del procfile:
- Clonar repositorio.
- Agregar .env para la ejecución del proyecto
- Ejecutar bundle install y rake db:setup.
- Descargar Heroku CLI, las instrucciones se pueden encontrar en https://devcenter.heroku.com/articles/heroku-cli.
- Situarse en el directorio de la aplicación y ejecutar 'heroku local'. Por defecto se utiliza el puerto 5000.

## Descripción

El sistema es una web api construida con rails. Cuenta con 4 grandes modelos
- Company: objecto base que describe la compañía dueña de las bicicletas.
- Station: objeto base que describe la ubicación de los estacionamientos de bicicletas.
- Telemetry: objeto que mantiene la data leída de la API.
- HeartbeatTelemetry: objeto para generar reportes de la utilización de la red.

El funcionamiento base consiste en una tarea en background que se ejecuta cada 1 minuto. Completada la lectura, se genera un resumen de los datos totales, para consolidar la información en el objecto HeartbeatTelemetry que se mencionó anteriormente.

Por otra parte, tiene 3 rutas que sirven a la aplicación fronted:
- index: devuelve una lista de todos las estaciones y sus últimos valores recibidos.
- daily_indicators: devuelve KPIS de los últimos valores, así como también el formato para el día actual.
- last_hour: devuelve una lista con todos los objectos HeartbeatTelemetry de la última hora.



