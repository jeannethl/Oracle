|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
|--Pasos para Cambiar el MTU del Adaptador Loopback
|    --Cambiar el MTU:
|    --Ejecuta el siguiente comando para cambiar el tamaño de MTU del adaptador loopback:
|sudo ip link set dev lo mtu 16436
|    --Verificar el Cambio:
|    
|    --Después de ejecutar el comando, verifica que el cambio se haya realizado correctamente:
|ip link show lo
|    --Deberías ver una salida similar a esta:
|1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
|    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
|
|    --Reiniciar Servicios de Red:
|    --Para asegurarte de que todos los servicios reconozcan el nuevo tamaño de MTU, es recomendable reiniciar los servicios de red. Dependiendo de tu sistema, puedes usar
|sudo systemctl restart network
|    
|    --Cambio Persistente
|    --Edita el archivo correspondiente al adaptador loopback
|sudo vi /etc/sysconfig/network-scripts/ifcfg-lo
|--Tu archivo debería verse así:
|DEVICE=lo
|IPADDR=127.0.0.1
|NETMASK=255.0.0.0
|NETWORK=127.0.0.0
|BROADCAST=127.255.255.255
|ONBOOT=yes
|NAME=loopback
|MTU=16436
|    --Reiniciar nuevamente
|sudo systemctl restart network
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

mkdir -p /oracle/app/oraInventory
mkdir -p /oracle/app/grid
mkdir -p /oracle/app/product/19c/grid
mkdir -p /oracle/app/oracle/product/19c/db1
chown -R grid:oinstall /oracle/
chown -R oracle19:oinstall /oracle/app/oracle
chmod -R 775 /oracle/


--ver usuarios y grupos
cut -d: -f1 /etc/passwd
cut -d: -f1 /etc/group
--Sacar estadisticas
exec DBMS_STATS.GATHER_SCHEMA_STATS (ownname => 'APIM_DB',estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,degree=>30,cascade => TRUE);

--Truncar archivos sin borrarlos
truncate -s 0 listener.log

--Copiar archivos de un servidor a otro

scp -p usuario@servidor:/ruta/origen/*.html /ruta/local/
*/
--Consultar usuario con NM y CT

net user /domain <nm o ct>

--
:%s/\r//g

-- Describe la vista V$INSTANCE, que proporciona información sobre la instancia de la base de datos.
DESC V$INSTANCE;

-- Formatea la columna HOST_NAME para que tenga un ancho de 15 caracteres.
COL HOST_NAME FORMAT A15;

-- Selecciona las columnas INSTANCE_NAME, HOST_NAME, STARTUP_TIME y STATUS de la vista V$INSTANCE.
COL HOST_NAME FORMAT A15;
SELECT INSTANCE_NAME,  
       HOST_NAME,      
       STARTUP_TIME,   
       STATUS         
FROM V$INSTANCE;




--V$ACTIVE_SESSION_HISTORY
set line 300
SELECT username, status, logon_time, machine, OSUSER
FROM v$session
WHERE logon_time >= SYSDATE - 11;


SELECT username, status, logon_time, machine, OSUSER
FROM v$session
WHERE logon_time >= SYSDATE - (365 * 5)
--Ver la Hora Actual

SELECT SYSDATE FROM dual;

SELECT CURRENT_TIMESTAMP FROM dual;    

SELECT 
  OWNER,
  TABLE_NAME,
  LAST_ANALYZED,
  USER_STATS
FROM 
  DBA_TABLES
WHERE 
  OWNER = 'BDVEMP';  


--Consultar sesiones activas
SELECT COUNT(1) FROM V$SESSION
WHERE STATUS= 'ACTIVE';



--consultar diskgroup de la base de datos

srvctl config database -d BVSOL02D

--consultar discos cuantos discos tiene un diskgroupen grid

asmcmd lsdsk -k -G DG_DATA1


--Listar sesiones activas en la base de datos
col TIME format a20
select TO_CHAR(sample_time,'DD-MM-YYYY HH24:MI') time, COUNT(1) total
--, INSTANCE_NUMBER
from
dba_hist_active_sess_history
where
sample_time >= to_date('2025/07/14 12:55:00','YYYY/MM/DD HH24:MI:SS')
and sample_time <= to_date('2025/07/14 13:20:00','YYYY/MM/DD HH24:MI:SS')
and sql_exec_start is not null
and IS_SQLID_CURRENT='Y'
-- and sql_id = '8vp5sknd8bq6d'
GROUP BY TO_CHAR(sample_time,'DD-MM-YYYY HH24:MI')--, INSTANCE_NUMBER
ORDER BY 1;


