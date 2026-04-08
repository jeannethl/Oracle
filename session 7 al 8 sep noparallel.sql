session 7sep - 8sep


Modificar Paralelismo de las TABLAS
--
--
--ALTER TABLE TX.POSTING PARALLEL 16;
--
--ALTER TABLE TX.DOEREXTMSG PARALLEL 16;



ALTER TABLE TX.POSTING NOPARALLEL;
ALTER TABLE TX.DOEREXTMSG NOPARALLEL;


select COUNT(1), machine
from Gv$session b
where username IS NOT NULL
GROUP BY machine
order by 2;


set line 240

set pagesize 300

col username format a20
col MACHINE format a80
select count(1), username , inst_id, MACHINE from gv$session
--where username='BDVNET'
 group by username, inst_id, machine
 order by 1
/


----------------
-CONTAR SESSIONES CONECTADAS POR USUARIO (sencillo) EL MAS USADO

col username format a20
col machine format a80
col SERVICE_NAME format a25
select count(1) count
      ,username
      ,inst_id
      ,machine
      ,service_name
  from gv$session
where username is  NOT NULL
group by username, inst_id, machine, service_name
order by 2,3
/

--------------------------


Reallocate service

antes crsctl stat res -t para verificar en que nodo se encuentra el servicio.


srvctl relocate service -db TRZSP -service trzsp_ap -oldinst TRZSP1 -newinst TRZSP3

srvctl relocate service -db TRZSP -service trzsp_ap -oldinst TRZSP3 -newinst TRZSP1


srvctl database -d TRZSP service trzsp_ap


