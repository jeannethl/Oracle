**********************Se detalla los pasos a seguir para creación de backup Database Manual***********************

PREVIOS

--. # para el caso de networker (con el usuario de oracle)
ln -s /usr/lib/libnsrora.so $ORACLE_HOME/lib/libobk.so

--. Verificación de versión del cliente de veritas

$bpgetconfig -M | grep VERSIONINFO

--.Testear Librería de VERITAS

$cd $ORACLE_HOME/bin
$file oracle
oracle: version del oracle, dynamically linked, not stripped

$ldd oracle
#muestra las librerias de oracle disponibles

$ls -l ../lib/libobk*  #valida si existe el link simbolico para la integración con VERITAS

#En caso de no existir crearlo de la siguiente forma.

#para el caso de veritas
ln -s /usr/openv/netbackup/bin/libobk.so64.1 $ORACLE_HOME/lib/libobk.so
#AL PARECER ÉSTAS LIBRERÍAS NO VAN:
ln -s /usr/openv/netbackup/bin/libobk.so.1 $ORACLE_HOME/lib/libobk.so
ln -s /usr/openv/netbackup/bin/libsybackup.so $ORACLE_HOME/lib/libobk.so

libobk.so -> liblsm.so

#Ahora se realiza el testeo de la librería probando con el backup de un archivo plano

echo "hola" > /tmp/prueba.txt
$ORACLE_HOME/bin/sbttest /tmp/prueba.txt
sbttest test.out -trace sbttest.trace

#La salida debe ser

The sbt function pointers are loaded from libobk.so library.
-- sbtinit succeeded
-- sbtinit (2nd time) succeeded
sbtinit: Media manager supports SBT API version 2.0
sbtinit: Media manager is version 5.0.0.0
sbtinit: vendor description string=Veritas NetBackup for Oracle - Release 6.5 (2007072323)
sbtinit: allocated sbt context area of 4 bytes
sbtinit: proxy copy is supported
-- sbtinit2 succeeded
-- regular_backup_restore starts ................................
-- sbtbackup succeeded
write 100 blocks
-- sbtwrite2 succeeded
-- sbtclose2 succeeded
sbtinfo2: SBTBFINFO_NAME=/tmp/pruebita.txt
sbtinfo2: SBTBFINFO_SHARE=multiple users
sbtinfo2: SBTBFINFO_ORDER=sequential access
sbtinfo2: SBTBFINFO_LABEL=0525JB
sbtinfo2: SBTBFINFO_CRETIME=Tue Aug 21 13:52:14 2012
sbtinfo2: SBTBFINFO_EXPTIME=Fri Sep 21 13:52:14 2012
sbtinfo2: SBTBFINFO_COMMENT=Backup ID : sia1_b_1345573334
sbtinfo2: SBTBFINFO_METHOD=stream
-- sbtinfo2 succeeded
-- sbtrestore succeeded
file was created by this program:
     seed=193433473, blk_size=16384, blk_count=100
read 100 buffers
-- sbtread2 succeeded
-- sbtclose2 succeeded
-- sbtremove2 succeeded
-- regular_backup_restore ends   ................................

--. Verificar el archivo bp.conf en el HOSTNAME a respaldar

$cd /usr/openv/netbackup
$more bp.conf
SERVER = bdvaix10
SERVER = bdvaix10h1
SERVER = bdvaix10h2
CLIENT_NAME =IP_BACKUP_HOSTNAME

--.Incluir string de catalogo RMAN en HOSTNAME a respaldar

$cd $ORACLE_HOME/network/admin
$vi tnsname.ora

******************************************************string********************************
RMAN.BANVENEZ.CORP =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = bdvbackup.banvenez.com)(PORT = 1545))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = RMAN)
    )
  )
****************************************************string************************************
$tnsping RMAN.BANVENEZ.CORP # Verificar que sea OK

--.Incluir la base de datos de acuerdo al ambiente que pertenece {rman(producción),rmanq(calidad),rmand(desarrollo)}

$export ORACLE_SID=INSTANCE_NAME
$rman
Recovery Manager: Release 10.2.0.3.0 - Production on Thu Jan 28 16:06:27 2016

Copyright (c) 1982, 2005, Oracle.  All rights reserved.
RMAN
RMAN>connect rcvcat rman/rmanexport@RMAN -- ejemplo de producción
RMAN>connect target /
RMAN>register database;
--- PARA SERVIDORES DE CALIDAD EL @rMAN DEBE SER = rmanq/rmanexport@RMAN.BANVENEZ.CORP
--- PARA SERVIDORES DE PRODUCCION EL @rMAN DEBE SER = rmanp/rmanexport@RMAN.BANVENEZ.CORP
--- PARA SERVIDORES DE DESARROLLO EL  @rMAN DEBE SER = rmand/rmanexport@RMAN.BANVENEZ.CORP


--.Determinar los backup a realizar

a- Backup archive
b- backup full online diario, semanal, mensual
c- backup full offline

a. Para realizar backup de archive o full online es necesario validar:

* La base de datos debe estar modo archive y tener un destino para los mismos

SQL> archive log list;
Database log mode              Archive Mode
Automatic archival             Enabled
Archive destination            +DG_FRA
Oldest online log sequence     378
Next log sequence to archive   380
Current log sequence           380

* Se debe ubicar en en la ruta:

$cd $ORACLE_HOME/util/$SID/backup  # $SID es la variable previamente definida en el  .profile, es el $ORACLE_SID en minúscula
$mkdir -p log

#Se deben crear los scripts b_archive.sh y b_archive.cmd en la  ubicación de formato:

Z:\Archivos\ORACLE\PostCreacion_Database\BACKUP

b_archive.sh y b_archive.cmd

* Solicitud de backup al area de almacenamiento y robótica

utilizar formato ubicado en:

Z:\Archivos\ORACLE\PostCreacion_Database\BACKUP

SOE.448 (07-15) Esquema de respaldo de bases de datos y archivos.xls

#Incluir en el correo el nombre de la politica colocada dentro del .cmd

#Una vez creada, al probar la ejecución desde VERITAS, validad en:

$cd  $ORACLE_HOME/util/$SID/backup/log


#Para el esto de las politicas se sigue el mismo procedimiento, los scripts los consiguen en:

Z:\Archivos\ORACLE\PostCreacion_Database\BACKUP