--encontrar una palabra en especfico en todo el sistema si esta en un archivo
find / -type f -name "*backup*"

--ver version del servidor
cat /etc/release

--Ver arquitectura del servidor
lscpu
cat /etc/os-release
hostnamectl
isainfo -v
--ver IPs
srvctl config vip -node <Nombre del nodo> o bien cat /etc/hosts
srvctl config scan
netstat -rn
nslookup <Nombre del servidor>
dladm show-link

--Ver version o edicion de oracle
SELECT * FROM v$version;


--ver listeners
cat /oracle/app/oracle/product/9.2.0/network/admin/listener.ora 
--verificar el listener que esta respondiendo
lsnrctl status 

SHOW PARAMETER LOCAL_LISTENER;

--Fecha de la creación de la BD
SELECT created FROM v$database;


--resetlogs
SELECT c, resetlogs_time FROM v$database;
SELECT MAX(first_change#), MAX(resetlogs_change#), MAX(resetlogs_time)
FROM v$log_history;

--Servicios que está manejando el listener
SELECT NAME FROM V$SERVICES;

--ver versión del OPATCH
cd $ORACLE_HOME/OPatch
./opatch version

--opatch lsinventory
cd $ORACLE_HOME/OPatch
./opatch lsinventory


--Ver si esta e modo Archive
SELECT log_mode FROM v$database;

--Consulta para verificar la multiplexación del archivo de controlInterpretación de resultados:
--Si la consulta devuelve más de un archivo de control, significa que la multiplexación está habilitada.
--Si solo devuelve un archivo de control, significa que no está habilitada.
SELECT name FROM v$controlfile;


--Consulta para verificar la multiplexación de los Redo Logs
--Si el resultado muestra más de un archivo para un mismo grupo de Redo Log (es decir, log_count es mayor que 1 para algún GROUP#), significa que la multiplexación está habilitada.
--Si cada grupo de Redo Log tiene solo un archivo, significa que no está habilitada.
SELECT GROUP#, COUNT(*) AS log_count
FROM v$log
GROUP BY GROUP#;

--Entonación de redo logs
SELECT COUNT(*) AS redo_log_count
FROM v$log;


--Comando para verificar el contenido del oratab
cat /etc/oratab o cat /var/opt/oracle/oratab


--Comprobar la configuración de Data Guard
SELECT database_role, protection_mode
FROM v$database;

--Ver obejtos invalidos del esquema
SELECT object_name, object_type
FROM user_objects
WHERE status = 'INVALID';

--Ver obejtos invalidos de todos los esquemas
COL OWNER FORMAT A20
COL OBJECT_NAME FORMAT A30
SELECT owner, object_name, object_type, TIMESTAMP, LAST_DDL_TIME
FROM all_objects
WHERE status = 'INVALID';

--para ver el character de la bd
set line 180 pages 300
column VALUE format a32
column PARAMETER format a30
select * from v$nls_parameters ;


----------------------------------------------------------------------------------------------------------------
--Comprobar en donde esta el alert log y si esta escribiendo en este:

show parameter dump

--Tomar el background_dump_dest para buscar el alert

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
--background_core_dump                 string      partial
background_dump_dest                 string      /oracle/app/oracle10/admin/INFID/bdump                                                 
--core_dump_dest                       string      /oracle/app/oracle10/admin/INFID/cdump
--max_dump_file_size                   string      UNLIMITED
--shadow_core_dump                     string      partial
--user_dump_dest                       string      /oracle/app/oracle10/admin/INFID/udump


---Por ultimo realizar un alter system switch logfile; y revisar el alert log si este escribio:

alter system switch logfile;
----------------------------------------------------------------------------------------------------------------

alter system checkpoint;

---Liberar memoria
alter system flush shared_pool;

--Compilar BD
@?/rdbms/admin/catalog.sql
@?/rdbms/admin/catproc.sql


col sql_text form a80
set lines 120
select sql_text from gv$sqltext where hash_value=
(select sql_hash_value from gv$session where sid=&1 and inst_id=&inst_id)
order by piece;


SELECT 
    ss.username,
    ss.SID,
    sn.VALUE / 100 AS cpu_usage_seconds 
FROM 
    v$session ss,
    v$sesstat sn,
    v$statname se
WHERE 
    sn.STATISTIC# = se.STATISTIC# 
    AND se.NAME LIKE '%CPU used by this session%'
    AND sn.SID = ss.SID 
    AND ss.status = 'ACTIVE' 
    AND ss.username IS NOT NULL 
ORDER BY 
    sn.VALUE DESC;



SELECT 
    sql_id,
    executions,
    elapsed_time,
    cpu_time,
    disk_reads,
    buffer_gets,
    sql_text
FROM 
    v$sql
WHERE 
    sql_id = '46';


SELECT 
    segment_name AS table_name,
    SUM(bytes) / 1024 / 1024 AS size_mb
FROM 
    dba_segments
WHERE 
    owner = 'BDVEMPP'
    AND segment_type = 'TABLE'
GROUP BY 
    segment_name
ORDER BY 
    segment_name ASC;


---CAMBIAR LOS AUDIT DE TABLESPACE DE LAS TABLAS AUD$ Y FGA_LOG$
BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_AUD_STD, 
audit_trail_location_value => 'DATA_AUDIT');
END;
/
BEGIN
DBMS_AUDIT_MGMT.set_audit_trail_location(audit_trail_type => DBMS_AUDIT_MGMT.AUDIT_TRAIL_FGA_STD,
audit_trail_location_value => 'DATA_AUDIT');
END;
/


--LOCAL NO

ps -fea | grep "LOCAL=NO" | grep CYCLOPSP | awk '{printf "kill -9 %s\n",$2}' | sh


--- MONITOREO DE LOGS LONG QUERY

COL FREAL FORMAT A40
COL CCANAL FORMAT A20
COL FCONTABLE FORMAT A20
COL ESTADO FORMAT A20
COL CODIGORESULTADO FORMAT A20
COL RESULTADO FORMAT A80
--COL TIEMPO FORMAT A20
COL TIPOMENSAJE FORMAT A20
COL CSUBSISTEM FORMAT A20
COL CTRANSACCION FORMAT A20
COL CUSUARIO FORMAT A20
COL CTERMINAL FORMAT A20
COL SERVERWEB FORMAT A20
COL SERVER FORMAT A20
col RESULTADO FORMAT A60
SELECT FREAL
      ,CCANAL
      ,FCONTABLE
      ,ESTADO
      ,CODIGORESULTADO
      ,RESULTADO
      ,TIEMPO
      ,TIPOMENSAJE
      ,CSUBSISTEMA
      ,CTRANSACCION
      ,CUSUARIO
      ,CTERMINAL
      ,SERVERWEB
      ,SERVER
  FROM INTTEGRIOBDV.TLOGMENSAJES
WHERE FREAL >= TO_DATE('2025-04-07 12:00:00', 'YYYY-MM-DD HH24:MI:SS')
ORDER BY FREAL;


---SCRIPT MASIVO

for db in $(ps -ef | grep -i pmon | egrep -vi "grep|asm|mgmt" | cut -d'_' -f3)
do
export ORACLE_SID=$db
sqlplus -S / as sysdba << EOF
select instance_name, status from gv\$instance;
exit;
EOF
done


for db in $(ps -ef | grep -i pmon | egrep -vi "grep|asm|mgmt" | cut -d'_' -f3)
do
export ORACLE_SID=$db
sqlplus -S " / as sysdba " << EOF
select instance_name, status from gv\$instance;
exit;
EOF
done


---ver lo que consume un proceso por SQLID
SELECT 
    sql_id,
    SQLTYPE,
    executions,
    USERS_OPENING,
    elapsed_time,
    cpu_time,
    CLUSTER_WAIT_TIME,                                                                                             
    USER_IO_WAIT_TIME,  
    buffer_gets,
    disk_reads,
    rows_processed,
    LAST_ACTIVE_TIME
FROM 
    v$sql
WHERE 
    sql_id = '9fujwu6vdvymr'; 

---Ver la consulta por el sqlid

SELECT
  sql_id,
  sql_text,
  executions,
  elapsed_time,
  cpu_time,
  buffer_gets,
  rows_processed
FROM
  v$sqlarea
WHERE
  sql_id IN ('fbas3jhr9ga6s')
ORDER BY
  sql_id;



CREATE TEMPORARY TABLESPACE TMP2
TEMPFILE '/u01/app/oracle/oradata/mydatabase/my_temp_file.dbf'
SIZE 500M REUSE
AUTOEXTEND ON NEXT 100M MAXSIZE 2G
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M;



