LISTENER

-- Comandos por consola / ORACLE
ps -fe | grep tns

/*
La salida te mostrará líneas que contienen "tns", lo que te permitirá identificar si los procesos TNS están activos y obtener detalles como su PID y otros atributos.
*/

lsnrctl status 

/*
 Este comando permite determinar si el listener está en funcionamiento (activo) o no. 
 Si el listener está detenido, recibirás un mensaje indicando que no hay listener disponible
*/

lsnrctl status nombre_listener
/*
Este comando permite determinar un listener en especifico está en funcionamiento (activo) o no
*/

-- Validar el Strem de conexion 
cat $ORACLE_HOME/network/admin/tnsnames.ora




--Consideraciones por si esta abajo o arriba 

lsnrctl start
/* 
Si el listener no está en funcionamiento, puedes iniciarlo
*/

lsnrctl stop
/*
Si necesitas detenerlo, utiliza:
*/

