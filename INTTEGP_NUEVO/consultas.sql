
ALTER SESSION SET CURRENT_SCHEMA = INTTEGRIOBDV;
ALTER SESSION SET CURRENT_SCHEMA = INVPL;
invpl
set lines 1000;
set pages 1000;
set markup csv on;
------------------------------------
--- SE MODIFICA EL ARCHIVO SPOOL para que no sobreescriba los anteriores
spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_090825_2952.csv
------------------------------------------------------------------------------------------------------------
select systimestamp as inicio from dual;
set termout off;
------------------------------------------------------------------------------------------------------------
--
-- CONSULTA BASE -- MODIFICABLE
------------------------------------------------------------------------------------------------------------
SELECT * FROM inttegriobdv.TMENSAJESCOEXRECIBIDOS WHERE FPROCESO BETWEEN TIMESTAMP '2025-08-08 00:00:00.0' AND TIMESTAMP '2025-08-08 23:59:00.0' AND ccuenta ='01020                                                                    117920000132952';

set markup csv off;
set termout on;
select systimestamp as fin from dual;
------------------------------------------------------------------------------------------------------------
spool off
------------------------------------------------------------------------------------------------------------




--PRODUCCION
set lines 1000;
set pages 1000;
set markup csv on;
------------------------------------
--- SE MODIFICA EL ARCHIVO SPOOL para que no sobreescriba los anteriores
spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_080825_1330.csv
------------------------------------------------------------------------------------------------------------
select systimestamp as inicio from dual;
set termout off;
------------------------------------------------------------------------------------------------------------
--
-- CONSULTA BASE -- MODIFICABLE
------------------------------------------------------------------------------------------------------------
SELECT * FROM inttegriobdv.TMENSAJESCOEXRECIBIDOS WHERE FPROCESO BETWEEN TIMESTAMP '2025-08-08 00:00:00.0' AND TIMESTAMP '2025-08-08 01:30:00.0';
spool off

spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_080825_1430.csv

SELECT * FROM inttegriobdv.TMENSAJESCOEXRECIBIDOS WHERE FPROCESO BETWEEN TIMESTAMP '2025-08-08 13:30:00.0' AND TIMESTAMP '2025-08-08 14:30:00.0';

set markup csv off;
set termout on;
select systimestamp as fin from dual;
------------------------------------------------------------------------------------------------------------
spool off
------------------------------------------------------------------------------------------------------------+


--CALIDAD
set lines 1000;
set pages 1000;
set markup csv on;
------------------------------------
--- SE MODIFICA EL ARCHIVO SPOOL para que no sobreescriba los anteriores
spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_080825_619.csv
------------------------------------------------------------------------------------------------------------
ALTER SESSION SET CURRENT_SCHEMA=INTTEGRIOBDV;

select systimestamp as inicio from dual;
set termout off;
------------------------------------------------------------------------------------------------------------
--
-- CONSULTA BASE -- MODIFICABLE
------------------------------------------------------------------------------------------------------------
select * from tmensajescoexrecibidos WHERE FPROCESO BETWEEN TIMESTAMP '2025-08-08 00:00:00.0' AND TIMESTAMP '2025-08-08 23:59:59.9' and  ccuenta ='01020190010000158619';


spool off

spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_080825_220.csv

select * from tmensajescoexrecibidos WHERE FPROCESO BETWEEN TIMESTAMP '2025-08-08 00:00:00.0' AND TIMESTAMP '2025-08-08 23:59:59.9' and  ccuenta ='01020221340000864220';


set markup csv off;
set termout on;
select systimestamp as fin from dual;
------------------------------------------------------------------------------------------------------------
spool off
------------------------------------------------------------------------------------------------------------+





set lines 1000;
set pages 1000;
set markup csv on;
------------------------------------
--- SE MODIFICA EL ARCHIVO SPOOL para que no sobreescriba los anteriores
spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_270825_4278.csv
------------------------------------------------------------------------------------------------------------
select systimestamp as inicio from dual;
set termout off;
------------------------------------------------------------------------------------------------------------
--
-- CONSULTA BASE -- MODIFICABLE
------------------------------------------------------------------------------------------------------------
SELECT * FROM inttegriobdv.TLOGMENSAJESCOEXISTENCIA t WHERE t.CCUENTA = '010201190030100014278' AND t.FREAL BETWEEN TIMESTAMP '2025-08-27 16:30:00.0' AND TIMESTAMP '2025-08-27 16:40:59.9';
set markup csv off;
set termout on;
select systimestamp as fin from dual;
------------------------------------------------------------------------------------------------------------
spool off
------------------------------------------------------------------------------------------------------------



set lines 1000;
set pages 1000;
set markup csv on;
------------------------------------
--- SE MODIFICA EL ARCHIVO SPOOL para que no sobreescriba los anteriores
spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_270825_2568.csv
------------------------------------------------------------------------------------------------------------
select systimestamp as inicio from dual;
set termout off;
------------------------------------------------------------------------------------------------------------
--
-- CONSULTA BASE -- MODIFICABLE
------------------------------------------------------------------------------------------------------------
SELECT * FROM inttegriobdv.TLOGMENSAJESCOEXISTENCIA t WHERE t.CCUENTA = '01020777140005152568' AND t.FREAL BETWEEN TIMESTAMP '2025-08-27 16:30:00.0' AND TIMESTAMP '2025-08-27 16:40:59.9';
set markup csv off;
set termout on;
select systimestamp as fin from dual;
------------------------------------------------------------------------------------------------------------
spool off
------------------------------------------------------------------------------------------------------------





SELECT * FROM TLOGMENSAJESCOEXISTENCIA t WHERE t.CCUENTA = '01020117920000132952' AND t.FREAL BETWEEN TIMESTAMP '2025-08-27 16:30:00.0' AND TIMESTAMP '2025-08-27 16:40:59.9' 

SELECT * FROM TLOGMENSAJESCOEXISTENCIA t WHERE t.CCUENTA = '01020777140005152568' AND t.FREAL BETWEEN TIMESTAMP '2025-08-27 16:30:00.0' AND TIMESTAMP '2025-08-27 16:40:59.9'














set lines 1000;
set pages 1000;
set markup csv on;
------------------------------------
--- SE MODIFICA EL ARCHIVO SPOOL para que no sobreescriba los anteriores
spool /home/oracle19/scripts/consulta/inttegriobdv.TMENSAJESCOEXRECIBIDOS_270825_4278.csv
------------------------------------------------------------------------------------------------------------
select systimestamp as inicio from dual;
set termout off;
------------------------------------------------------------------------------------------------------------
--
-- CONSULTA BASE -- MODIFICABLE
------------------------------------------------------------------------------------------------------------
SELECT * FROM inttegriobdv.TLOGMENSAJESCOEXISTENCIA t WHERE t.CCUENTA = '010201190030100014278' AND t.FREAL BETWEEN TIMESTAMP '2025-08-27 16:30:00.0' AND TIMESTAMP '2025-08-27 16:40:59.9';
set markup csv off;
set termout on;
select systimestamp as fin from dual;
------------------------------------------------------------------------------------------------------------
spool off
------------------------------------------------------------------------------------------------------------
♥☺☻♦♣8•◘○♠◙♂♂♀♀♪