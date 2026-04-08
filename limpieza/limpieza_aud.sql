

SHOW PARAMETER audit_file_dest;

/u01/app/oracle/product/19c/dbhome_1/rdbms/log/audit

find /oracle/app/oracle/admin/ENTITIDP -name "*.aud" -mtime +40 -exec rm -rf {} \;

find /oracle -name "*.aud" -mtime +15 -exec rm -rf {} \;

find /oracle/app/oracle/admin/ENTITIDP/adump -name "*.aud" -newermt "2024-11-01" ! -newermt "2024-12-01" -exec rm -rf {} \;

du -h /oracle | sort -nr | head -10

find . -name "*.aud" -mtime +15 -exec rm -rf {} \;


#!/bin/bash

# Nelson Diaz - DBA Team - ADSI
# limpieza_trace.sh

SECONDS=0 ## Variable para medir el tiempo de ejecucion
LOG=/tmp/limpieza_trace_oracle.log

# ORACLE_HOME del usuario especificado
USER=oracle11
DIR=/oracle/app/oracle # oracle base
#USER=grid
#DIR=/oracle/app/grid # grid base

for i in trm trc log_*.xml
do
echo "$(date +'%Y%m%d %H:%M:%S') - Inicio limpieza ${i} " | tee -a $LOG

find $DIR/ -name "*.${i}*" -ctime +90 -ls -exec rm -f {} \; >/tmp/listado_${i}_trace_${USER}.txt

find $DIR/ -name "*.aud" -mtime +15 -exec rm -rf {} \;

echo "$(date +'%Y%m%d %H:%M:%S') - Fin limpieza ${i}\n " | tee -a $LOG
done

## Calculo de tiempo de ejecucion
DURATION=$SECONDS
HOUR_END=$(($DURATION/3600))
MIN_END=$(($DURATION%3600/60))
SEC_END=$(($DURATION%60))
echo "Duracion del proceso limpieza:  ${HOUR_END}h ${MIN_END} min ${SEC_END} secs." | tee -a $LOG

----------------------------------------------------------------------------------------------------------------------------------------------
find /oracle/app/oracle/diag/tnslsnr/sun18qz1/listener112/alert -name -ctime +90 -ls -exec rm -f {} \; >/tmp/listado_${i}_trace_${USER}.txt

find . -name "log_*.aud" -mtime +60 -exec rm -rf {} \;

limpieza_logs.sh
30 1 10,20 * * /oracle/app/oracle/product/11.2.0/db/util/scripts/limpieza_de_log.sh




GRID
--------------------------------------------------------------------------------------------------------


#!/bin/bash

# Yefri Marquez - DBA Team - ADSI
# limpieza_trace.sh

SECONDS=0 ## Variable para medir el tiempo de ejecucion
LOG=/tmp/limpieza_trace_Grid.log

# ORACLE_HOME del usuario especificado
#USER=grid11
#DIR=/oracle/app/oracle19 # oracle base
USER=grid11
DIR=/oracle/app # grid base

for i in aud trm trc log_*.xml
do
echo "$(date +'%Y%m%d %H:%M:%S') - Inicio limpieza ${i} " | tee -a $LOG

find $DIR/ -name "*.${i}*" -ctime +90 -ls -exec rm -f {} \; >/tmp/listado_${i}_trace_${USER}.txt

echo "$(date +'%Y%m%d %H:%M:%S') - Fin limpieza ${i}\n " | tee -a $LOG
done

## Calculo de tiempo de ejecucion
DURATION=$SECONDS
HOUR_END=$(($DURATION/3600))
MIN_END=$(($DURATION%3600/60))
SEC_END=$(($DURATION%60))
echo "Duracion del proceso limpieza:  ${HOUR_END}h ${MIN_END} min ${SEC_END} secs." | tee -a $LOG











