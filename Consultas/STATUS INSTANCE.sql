Status de la instance

-- Muestra las tablas

desc gv$instance


-- Consulta el estado de la BD
select instance_name, status, startup_time from gv$instance;

--------------- EJEMPLO ----------------

INSTANCE_NAME    STATUS       STARTUP_T
---------------- ------------ ---------
CCENNLNH         OPEN         14-NOV-24


-- Modifica para que muestre la hora
ALTER SESSION SET NLS_DATE_FORMAT = "DD/MM/YYYY HH24:MI:SS";