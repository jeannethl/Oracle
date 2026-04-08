#-- Indice --#
1.- Validar estatus de las tablas
2.- Validar size de las tablas
3.- Validar espacio disponible en tablespace destino
4.- Ejecutar Pl/Sql


#-- Pasos --#


NOTA: Los pasos presentados estan certificados para oracle 11g


1.- Validar estatus de las tablas
---------------------------------


SELECT OWNER
, TABLE_NAME
, STATUS
, TABLESPACE_NAME
FROM dba_tables
where OWNER='MPOS'
--AND TABLESPACE_NAME = 'USERS'
/



2.- Validar size de las tablas
-------------------------------


2.1.- Size all tablas


set line 180
col owner for a15
col segment_name for a30
col "SIZE_MB" for 999,999,999.00
select owner
,segment_name
,sum(bytes)/1024/1024 as "SIZE_MB"
from dba_segments
where owner='MPOS'
and SEGMENT_TYPE='TABLE'
and TABLESPACE_NAME = 'USERS'
group by owner
,segment_name
order by "SIZE_MB"
/


2.2.- Size total tablas


select sum(bytes)/1024/1024 as "SIZE_MB"
from dba_segments
where owner='MPOS'
and SEGMENT_TYPE='TABLE'
and TABLESPACE_NAME = 'USERS'
group by 1
/


#-- Bibliografia --#

https://oracle-admin.com/2014/02/25/find-size-of-tableindex-and-userschema-in-oracle/


3.- Validar espacio disponible en tablespace destino
----------------------------------------------------


set pages 999
col tablespace_name format a40
col "size MB" format 999,999,999
col "free MB" format 999,999,999
col "% Used" format 999
select  tsu.tablespace_name, ceil(tsu.used_mb) "size MB"
, decode(ceil(tsf.free_mb), NULL,0,ceil(tsf.free_mb)) "free MB"
, decode(100 - ceil(tsf.free_mb/tsu.used_mb*100), NULL, 100,
               100 - ceil(tsf.free_mb/tsu.used_mb*100)) "% used"
from  (select tablespace_name, sum(bytes)/1024/1024 used_mb
from  dba_data_files group by tablespace_name) tsu
, (select tablespace_name, sum(bytes)/1024/1024 free_mb
from  dba_free_space group by tablespace_name) tsf
where tsu.tablespace_name = tsf.tablespace_name (+)
--and tsu.tablespace_name = 'MPOS_DATA'
order by 4
/


NOTA: Debe poseer espacio igual o mayor al del peso total de los indexes obtenido en el paso anterior.


4.- Ejecutar Pl/Sql
-------------------


SET SERVEROUTPUT ON
DECLARE
nom_tabla dba_tables.TABLE_NAME%type;
owner_table dba_tables.owner%type;
CURSOR c_tablas IS
select TABLE_NAME
, owner
from dba_tables
where owner = 'MAESTRO'
AND tablespace_name = 'USERS';

BEGIN
OPEN c_tablas;
LOOP
fetch c_tablas into nom_tabla,owner_table;
exit when c_tablas%notfound;
BEGIN
-- dbms_output.put_line ('ALTER INDEX "' ||owner_table||'"."'|| nom_tabla|| '" REBUILD TABLESPACE MPOS_DATA');
EXECUTE IMMEDIATE 'ALTER TABLE "' ||owner_table||'"."'|| nom_tabla|| '" MOVE TABLESPACE DATA';
EXCEPTION
WHEN OTHERS THEN
dbms_output.put_line ('ERROR:  "' ||owner_table||'.'|| nom_tabla);
END;
END LOOP;
CLOSE c_tablas;
END;
/




ALTER TABLE MPOS.MP_H_CONTADOR_TX_P MOVE;



