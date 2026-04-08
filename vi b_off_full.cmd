vi b_off_full.cmd
run {

  # Paralelismo a nivel de media layer
  # Para el caso de networker se debe eliminar los parametros
  ALLOCATE CHANNEL T1 TYPE 'SBT_TAPE';

  SET COMMAND ID TO 'STOKENQ_OFFLINE_FULL';

  # backup de la base de datos
  BACKUP FULL DATABASE
    INCLUDE CURRENT CONTROLFILE

    TAG STOKENQ_OFFLINE_FULL

    # FILESPERSET 16

    # Si se desea tener redundancia de backups
    # NOT BACKED UP 2 TIMES

    # Tiempo de retencion
    # https://ss64.com/ora/rman_keepOption.html
    KEEP UNTIL TIME 'SYSDATE+30' LOGS
  ;

  # backup de otros elementos
  BACKUP CURRENT CONTROLFILE SPFILE;

  RELEASE CHANNEL T1;
}




vi mount.sh
#!/bin/bash

SCRIPTS="/oracle/app/oracle19/product/19c/db1/util/stokenq/backup/scripts/mount-bd.sh"

echo "#!/bin/bash" > $SCRIPTS
echo "export ORACLE_SID=STOKENQ;" >> $SCRIPTS
echo "export ORACLE_HOME=/oracle/app/oracle19/product/19c/db1;" >> $SCRIPTS
echo "/oracle/app/oracle19/product/19c/db1/bin/sqlplus " / as sysdba" <<EOF" >> $SCRIPTS
echo "shutdown immediate;" >> $SCRIPTS
echo "startup mount;" >> $SCRIPTS
echo "exit" >> $SCRIPTS
echo "EOF" >> $SCRIPTS

chmod +x $SCRIPTS
su - oracle19 -c $SCRIPTS
rm -rf $SCRIPTS



vi open.sh
#!/bin/bash

SCRIPTS="/oracle/app/oracle19/product/19c/db1/util/stokenq/backup/scripts/start-bd.sh"

echo "#!/bin/bash" > $SCRIPTS
echo "export ORACLE_SID=STOKENQ;" >> $SCRIPTS
echo "export ORACLE_HOME=/oracle/app/oracle19/product/19c/db1;" >> $SCRIPTS
echo "/oracle/app/oracle19/product/19c/db1/bin/sqlplus -s " / as sysdba" <<EOF" >> $SCRIPTS
echo "alter database open;" >> $SCRIPTS
echo 'select status from v\$instance;' >> $SCRIPTS
echo "exit" >> $SCRIPTS
echo "EOF" >> $SCRIPTS

chmod +x $SCRIPTS
su - oracle19 -c $SCRIPTS
rm -rf $SCRIPTS


--
/oracle/app/oracle19/product/19c/db1/util/stokenq
chmod -R 755 backup

/oracle/app/oracle19/product/19c/db1/util/pentahoq

chmod -R 755 backup