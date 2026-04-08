-- REDOLOGS --
--------------
SET LINESIZE 600
COL MEMBER FORMAT A60
SELECT GROUP# "GROUP", STATUS, MEMBER
       , TYPE
       ,IS_RECOVERY_DEST_FILE
FROM SYS.V$LOGFILE
--WHERE GROUP# IN (1,2,3,4,5,6)
--AND TYPE <> 'STANDBY'
ORDER BY 1, 2;

----------------------------------------------


--Agregar REDO LOGS

ALTER DATABASE ADD LOGFILE THREAD 1 GROUP 1 ('+REDO01','+REDO02') SIZE 6G;
ALTER DATABASE ADD LOGFILE THREAD 2 GROUP 214 ('+REDO01','+REDO02') SIZE 6G;
--
--
/*
ALTER SYSTEM SWITCH LOGFILE
Este comando realiza un cambio de archivo de registro (log switch). Cuando se ejecuta, Oracle finaliza el archivo de registro actual y comienza a escribir en un nuevo archivo de registro. Esto es útil para:

Forzar un cambio de log: Se utiliza a menudo para asegurar que los cambios realizados en la base de datos se escriban en el archivo de registro, lo que puede ser importante antes de realizar ciertas operaciones de mantenimiento o respaldo.
Manejo de espacio: Ayuda a gestionar el espacio en disco al permitir que se archiven los archivos de registro antiguos.

ALTER SYSTEM CHECKPOINT;
Este comando fuerza un checkpoint en la base de datos. Un checkpoint es un proceso que:

Sincroniza los datos en memoria con el disco: Asegura que todos los cambios realizados en la memoria (buffer cache) se escriban en los archivos de datos en el disco.
Reduce el tiempo de recuperación: Ayuda a minimizar el tiempo necesario para recuperar la base de datos en caso de un fallo, ya que los datos más recientes se han escrito en el disco.

Resumen de la Función de los Comandos
Tres veces ALTER SYSTEM SWITCH LOGFILE;: Cambia el archivo de registro actual por tres veces, lo que puede ser útil para asegurar que se archiven los registros y se inicien nuevos, especialmente en contextos de alta disponibilidad o antes de respaldos.
ALTER SYSTEM CHECKPOINT;: Asegura que todos los cambios en la base de datos se escriban a disco, reduciendo el riesgo de pérdida de datos y mejorando la eficiencia de recuperación.

*/
ALTER SYSTEM SWITCH LOGFILE;
ALTER SYSTEM SWITCH LOGFILE;
ALTER SYSTEM SWITCH LOGFILE;
ALTER SYSTEM CHECKPOINT;
--
--

/*
1. ALTER DATABASE CLEAR LOGFILE GROUP 1;
Este comando se utiliza para limpiar el grupo de archivos de registro especificado (en este caso, el grupo 1).

Funciones:
Eliminar registros no archivados: Elimina todos los registros en el grupo de log que no han sido archivados. Esto es útil si deseas liberar espacio o si hay problemas con el grupo de log.
Reinicio del grupo de log: Este comando permite que el grupo de log se pueda reutilizar, ya que se eliminan los registros existentes.
Consideraciones:
Pérdida de datos: Si hay registros en el grupo que no han sido archivados, estos se perderán.
Uso en entornos de recuperación: Debe ser utilizado con precaución, especialmente en entornos de producción.
2. ALTER DATABASE DROP LOGFILE GROUP 1;
Este comando se utiliza para eliminar completamente el grupo de archivos de registro especificado.

Funciones:
Eliminar el grupo de log: Elimina el grupo de log del sistema, lo que significa que no se podrá utilizar más.
Liberar espacio: Puede ser útil si el grupo de log ya no es necesario y deseas liberar espacio en disco.
Consideraciones:
Pérdida de registros: Todos los registros en el grupo se perderán, lo que puede afectar la recuperación de la base de datos si no se han archivado.
No se puede eliminar un grupo de log activo: Debes asegurarte de que el grupo de log no esté en uso antes de intentar eliminarlo. Esto generalmente implica que debe ser un grupo de log que no está configurado como activo (online).
*/
ALTER DATABASE CLEAR LOGFILE GROUP 1;
ALTER DATABASE DROP LOGFILE GROUP 1;



nslookup
telnet 1536


telnet 180.183.150.72 1521
telnet 180.183.199.17 1521
telnet 180.183.199.207 1521
telnet 180.183.199.37 1521
telnet 180.183.199.38 1521
telnet 180.183.203.75 1521
telnet 180.183.170.83 1521
telnet 180.183.171.107 1521
telnet 180.183.171.108 1521
telnet 180.183.171.122 1521
telnet 180.183.171.161 1521
telnet 180.183.171.185 1521
telnet 180.183.199.10 1521
telnet 180.183.199.13 1521
telnet 180.183.199.141 1521
telnet 180.183.199.142 1521
telnet 180.183.199.162 1521
telnet 180.183.199.169 1521
telnet 180.183.199.170 1521
telnet 180.183.199.176 1521
telnet 180.183.199.177 1521
telnet 180.183.199.183 1521
telnet 180.183.199.184 1521
telnet 180.183.199.190 1521
telnet 180.183.199.191 1521
telnet 180.183.199.191 1521
telnet 180.183.199.198 1521
telnet 180.183.199.199 1521
telnet 180.183.199.223 1521
telnet 180.183.199.253 1521
telnet 180.183.199.36 1521
telnet 180.183.199.75 1521
telnet 180.183.203.131 1521
telnet 180.183.203.138 1521
telnet 180.183.203.139 1521
telnet 180.183.203.152 1521
telnet 180.183.203.156 1521
telnet 180.183.203.158 1521
telnet 180.183.203.159 1521
telnet 180.183.203.160 1521
telnet 180.183.203.170 1521
telnet 180.183.203.174 1521
telnet 180.183.203.175 1521
telnet 180.183.203.182 1521
telnet 180.183.203.183 1521
telnet 180.183.203.184 1521
telnet 180.183.203.185 1521
telnet 180.183.203.195 1521
telnet 180.183.203.198 1521
telnet 180.183.203.201 1521
telnet 180.183.203.212 1521
telnet 180.183.203.224 1521
telnet 180.183.203.225 1521
telnet 180.183.203.226 1521
telnet 180.183.203.230 1521
telnet 180.183.203.232 1521
telnet 180.183.203.234 1521
telnet 180.183.203.238 1521
telnet 180.183.203.26 1521
telnet 180.183.203.36 1521
telnet 180.183.203.63 1521
telnet 180.183.203.98 1521