Option: 1 Alter table move (to another tablespace, or same tablespace) and rebuild indexes:
-------------------------------------------------------------------------------------------
Recopilar el estado de todos los índices en la tabla
----------------------------------------------------
We will record Index status at one place, So that we get back them after completion of this exercise,


select index_name
,status
from dba_indexes
where table_name = 'MP_H_CONTADOR_TX_P';


Move table in to same or new tablespace:
----------------------------------------

En este paso, moveremos la tabla fragmentada al mismo espacio de tabla o de un espacio de tabla a otro para recuperar espacio fragmentado. Encuentre el tamaño actual de su tabla en dba_segments y verifique si el mismo o cualquier otro espacio de tabla tiene el mismo espacio libre disponible. Entonces, podemos mover esta tabla al mismo o nuevo espacio de tabla.


Pasos para mover la tabla al mismo espacio de tabla:
----------------------------------------------------


select sum(bytes)/1024/1024 as "SIZE_MB"
from dba_segments
where owner='MPOS'
and SEGMENT_TYPE='TABLE'
and SEGMENT_NAME = 'MP_H_MENSAJES_ENVIADOS_P'
group by 1
/

alter table MPOS.MP_H_MENSAJES_ENVIADOS_P move;

OR

Steps to Move table in to new tablespace:
----------------------------------------
alter table <table_name> enable row movement;
alter table <table_name> move tablespace <new_tablespace_name>;

Now, get back table to old tablespaces using below command

alter table table_name move tablespace old_tablespace_name;

Now,Rebuild all indexes:
-----------------------
We need to rebuild all the indexes on the table because of move command all the index goes into unusable state.


select index_name
,status
from dba_indexes
where table_name = 'MP_H_CONTADOR_TX_P';


STATUS INDEX_NAME
-------- ------------------------------
UNUSABLE INDEX_NAME                            -------> Here, value in status field may be valid or unusable.

SQL> alter index <INDEX_NAME> rebuild online;  -------> Use this command for each index
Index altered.

SQL> select status,index_name from dba_indexes where table_name = '&table_name';

STATUS INDEX_NAME
-------- ------------------------------
VALID INDEX_NAME

Gather table stats:
------------------

exec dbms_stats.gather_table_stats('MPOS','MP_H_CONTADOR_TX_P');

PL/SQL procedure successfully completed.

Check Table size:
-----------------
Now again check table size using and will find reduced size of the table.



Check for Fragmentation in table:
--------------------------------

col
set pages 50000 lines 32767
select owner
,table_name
,round((blocks*8),2)||'kb' "Fragmented size"
, round((num_rows*avg_row_len/1024),2)||'kb' "Actual size"
, round((blocks*8),2)-round((num_rows*avg_row_len/1024),2)||'kb',
((round((blocks*8),2)-round((num_rows*avg_row_len/1024),2))/round((blocks*8),2))*100 -10 "reclaimable space % "
from dba_tables
where table_name ='MP_H_CONTADOR_TX_P'
AND OWNER LIKE 'MPOS'
/


col table_name for a30
col "TOTAL_SIZE_MB" for 999,999,999.00
col "ACTUAL_SIZE_MB" for 999,999,999.00
col "FRAGMENTED_SPACE_MB" for 999,999,999.00
col "percentage" for 999
select table_name
,avg_row_len
,round(((blocks*16/1024)),2) "TOTAL_SIZE_MB"
,round((num_rows*avg_row_len/1024/1024),2) "ACTUAL_SIZE_MB"
,round(((blocks*16/1024)-(num_rows*avg_row_len/1024/1024)),2)  "FRAGMENTED_SPACE_MB"
,(round(((blocks*16/1024)-(num_rows*avg_row_len/1024/1024)),2)/round(((blocks*16/1024)),2))*100 "percentage"
from dba_tables
WHERE owner = 'MPOS'
--and table_name ='MP_H_CONTADOR_TX_P'
and round((num_rows*avg_row_len/1024/1024),2) > 1
order by "percentage" desc
/