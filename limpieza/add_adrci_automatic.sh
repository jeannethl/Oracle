#!/bin/ksh

# Author(s): Nelson Diaz - DBA TEAM - ADSI
# add_adrci_automatic.sh

if [ $(uname) = "Linux" ];then
  . ~/.bash_profile > /dev/null
  PROFILE=$(echo ".bash_profile")
else
  . ~/.profile > /dev/null
  PROFILE=$(echo ".profile")
fi

DIR=${HOME}/scripts/cleaning
SCRIPT_FILE_CHANGE=change_policy.sh
SCRIPT_FILE_CLEARING=cleaning_adrci.sh
PROMPT=${SHELL}
TEMP_FILE=/tmp/test_crontab
CANT_USED_CRONTAB_FLAG=1
# COLORS
RED="\033[31m"
YELLOW="\033[33m"
ENDCOLOR="\033[0m"

# FUNCTION
WRITE_MESSAGE () {
  line="$@"
  echo ""
  echo "*********************************************************"
  echo "${line}"
  echo "*********************************************************"
  echo ""
}

if [ ! -d "${DIR}" ];then
  mkdir -p $DIR
fi

# CREATE file change_policy.sh

cat <<EOF > ${DIR}/${SCRIPT_FILE_CHANGE}
#!${PROMPT}

# Author(s): Nelson Diaz - DBA TEAM - ADSI
# change_policy.sh

. ~/${PROFILE}

FECHA=\$(date +"%Y%m%d %H:%M%S")
SHORTP_POLICY=24
LONGP_POLICY=60
#Purgando

echo "\$FECHA - INFO: Iniciando proceso de cambio de SHORTP_POLICY y LONGP_POLICY"
echo ""
\$ORACLE_HOME/bin/adrci exec="show homes" | grep -v : | while read LINE
do
echo ""
echo "\$FECHA - INFO: cambio del home \$LINE"
echo ""
echo "Cambiando SHORTP_POLICY"
\$ORACLE_HOME/bin/adrci exec="set homepath \$LINE;set control \(SHORTP_POLICY = \${SHORTP_POLICY}\)" && echo "Success"
echo ""
echo "Cambiando LONGP_POLICY"
\$ORACLE_HOME/bin/adrci exec="set homepath \$LINE;set control \(LONGP_POLICY = \${LONGP_POLICY}\)" && echo "Success"
done
EOF

# CREATE file change_policy.sh

cat <<EOF > ${DIR}/${SCRIPT_FILE_CLEARING}
#!${PROMPT}

# Author(s): Nelson Diaz - DBA TEAM - ADSI
# cleaning_adrci.sh

. ~/${PROFILE}

get_date() {
  echo "$(date +'%Y/%m/%d %R:%S')"
}
#Purgando
echo "\$(get_date) INFO: Iniciando proceso de purge"
echo ""
\$ORACLE_HOME/bin/adrci exec="show homes" | grep -v : | while read LINE
do
  echo ""
  echo "INFO: Purgando a partir del home \$LINE"
  echo "purgando ALERT"
  echo ""
  \$ORACLE_HOME/bin/adrci exec="set homepath \$LINE;purge"
  if [ \$? -eq 0 ];then
    echo "\$(get_date) INFO: Finalizado proceso de purge para \$LINE"
    echo ""
  fi
done
EOF

# Check crontab

crontab -l > ${TEMP_FILE} 2>&1
chmod 775 ${TEMP_FILE}

CAN_USED_CRONTAB=$(grep -ci "not authorized" ${TEMP_FILE})

if [ ${CAN_USED_CRONTAB} -ge ${CANT_USED_CRONTAB_FLAG} ];then
WRITE_MESSAGE "${RED}ERROR:${ENDCOLOR} NO SE TIENE PERMISOS PARA USAR EL CRONTAB"
else
TEMP_CRONTAB=/tmp/crontab_temp
echo "# Cleaning /oracle - DBA TEAM - NEDJ" > ${TEMP_CRONTAB}
echo "00 01 * * * ${DIR}/${SCRIPT_FILE_CLEARING}" >> ${TEMP_CRONTAB}

crontab - <<EOF
$(cat ${TEMP_CRONTAB})
EOF

rm -f ${TEMP_CRONTAB}
fi

# change permisions
cd ${DIR}
chmod +x ${DIR}/${SCRIPT_FILE_CLEARING}

chmod +x ${DIR}/${SCRIPT_FILE_CHANGE} && ./${SCRIPT_FILE_CHANGE}

WRITE_MESSAGE "VERIFICAR SI FUE AGREGADO EL SCRIPT AL CRONTAB, SINO AGREGAR MANUALMENTE LAS SIGUIENTES LINESAS"

echo "# Cleaning /oracle - DBA TEAM - NEDJ"
echo "00 01 * * * ${DIR}/${SCRIPT_FILE_CLEARING}"

rm -f ${TEMP_FILE}

WRITE_MESSAGE "Execute ADRCI ${DIR}/${SCRIPT_FILE_CLEARING}"

echo "FINISH"
echo ""
# End
