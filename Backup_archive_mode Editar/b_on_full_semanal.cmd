# Genera backups a media externa segun patrones pre-establecidos
# Alejandro Granadillo - NM36398 - 23-06-19
# El nombre exacto de la instancia
# INSTANCE=DCSP
# El tipo de backup: ONLINE_FULL, ONLINE_SEMANAL, ONLINE_MENSUAL
# TYPE=ONLINE_SEMANAL

# Retencion en dias
# 1, 15, 30, 90, 365, 1825, 3650
# RET=183

run {
  SQL 'ALTER SYSTEM SWITCH LOGFILE';
  SQL 'ALTER SYSTEM SWITCH LOGFILE';
  SQL 'ALTER SYSTEM SWITCH LOGFILE';
}

run {
  # Paralelismo a nivel de media layer
  # Para el caso de networker se debe eliminar los parametros
  # SBT_LIBRARY=/path/XYZ cablea directamente una libreria SBT
  ALLOCATE CHANNEL T1 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T2 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T3 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T4 TYPE 'SBT_TAPE';

  SET COMMAND ID TO 'DCSP_SEMANAL ';

  # BackUp de la Base de Datos
  BACKUP FULL FORMAT '%d_SEMANAL_%T_%s'
  TAG DCSP_ONLINE_SEMANAL
  # FILESPERSET 16

  # Tiempo de retencion
  KEEP UNTIL TIME 'SYSDATE+32'

  (DATABASE INCLUDE CURRENT CONTROLFILE);

  # BackUp de Archives
  SQL 'ALTER SYSTEM ARCHIVE LOG CURRENT';

  BACKUP FORMAT '%d_ARCHIVE_%T_%s' ARCHIVELOG ALL
  TAG DCSP_ARC_SEM

  # Se limita el numero de archivos
  # para forzar liberacion rapida en media/FS/ASM
  FILESPERSET 1

  # Tiempo de retencion
  KEEP UNTIL TIME 'SYSDATE+94'

  # Si se desea tener redundancia de BackUps
  NOT BACKED UP 3 TIMES

  DELETE INPUT;

  # BackUp de otros elementos
  BACKUP CURRENT CONTROLFILE FORMAT '%d_CONTROLFILE_%T_%s'
SPFILE FORMAT '%d_SPFILE_%T_%s';

  RELEASE CHANNEL T1;
  RELEASE CHANNEL T2;
  RELEASE CHANNEL T3;
  RELEASE CHANNEL T4;

  RESYNC CATALOG;
}


