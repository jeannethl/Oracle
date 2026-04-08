# El nombre exacto de la instancia
# INSTANCE=DCSP1
# Retencion en dias
# 1, 15, 30, 90, 365, 1825, 3650
# RET=3650


RUN {
  # Paralelismo a nivel de media layer
  # Para el caso de networker se debe eliminar los parametros
  ALLOCATE CHANNEL T1 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T2 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T3 TYPE 'SBT_TAPE';
  ALLOCATE CHANNEL T4 TYPE 'SBT_TAPE';

  # BackUp especial de Archives que va con el BackUp On Full Mensual con retencion de 10 años
  SET COMMAND ID TO 'DCSP1_BE_ARCHIVE_FULL_MEN';
  BACKUP FORMAT 'bea10A_%s_%p_%t'
  TAG DCSP1_BE_ARCHIVE_FULL_MEN
  # Se limita el numero de archivos
  # para forzar liberacion rapida
  FILESPERSET 1

  # Si se desea tener redundancia de BackUps
  NOT BACKED UP 3 TIMES

  # Tiempo de retencion
  KEEP UNTIL TIME 'SYSDATE+3650'

  (ARCHIVELOG ALL DELETE INPUT);

  RELEASE CHANNEL T1;
  RELEASE CHANNEL T2;
  RELEASE CHANNEL T3;
  RELEASE CHANNEL T4;

  RESYNC CATALOG;
}


