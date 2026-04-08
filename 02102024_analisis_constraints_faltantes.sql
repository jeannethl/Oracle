

analisis cosntraints 
select  owner,  object_name,SUBOBJECT_NAME, status, 'source'
from dba_objects@trzsp_sun
where owner = 'TX'
and object_type in( 'TABLE PARTITION')
union all
select owner,  object_name,SUBOBJECT_NAME, status, 'target'
from dba_objects
where owner = 'TX'
and object_type in( 'TABLE PARTITION')
order by 2,3,5



select count(1), owner, object_type, status, 'source'
from dba_objects@trzsp_sun
where owner = 'TX'
and object_type in( 'LOB PARTITION','TABLE PARTITION', 'INDEX PARTITION')
group by owner, object_type, status
union all
select count(1), owner, object_type, status, 'target'
from dba_objects
where owner = 'TX'
and object_type in( 'LOB PARTITION','TABLE PARTITION', 'INDEX PARTITION')
group by owner, object_type, status
order by 3,5


select count(1), owner, object_type, status
from dba_objects@trzsp_sun
where owner = 'TX'
--and object_type in( 'LOB PARTITION','TABLE PARTITION', 'INDEX PARTITION')
group by owner, object_type, status
minus
select count(1), owner, object_type, status
from dba_objects
where owner = 'TX'
--and object_type in( 'LOB PARTITION','TABLE PARTITION', 'INDEX PARTITION')
group by owner, object_type, status



select count(1),owner,table_name,CONSTRAINT_TYPE, SEARCH_CONDITION_VC--, 'SOURCE'
from dba_constraints@TRZSP_SUN
where owner = 'TX'
and table_name in( 'TOKEN')
and CONSTRAINT_TYPE='C'
group by owner,table_name,CONSTRAINT_TYPE,SEARCH_CONDITION_VC
minus
select count(1),owner,table_name,CONSTRAINT_TYPE, SEARCH_CONDITION_VC--, 'TARGET'
from dba_constraints
where owner = 'TX'
and table_name in( 'TOKEN')
and CONSTRAINT_TYPE='C'
group by owner,table_name,CONSTRAINT_TYPE, SEARCH_CONDITION_VC
order by 3,4,5,6;



select count(1),owner,table_name,CONSTRAINT_TYPE, 'SOURCE'--,STATUS
from dba_constraints@TRZSP_SUN
where owner = 'TX'
and table_name in( 'TOKEN')
and CONSTRAINT_TYPE='C'
group by owner,table_name,CONSTRAINT_TYPE--,STATUS
union all
select count(1),owner,table_name,CONSTRAINT_TYPE, 'TARGET'--,STATUS
from dba_constraints
where owner = 'TX'
and table_name in( 'TOKEN')
and CONSTRAINT_TYPE='C'
group by owner,table_name,CONSTRAINT_TYPE
order by 3,4,5;--,STATUS;


select count(1),owner,table_name,CONSTRAINT_TYPE--,STATUS
from dba_constraints@TRZSP_SUN
where owner = 'TX'
--and table_name ='RDX_SYSTEM'
group by owner,table_name,CONSTRAINT_TYPE--,STATUS
minus
select count(1),owner,table_name,CONSTRAINT_TYPE--,STATUS
from dba_constraints
where owner = 'TX'
--and table_name ='RDX_SYSTEM'
group by owner,table_name,CONSTRAINT_TYPE;--,STATUS;