1. 
vi limpieza_trace.sh

2.
#!/bin/bash

SECONDS=0 ## Variable para medir el tiempo de ejecucion
DIR=/oracle/app/grid
LOG=/tmp/limpieza_trace.log

for i in aud trm trc
do
echo "$(date +'%Y%m%d %H:%M:%S') - Inicio limpieza ${i} " | tee -a $LOG

find $DIR/ -name "*.${i}*" -ctime +90 -ls -exec rm -f {} \; >/tmp/listado_${i}_trace_oracle.txt

echo "$(date +'%Y%m%d %H:%M:%S') - Fin limpieza ${i}\n " | tee -a $LOG
done

## Calculo de tiempo de ejecucion
DURATION=$SECONDS
HOUR_END=$(($DURATION/3600))
MIN_END=$(($DURATION%3600/60))
SEC_END=$(($DURATION%60))
echo "Duracion del proceso limpieza:  ${HOUR_END}h ${MIN_END} min ${SEC_END} secs." | tee -a $LOG


# LIMPIEZA DE ARCHIVOS AUD, TRC, TRM - ADSI DBA TEAM - NEDJ
00 01 * * * /export/home/oracle12/scripts/limpieza/limpieza_trace.sh

/export/home/oracle12/scripts/limpieza/limpieza_trace.sh
00 01 * * * /export/home/oracle19/scripts/limpieza/limpieza_trace.sh

cyclop
00 01 * * * /export/home/oracle11/scripts/limpieza/limpieza_trace.sh

# LIMPIEZA DE ARCHIVOS AUD, TRC, TRM - ADSI DBA TEAM - NEDJ
00 01 * * * /export/home/oracle11/scripts/limpieza/limpieza_trace.sh





GRID####

# LIMPIEZA DE ARCHIVOS AUD, TRC, TRM - ADSI DBA TEAM - NEDJ
00 01 * * * /export/home/grid12/scripts/limpieza/limpieza_trace.sh

00 01 * * * /export/home/grid/util/scripts/limpieza/limpieza_trace.sh







00 01 * * * /export/home/grid11/scripts/limpieza/limpieza_trace.sh



















