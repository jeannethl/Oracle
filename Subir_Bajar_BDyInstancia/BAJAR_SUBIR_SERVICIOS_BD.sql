BAJAR SERVICIOS  sun14dz1 y sun14qz1

---- Verificar las BD y los LISTENER
crsctl status resource -t

--- BAJAR TODOS LOS SERVICIOS POR RECURSOS DE CLUSTER

crsctl stop has

--- SI NO BAJAN TODOS 

--VERIFICAR

alter system switch logfile;    ---- Forzar el cambio del archivo de registro de transacciones
alter system checkpoint;        ---- Realización de un punto de control


alter system switch logfile; 
alter system checkpoint; 


--BAJAR_1
shutdown immediate;

--BAJAR_2 
srvctl stop database -d BD



--- SUBIR TODOS LOS SERVICIOS POR RECURSOS DE CLUSTER

crsctl start has


---SUBIR_1
startup

---SUBIR_2
srvctl start database -d DRPD



srvctl start database -d EXPDIGD


startup pfile='/oracle/app/oracle/product/11.2.0/db/dbs/initDRPD.ora';

--- SUBIR LOS LISTENER 

lsnrctl start 'LISTENER112' 

lsnrctl status 'LISTENER112'

--estatus masivo

for db in $(ps -ef | grep -i pmon | egrep -vi "grep|asm|mgmt" | cut -d'_' -f3)
do
export ORACLE_SID=$db
sqlplus -S / as sysdba << EOF
select instance_name, status from gv\$instance;
exit;
EOF
done


ALTER SYSTEM SET LOCAL_LISTENER = 'LISTENER_EXPDIGD';
ALTER SYSTEM REGISTER;

srvctl config database -d BDVEMPD -a 

CREATE pfile = '?/dbs/initBDVEMPD_20250319.ora' from spfile;
startup nomount pfile = '?/dbs/initBDVEMPD_20250319.ora';

create spfile = '+DG_DATA' FROM pfile = '?/dbs/initBDVEMPD_20250319.ora';

SPFILE='+DG_DATA/BDVEMPD/PARAMETERFILE/spfile.318.1196178913'
srvctl modify database -d BDVEMPD -p '+DG_DATA/BDVEMPD/PARAMETERFILE/spfile.318.1196178913'

srvctl modify database -h

CREATE PFILE='/oracle/app/oracle19/product/19c/db1/dbs/initINTRNETD.ora' FROM SPFILE;