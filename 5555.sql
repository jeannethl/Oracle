SELECT 
    (SELECT COUNT(1) FROM dba_indexes 		where owner = 'TX') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints 	where owner = 'TX') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables 		where owner = 'TX') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures	where owner = 'TX') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects 		where owner = 'TX' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects 		where owner = 'TX' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms 		where owner = 'TX') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences 	where SEQUENCE_OWNER = 'TX') AS total_sequences
FROM dual;


SELECT 
    (SELECT COUNT(1) FROM dba_indexes@TRZSP_SUN 		where owner = 'TX') AS total_indices,
    (SELECT COUNT(1) FROM dba_constraints@TRZSP_SUN 	where owner = 'TX') AS total_constraints,
    (SELECT COUNT(1) FROM dba_tables@TRZSP_SUN 		where owner = 'TX') AS total_tables,
    (SELECT COUNT(1) FROM dba_procedures@TRZSP_SUN	where owner = 'TX') AS total_procedures,
    (SELECT COUNT(1) FROM dba_objects@TRZSP_SUN 		where owner = 'TX' AND object_type = 'PACKAGE') AS total_packages,
    (SELECT COUNT(1) FROM dba_objects@TRZSP_SUN 		where owner = 'TX' and object_type = 'PACKAGE BODY') AS total_package_bodies,
    (SELECT COUNT(1) FROM dba_synonyms@TRZSP_SUN 		where owner = 'TX') AS total_synonyms,
    (SELECT COUNT(1) FROM dba_sequences@TRZSP_SUN 	where SEQUENCE_OWNER = 'TX') AS total_sequences
FROM dual;




desc dba_constraints

select count(1),owner,table_name, 'source'--,STATUS
from dba_constraints@TRZSP_SUN
where owner = 'TX'
and table_name ='RDX_SYSTEM'
group by owner,table_name--,STATUS
union all 
select count(1),owner,table_name, 'target'--,STATUS
from dba_constraints
where owner = 'TX'
and table_name ='RDX_SYSTEM'
group by owner,table_name--,STATUS
order by 


select count(1),owner,table_name,CONSTRAINT_TYPE, 'source'--,STATUS
from dba_constraints@TRZSP_SUN
where owner = 'TX'
and table_name ='RDX_SYSTEM'
group by owner,table_name,CONSTRAINT_TYPE--,STATUS
union all
select count(1),owner,table_name,CONSTRAINT_TYPE, 'target'--,STATUS
from dba_constraints
where owner = 'TX'
and table_name ='RDX_SYSTEM'
group by owner,table_name,CONSTRAINT_TYPE;--,STATUS


select count(1),owner,table_name,CONSTRAINT_TYPE, 'source'--,STATUS
from dba_constraints@TRZSP_SUN
where owner = 'TX'
and table_name ='RDX_SYSTEM'
and CONSTRAINT_TYPE='C'
group by owner,table_name,CONSTRAINT_TYPE--,STATUS
union all
select count(1),owner,table_name,CONSTRAINT_TYPE, 'target'--,STATUS
from dba_constraints
where owner = 'TX'
and table_name ='RDX_SYSTEM'
and CONSTRAINT_TYPE='C'
group by owner,table_name,CONSTRAINT_TYPE
order by 4
/




select count(1),owner,table_name,CONSTRAINT_TYPE--,STATUS
from dba_constraints@TRZSP_SUN
where owner = 'TX'
and table_name ='RDX_SYSTEM'
group by owner,table_name,CONSTRAINT_TYPE--,STATUS
minus
select count(1),owner,table_name,CONSTRAINT_TYPE--,STATUS
from dba_constraints
where owner = 'TX'
and table_name ='RDX_SYSTEM'
group by owner,table_name,CONSTRAINT_TYPE;--,STATUS;


select owner,table_name, CONSTRAINT_NAME,CONSTRAINT_TYPE
from dba_constraints@TRZSP_SUN
where owner = 'TX'
and table_name ='RDX_SYSTEM'
minus
select owner,table_name, CONSTRAINT_NAME,CONSTRAINT_TYPE
from dba_constraints
where owner = 'TX'
and table_name ='RDX_SYSTEM';





 Name                                                                                                  Null?    Type
 ----------------------------------------------------------------------------------------------------- -------- --------------------------------------------------------------------
 OWNER                                                                                                          VARCHAR2(128)
 CONSTRAINT_NAME                                                                                       NOT NULL VARCHAR2(128)
 CONSTRAINT_TYPE                                                                                                VARCHAR2(1)
 TABLE_NAME                                                                                            NOT NULL VARCHAR2(128)
 SEARCH_CONDITION                                                                                               LONG
 SEARCH_CONDITION_VC                                                                                            VARCHAR2(4000)
 R_OWNER                                                                                                        VARCHAR2(128)
 R_CONSTRAINT_NAME                                                                                              VARCHAR2(128)
 DELETE_RULE                                                                                                    VARCHAR2(9)
 STATUS                                                                                                         VARCHAR2(8)
 DEFERRABLE                                                                                                     VARCHAR2(14)
 DEFERRED                                                                                                       VARCHAR2(9)
 VALIDATED                                                                                                      VARCHAR2(13)
 GENERATED                                                                                                      VARCHAR2(14)
 BAD                                                                                                            VARCHAR2(3)
 RELY                                                                                                           VARCHAR2(4)
 LAST_CHANGE                                                                                                    DATE
 INDEX_OWNER                                                                                                    VARCHAR2(128)
 INDEX_NAME                                                                                                     VARCHAR2(128)
 INVALID                                                                                                        VARCHAR2(7)
 VIEW_RELATED                                                                                                   VARCHAR2(14)
 ORIGIN_CON_ID                                                                                                  NUMBER








asmcmd
lsdg

    cd +DATA_TRZSP/TRZSP/DATAFILE
    rm *

    cd +DATA_TRZSP/TRZSP/CONTROLFILE
    rm *

    cd +DATA_TRZSP/TRZSP/TEMFILE
    rm *


    cd +FRA/TRZSP/ARCHIVELOG
    rm *

    cd +FRA/TRZSP/CONTROLFILE
    rm *

    cd  +FRA/TRZSP/FLASHBACK
    rm *

    cd +REDO01_TRZSP/TRZSP
    rm -fr ONLINELOG 

    cd +REDO02_TRZSP/TRZSP
    rm -fr ONLINELOG





***********************************


select 'ALTER SYSTEM SET STREAMS_POOL_SIZE='||(max(to_number(trim(c.ksppstvl)))+67108864)||' SCOPE=SPFILE;'
from sys.x$ksppi a
, sys.x$ksppcv b
, sys.x$ksppsv c 
where a.indx = b.indx 
and a.indx = c.indx 
and lower(a.ksppinm) in ('__streams_pool_size','streams_pool_size');




select component, current_size/1048576, max_size/1048576 from v$sga_dynamic_components where component='streams pool';




select component, current_size/1048576, max_size/1048576 from v$sga_dynamic_components;


alter system set large_pool_size=10G; --2
alter system set streams_pool_size=30G; --40
alter system set aq_tm_processes=1; --10


select segment_name, partition_name, bytes/1024/1024/1024 x from dba_segments
where segment_name ='RDX_EVENTLOG';




select segment_name, partition_name, bytes/1024/1024/1024 x from dba_segments

