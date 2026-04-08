--comando reescanear discos
for host in /sys/class/scsi_host/*; do echo "- - -" | sudo tee $host/scan; ls /dev/sd* ; done
*/

Agregar discos a DG Linux


---  Consultar los permisos de los discos a nivel del SO:

/dev/oracleasm/disks/

--- VALIDAR LOS PERMISOS DE LOS DISCOS

ls -ld DISK_ASM35

--- VALIDAR SIN IR A LA RUTA

ls -ld /dev/oracleasm/disks/DISK_ASM37


--- VALIDAR SI ESTAN EL LOS OTRO NODOS 
 ssh plbdbdvnet01 ls -ld /dev/oracleasm/disks/DISK_ASM37


lsblk -fm


---   sqlplus / as sysasm

--- Consultar los discos CANDIDATE o FORMER

set lines 400
COLUMN header_status FORMAT a25
COLUMN path FORMAT a40
COLUMN name FORMAT a20
SELECT inst_id, header_status, path, state, OS_MB, create_date 
FROM gv$asm_disk
--WHERE header_status = 'PROVISIONED'
-- AND path like 'DISK_ASM37' --BUSCA LOS DISCOS EN ESPECIFICO
ORDER BY path;


--------------------------------------------- Vista del query ---------------------------------------------

   INST_ID HEADER_STATUS             PATH                                     STATE         OS_MB CREATE_DA
---------- ------------------------- ---------------------------------------- -------- ---------- ---------
         1 FORMER                    /dev/rdsk/c1d118s6                       NORMAL        15354 07-DEC-22
         3 FORMER                    /dev/rdsk/c1d118s6                       NORMAL        15354 07-DEC-22
         3 FORMER                    /dev/rdsk/c1d119s6                       NORMAL        15354 07-DEC-22



   INST_ID HEADER_STATUS             PATH                                STATE         OS_MB CREATE_DA
---------- ------------------------- ----------------------------------- -------- ---------- ---------
         1 CANDIDATE                 /dev/rdsk/emcpower14g               NORMAL        51194
         1 CANDIDATE                 /dev/rdsk/emcpower15g               NORMAL        51194
         1 CANDIDATE                 /dev/rdsk/emcpower16g               NORMAL        51194



---  Estar pendiente de los discos que estas agregando al script para que no haya errores.
Verificar el nombre de los discos que se encuentran candidate.
Script para agregar los discos al DG:
													Para saber que nombre le corresponde a los discos que van a ser agregados
													entrar a TOAD - DATABASE - ADMINISTER - ASM MANAGER


Verificar el nombre de los discos por consola 

set line 120
col path format a35
col name format a25
select name, path, group_number from v$asm_disk;



set linesize 2000
set pagesize 600
col PATH format a60
col NAME format a25
select inst_id, header_status, path, name, os_mb
from gv$asm_disk
where inst_id=1
order by 1, 4;



--- Agregar disco ejemplo:

--- UNO X UNO	

ALTER DISKGROUP DATA ADD DISK '/dev/oracleasm/disks/ASM_DATA_03' NAME  DATA_0002 REBALANCE POWER 20;
ALTER DISKGROUP DATA ADD DISK '/dev/oracleasm/disks/ASM_DATA_04' NAME  DATA_0003 REBALANCE POWER 20;
--Revisar el status de la operación de rebalanceo o el Alert_log
--Después de añadir los discos para chequear el status de la operación de rebalanceo consultamos la vista V$ASM_OPERATION:

SET LINE 500
SELECT * FROM GV$ASM_OPERATION;




ALTER DISKGROUP DATA DROP DISK 'FRA_0000' REBALANCE POWER 20;





    
ALTER DISKGROUP REDO02 DROP DISK 'DISK_ASM10' REBALANCE POWER 20;
ALTER DISKGROUP REDO02 DROP DISK 'REDO02_0001' REBALANCE POWER 20;
ALTER DISKGROUP REDO02 DROP DISK 'DISK_ASM8' REBALANCE POWER 20;
ALTER DISKGROUP REDO02 DROP DISK 'DISK_ASM9' REBALANCE POWER 20;




for i in `ls -1 /dev/sdbg`; do echo -e "p\q" | fdisk $i |grep "Disk identifier"; done


/usr/sbin/oracleasm createdisk DATA_ASM_002 /dev/sdm1
/usr/sbin/oracleasm createdisk DATA_ASM_003 /dev/sdn1

/usr/sbin/oracleasm createdisk ASM_REDO02_000 /dev/sdg1
/usr/sbin/oracleasm createdisk ASM_REDO03_000 /dev/sdh1


/usr/sbin/oracleasm createdisk FRA_001 /dev/
/usr/sbin/oracleasm createdisk ASM_FRA_001 /dev/sdj1

echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdi
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdj
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdk
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdl
echo -e "o\nn\np\n1\n\n\nw" | fdisk /dev/sdm



