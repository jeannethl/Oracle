Eliminar un BD y un disk group por completo


BASE DE DATOS

0. Consultar el status de BD

select instance_name,status,logins from v$Instance;

1. Detener la base de datos

SHUTDOWN IMMEDIATE;

2.  Inicie la base de datos en modo mount exclusive restrict
	/*Para que no sea accesible para los usuarios*/
STARTUP MOUNT EXCLUSIVE RESTRICT;

3. Eliminar la base de datos
	
DROP DATABASE;

4. Buscar archivos fisicos y eliminarlos 

find /oracle -name "*.dbf" -exec rm -rf {} \;
find /oracle -name "*.log" -exec rm -rf {} \;
find /oracle -name "*.ctl" -exec rm -rf {} \;

5. Eliminar el listener de Oracle:
    /* Si la base de datos era la única base de datos en el servidor, también debes detener y eliminar el listener de Oracle. */


DISK GROUP 

1ra forma 

ALTER DISKGROUP nombre_del_grupo_de_discos DISMOUNT;

SELECT name, state FROM v$asm_diskgroup;  --- ver los diskgroup en dismount

DROP DISKGROUP nombre_del_grupo_de_discos INCLUDING CONTENTS;


--- Ejemplo 
ALTER DISKGROUP REDO02 DISMOUNT;
ALTER DISKGROUP REDO01 DISMOUNT;
ALTER DISKGROUP FRA DISMOUNT;
ALTER DISKGROUP DATA DISMOUNT;


DROP DG_REDO1_BDVREMQ FORCE INCLUDING CONTENTS;
DROP DG_REDO2_BDVREMQ FORCE INCLUDING CONTENTS;
DROP DG_REDO3_BDVREMQ FORCE INCLUDING CONTENTS;
DROP DG_DATA_BDVREMQ FORCE INCLUDING CONTENTS;

ALTER DISKGROUP FRA DISMOUNT;
ALTER DISKGROUP DG_DATA_SAMFP DISMOUNT;
DROP DISKGROUP DG_DATA_SAMFP INCLUDING CONTENTS;
DROP DISKGROUP DG_REDO1_SAMFP INCLUDING CONTENTS;
DROP DISKGROUP DG_REDO2_SAMFP INCLUDING CONTENTS;
DROP DG_DATA_BDVREMQ FORCE INCLUDING CONTENTS;



Name
DG_DATA_ADS
DG_FRA
DG_OCRVOT
DG_REDO1_ADS
DG_REDO2_ADS

ALTER DISKGROUP DG_REDO2_SAMFP MOUNT;
ALTER DISKGROUP DG_REDO2_SAMFP DISMOUNT;
2da forma

asmcmd
umount nombre_del_grupo_de_discos o umount -f nombre_del_grupo_de_discos

dropdg -f -r nombre_del_grupo_de_discos O  dropdg -r nombre_del_grupo_de_discos



--- Ejemplo
umount DG_REDO1_BDVREMQ 
umount DG_REDO2_BDVREMQ
umount DG_REDO3_BDVREMQ
umount -f DG_DATA_BDVREMQ


dropdg -f -r DG_REDO1_BDVREMQ
dropdg -f -r DG_REDO2_BDVREMQ
dropdg -f -r DG_REDO3_BDVREMQ
dropdg -f -r DG_DATA_BDVREMQ
dropdg -r  