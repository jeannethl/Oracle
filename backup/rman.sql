rman target=/ catalog RMAN/ cmdfile=b_archive.cmd LOG=${LOG} APPEND using ${ORACLE_SID}
/*
Desglose del Comando

rman target=/: Esto indica que RMAN se conectará a la base de datos objetivo sin usar un usuario específico (es decir, se conecta con el usuario que tiene privilegios suficientes para realizar operaciones de respaldo y recuperación).

catalog RMAN_CLEARING/Clearing2020@RMANCATALOG: Aquí se especifica la conexión al catálogo de recuperación de RMAN. Significa que se está utilizando un usuario llamado RMAN_CLEARING con la contraseña Clearing2020 para conectarse a un servicio de base de datos llamado RMANCATALOG. El catálogo de recuperación almacena información sobre los backups realizados.

cmdfile=${DIR}/backup_full_CLEARING.cmd: Esta opción indica que RMAN debe ejecutar un archivo de comandos específico, en este caso, backup_full_CLEARING.cmd, que se encuentra en el directorio especificado por la variable ${DIR}. Este archivo contiene una serie de comandos de RMAN que se ejecutarán.

LOG=${LOG}: Esta opción especifica que la salida del log de la operación se guardará en el archivo cuyo nombre se define en la variable ${LOG}. Esto es útil para revisar el resultado de la operación más tarde.

APPEND: Esta opción indica que el log de la operación se añadirá al archivo de log existente en lugar de sobrescribirlo. Esto permite mantener un historial completo de las operaciones realizadas.

using ${ORACLE_SID}: Esto indica que se utilizará la instancia de Oracle especificada en la variable ${ORACLE_SID}. Esta variable debe estar definida en el entorno y representa el identificador del sistema de la base de datos de Oracle con la que se está trabajando.
*/
