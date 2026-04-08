# PROCEDIMIENTO PARA AGREGAR DISCOS
--------------------------------------------------------------------------------
-- Validar que los permisos de los discos sean los adecuados
-- comando SOLARIS
--------------------------------------------------------------------------------

-- INGRESAR A LA RUTA

cd /dev/rdsk

for i in `ls -ld c1d322s6 c1d323s6 c1d324s6 c1d325s6 c1d326s6 c1d327s6 c1d328s6 c1d329s6 c1d330s6 c1d331s6 c1d332s6 c1d333s6 c1d334s6 c1d335s6 c1d336s6 c1d337s6 |awk {'print$11'}`; do ls -ltr $i* |grep -i oinstall; done

--------------------------------------------------------------------------------
-- Se validan los discos candidatos, con conocimiento inicial de la ruta o path.

 TOTAL_MB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           NUMBER
 FREE_MB  
--------------------------------------------------------------------------------
SET LINESIZE 2000
SET PAGESIZE 600
COL PATH FORMAT A40
COL NAME FORMAT A25
SELECT INST_ID, HEADER_STATUS, PATH, NAME
FROM GV$ASM_DISK
WHERE HEADER_STATUS = 'MEMBER'
AND PATH LIKE '%c1d420s6%'
ORDER BY 3;
-------------
--SQLPLUS
-------------
ALTER DISKGROUP DG_DATA_BDVRELP ADD DISK '/dev/rdsk/c1d420s6' NAME DG_DATA_BDVRELP_0041 REBALANCE POWER 10;
ALTER DISKGROUP DG_DATA_BDVRELP ADD DISK '/dev/rdsk/c1d421s6' NAME DG_DATA_BDVRELP_0042 REBALANCE POWER 10;
ALTER DISKGROUP DG_DATA_BDVRELP ADD DISK '/dev/rdsk/c1d422s6' NAME DG_DATA_BDVRELP_0043 REBALANCE POWER 10;
--
ALTER DISKGROUP DG_DATA_BDVNETP ADD DISK 
'/dev/rdsk/c1d323s6' NAME DG_DATA_BDVNETP_0082
,'/dev/rdsk/c1d324s6' NAME DG_DATA_BDVNETP_0083
,'/dev/rdsk/c1d325s6' NAME DG_DATA_BDVNETP_0084
,'/dev/rdsk/c1d326s6' NAME DG_DATA_BDVNETP_0085
,'/dev/rdsk/c1d327s6' NAME DG_DATA_BDVNETP_0086
,'/dev/rdsk/c1d328s6' NAME DG_DATA_BDVNETP_0087
,'/dev/rdsk/c1d329s6' NAME DG_DATA_BDVNETP_0088
REBALANCE POWER 10;
--------
ALTER DISKGROUP DG_DATA_BDVNETP ADD DISK
'/dev/rdsk/c1d330s6' NAME DG_DATA_BDVNETP_0089
,'/dev/rdsk/c1d331s6' NAME DG_DATA_BDVNETP_0090
,'/dev/rdsk/c1d332s6' NAME DG_DATA_BDVNETP_0091
,'/dev/rdsk/c1d333s6' NAME DG_DATA_BDVNETP_0092
,'/dev/rdsk/c1d334s6' NAME DG_DATA_BDVNETP_0093
,'/dev/rdsk/c1d335s6' NAME DG_DATA_BDVNETP_0094
,'/dev/rdsk/c1d336s6' NAME DG_DATA_BDVNETP_0095
,'/dev/rdsk/c1d337s6' NAME DG_DATA_BDVNETP_0096
REBALANCE POWER 10;

-----------
--Revisar el status de la operación de rebalanceo
--Después de añadir los discos para chequear el status de la operación de rebalanceo consultamos la vista V$ASM_OPERATION:
SET LINE 500
SELECT * FROM GV$ASM_OPERATION;



------------------------------
-- VALIDAR ESPACIO EN DISKGROUP
-------------------------------
SET LINESIZE 2000
SET PAGESIZE 600
COL PATH FORMAT A40
COL NAME FORMAT A25
SELECT INST_ID, HEADER_STATUS, PATH, NAME
FROM GV$ASM_DISK
WHERE NAME LIKE "DG_DATA_BDVRELP%"
ORDER BY 3;
-------------------------------
-------------------------------
SELECT NAME
, ROUND((1 - (FREE_MB / TOTAL_MB))*100, 2)  PCT_USED
FROM V$ASM_DISKGROUP
ORDER BY GROUP_NUMBER;
-----------------------

