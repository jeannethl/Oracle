# Genera backups a media externa segun patrones pre-establecidos
# Alejandro Granadillo - NM36398 - 23-06-19
# El nombre exacto de la instancia
# INSTANCE=DCSP
# Retencion en dias
# 1, 15, 30, 90, 365, 1825, 3650
# RET=94
# MODIFICADO PARA QUE EL NOMBRE DEL BACKUPPIECE SEA AUTOCONTENIDO JMB 27/10/2022
RUN {
  # Paralelismo a nivel de media layer
  # Para el caso de networker se debe eliminar los parametros
  ALLOCATE CHANNEL T1 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T2 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T3 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T4 TYPE 'SBT_TAPE';

  SET COMMAND ID TO 'BACKUP_ARCHIVES';
  BACKUP FORMAT '%d_ARCHIVE_%T_%s'
  TAG DCSP_ARCHIVE
  # Se limita el numero de archivos
  # para forzar liberacion rapida
  FILESPERSET 1

  # Si se desea tener redundancia de BackUps
  NOT BACKED UP 3 TIMES

  # Tiempo de retencion
  KEEP UNTIL TIME 'SYSDATE+94'

  (ARCHIVELOG ALL DELETE INPUT);

  RELEASE CHANNEL T1;
  RELEASE CHANNEL T2;
  RELEASE CHANNEL T3;
  RELEASE CHANNEL T4;

  RESYNC CATALOG;
}


