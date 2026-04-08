srvctl status instance -d <nombre_base_datos> -i <nombre_instancia> --- VER EL STATUS

srvctl start instance -d <nombre_base_datos> -i <nombre_instancia> --- SUBIR EL NODO

srvctl stop instance -d <nombre_base_datos> -i <nombre_instancia> --- BAJAR EL NODO


srvctl status instance -d CYCLOPSP -i CYCLOPSP1
srvctl start instance -d CYCLOPSP -i CYCLOPSP1
srvctl stop instance -d CYCLOPSP -i CYCLOPSP1





    





SET LINESIZE 999 
SET PAGES 150
SET PAGESIZE 150                  
COLUMN USERNAME FORMAT A20     
COLUMN STATUS FORMAT A15       
COLUMN OSUSER FORMAT A20       
COLUMN MACHINE FORMAT A20      
COLUMN PROGRAM FORMAT A25      
COLUMN LOGON_TIME FORMAT A20   
SELECT  
    SID, 
    USERNAME, 
    STATUS,  
    MACHINE, 
    PROGRAM, 
    LOGON_TIME
FROM 
    V$SESSION
WHERE 
    STATUS = 'ACTIVE'  
ORDER BY 
    LOGON_TIME DESC;   

