///////////////////////////////////////////////////
// 	EJECUTAR AL SCRIPT DE AWR EN SERIE
//			  ORACLE
//        ADSI DBA-TEAM
//  YOSDUAR RANGEL-ALIUSKA PEÑA-ADRIAN AGUILERA
///////////////////////////////////////////////////


1.-CONSULTAR LOS SNAPSHOOTS

set lines 100 pages 999
select snap_id,
  snap_level,
  to_char(begin_interval_time, 'dd/mm/yy hh24:mi:ss') begin
from
   dba_hist_snapshot
order by 1;




2.-Ejecutar los awr

s=Snapshoot de inicio
e=Snapshoot final
i=intervalo de captura de snapshoot

./dbs_gawrr.sh s=61064 e=61111 i=1



3.-En bdv nodo 2

Se encuentra
/oracle/app/oracle/product/19c/db1/util/dbs_gawrr.sh