/usr/sbin/oracleasm createdisk DISK_DATA_0001 /dev/sdd1
/usr/sbin/oracleasm createdisk DISK_DATA_0002 /dev/sde1

/usr/sbin/oracleasm createdisk DISK_FRA_0001 /dev/sdf1
/usr/sbin/oracleasm createdisk DISK_FRA_0002 /dev/sdg1

/usr/sbin/oracleasm createdisk DISK_REDO01_0001 /dev/sdh1
/usr/sbin/oracleasm createdisk DISK_REDO01_0002 /dev/sdi1
/usr/sbin/oracleasm createdisk DISK_REDO01_0003 /dev/sdj1

/usr/sbin/oracleasm createdisk DISK_REDO02_0001 /dev/sdk1
/usr/sbin/oracleasm createdisk DISK_REDO02_0002 /dev/sdl1
/usr/sbin/oracleasm createdisk DISK_REDO02_0003 /dev/sdm1

/usr/sbin/oracleasm createdisk DISK_ASM003 /dev/sdd1
/usr/sbin/oracleasm createdisk DISK_ASM004 /dev/sde1
/usr/sbin/oracleasm createdisk DISK_ASM005 /dev/sdf1
/usr/sbin/oracleasm createdisk DISK_ASM006 /dev/sdg1

/sbin/partprobe /dev/sdd1

sdt1
sdu1
sdv1
sdw1
sdx1
sdy1
sdz1  


ASM_DATA_000
ASM_DATA_001



/usr/sbin/oracleasm deletedisk ASM_REDO01_000
/usr/sbin/oracleasm deletedisk ASM_REDO02_000
/usr/sbin/oracleasm deletedisk DATA_ASM_000
/usr/sbin/oracleasm deletedisk DATA_ASM_001

sudo chown grid:asmadmin /dev/oracleasm/disks/ASM_REDO01_000
sudo chown grid:asmadmin /dev/oracleasm/disks/ASM_REDO02_000
sudo chown grid:asmadmin /dev/oracleasm/disks/DATA_ASM_000
sudo chown grid:asmadmin /dev/oracleasm/disks/DATA_ASM_001


chmod 660 /dev/oracleasm/disks/ASM_REDO01_000
chmod 660 /dev/oracleasm/disks/ASM_REDO02_000
chmod 660 /dev/oracleasm/disks/DATA_ASM_000
chmod 660 /dev/oracleasm/disks/DATA_ASM_001



/usr/sbin/oracleasm createdisk FRA_000 /dev/sdk1
/usr/sbin/oracleasm createdisk RMANH_REDO01_000 /dev/sdi1
/usr/sbin/oracleasm createdisk RMANH_REDO02_000 /dev/sdj1
/usr/sbin/oracleasm createdisk ASM_REDO03_000 /dev/sdh1


/usr/sbin/oracleasm createdisk ASM_FRA000 /dev/sdi1
/usr/sbin/oracleasm createdisk ASM_FRA001 /dev/sdj1

/usr/sbin/oracleasm createdisk ASM_DATA_06 /dev/sdn1
/usr/sbin/oracleasm createdisk ASM_DATA_07 /dev/sdo1

/usr/sbin/oracleasm createdisk DISK_ASM16 /dev/sdv1
/usr/sbin/oracleasm createdisk DISK_ASM17 /dev/sdw1
/usr/sbin/oracleasm createdisk DISK_ASM18 /dev/sdx1
/usr/sbin/oracleasm createdisk DISK_ASM20 /dev/sdy1
/usr/sbin/oracleasm createdisk DISK_ASM21 /dev/sdz1

/usr/sbin/oracleasm deletedisk DATA_ASM_000


/usr/sbin/oracleasm listdisks
/usr/sbin/oracleasm scandisks
/usr/sbin/oracleasm listdisks



/usr/sbin/oracleasm createdisk DISK_ASM19 /dev/sdbi1

/usr/sbin/oracleasm deletedisk ASM_FRA_000
/usr/sbin/oracleasm deletedisk ASM_FRA_001
/usr/sbin/oracleasm deletedisk DATA_RMAN_000


/usr/sbin/oracleasm deletedisk ASM_REDO01_000

ALTER DISKGROUP REDO01 MOUNT;

ALTER DISKGROUP DG_REDO02 MOUNT;
sdaj                                                                                                       50G root  disk  brw-rw
└─sdaj1                     oracleasm   DISK_ASM19                                                         50G root  disk  brw-rw
sdak                                                                                                       50G root  disk  brw-rw
└─sdak1                     oracleasm   DISK_ASM20                                                         50G root  disk  brw-rw
sdal                                                                                                       50G root  disk  brw-rw
└─sdal1                     oracleasm   DISK_ASM21                                                         50G root  disk  brw-rw
sdaq                                                                                                       50G root  disk  brw-rw
└─sdaq1                     oracleasm   DISK_ASM26                                                         50G root  disk  brw-rw



