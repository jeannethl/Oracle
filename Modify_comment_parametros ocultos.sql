

AHF-LINUX_v24.6.0.zip



cd /oracle/app/oracle/product/19c/db1/suptools/ahf

unzip -q /oracle/install/19c/tools/AHF-LINUX_v24.6.0.zip


root 
cd /oracle/app/oracle/product/19c/db1/suptools/ahf

./ahf_setup -ahf_loc /opt -data_dir /opt/oracle.ahf
.




para montar la ultima version del CVU luego de instalado el AHF
cd /opt/oracle.ahf/common/cvu






unzip -q /oracle/install/19c/tools/cvupack_linux_ol7_x86_64.zip

*****


service_names='DCSP'

**********************************



set pages 100;
set lines 150;
col sid format 999999;
col event format a40;
col state format a15;
col waiting head "Waiting(in seconds)" format 9,999.99;
col waited head "Waited" format 9,999.99;
select sid, state, event,
       seconds_in_wait  waiting,
       wait_time/100    waited, p1,p2,p3, BLOCKING_SESSION "Blocker"
from v$session
where event not in
(
  'SQL*Net message from client',
  'SQL*Net message to client',
  'rdbms ipc message'
)
and state = 'WAITING'
and username not in ('SYS','SYSTEM','SYSMAN','DBSNMP');




*****

alter system set "_ipddb_enable"=TRUE comment='recomendacion AHF';

alter system set "_gc_policy_minimum"=15000 comment='recomendacion MOS Oracle';

alter system set "_use_adaptive_log_file_sync"=FALSE comment='recomendacion MOS Oracle';


commit_logging                       string                           BATCH
