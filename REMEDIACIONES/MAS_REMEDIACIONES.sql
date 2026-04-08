--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Estadisticas obsoletas.

--1. Limpiar Información de Monitoreo
--Ejecuta el siguiente comando para limpiar la información de monitoreo de la base de datos:

exec dbms_stats.FLUSH_DATABASE_MONITORING_INFO();

--2. Listar Objetos con Estadísticas Obsoletas
Ejecuta la siguiente consulta para obtener la lista de todos los objetos con estadísticas obsoletas (excluyendo los objetos de los esquemas SYS, SYSTEM, SYSMAN, DBSNMP):

set lines 120
column owner format a20
column table_name format a30

SELECT DT.OWNER,
       DT.TABLE_NAME,
       DT.LAST_ANALYZED,
       ROUND((DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) AS STALE_PERCENT,
       NUM_ROWS
FROM   DBA_TABLES DT
JOIN   DBA_TAB_MODIFICATIONS DTM ON DT.OWNER = DTM.TABLE_OWNER AND DT.TABLE_NAME = DTM.TABLE_NAME
WHERE  NUM_ROWS > 0 
       AND ROUND((DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) >= 10
       AND OWNER NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
ORDER BY STALE_PERCENT DESC, NUM_ROWS DESC;


--3. Actualizar Estadísticas para Múltiples Tablas
BEGIN
  FOR rec IN (
    SELECT DT.OWNER, DT.TABLE_NAME
    FROM   DBA_TABLES DT
    JOIN   DBA_TAB_MODIFICATIONS DTM ON DT.OWNER = DTM.TABLE_OWNER AND DT.TABLE_NAME = DTM.TABLE_NAME
    WHERE  NUM_ROWS > 0  -- Asegúrate de que NUM_ROWS sea mayor que cero
           AND ROUND((DELETES + UPDATES + INSERTS) / NUM_ROWS * 100) >= 10
           AND OWNER NOT IN ('SYS', 'SYSTEM', 'SYSMAN', 'DBSNMP')
  ) LOOP
    DBMS_STATS.GATHER_TABLE_STATS(rec.OWNER, rec.TABLE_NAME);
  END LOOP;
END;
/


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Pasos para Cambiar el MTU del Adaptador Loopback
    --Cambiar el MTU:
    --Ejecuta el siguiente comando para cambiar el tamaño de MTU del adaptador loopback:
sudo ip link set dev lo mtu 16436
    --Verificar el Cambio:
    
    --Después de ejecutar el comando, verifica que el cambio se haya realizado correctamente:
ip link show lo
    --Deberías ver una salida similar a esta:
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 16436 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

    --Reiniciar Servicios de Red:
    --Para asegurarte de que todos los servicios reconozcan el nuevo tamaño de MTU, es recomendable reiniciar los servicios de red. Dependiendo de tu sistema, puedes usar
sudo systemctl restart network
    
    --Cambio Persistente
    --Edita el archivo correspondiente al adaptador loopback
sudo vi /etc/sysconfig/network-scripts/ifcfg-lo
--Tu archivo debería verse así:
DEVICE=lo
IPADDR=127.0.0.1
NETMASK=255.0.0.0
NETWORK=127.0.0.0
BROADCAST=127.255.255.255
ONBOOT=yes
NAME=loopback
MTU=16436
    --Reiniciar nuevamente
sudo systemctl restart network
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Temporary location is not configured for auto cleanup
--Crear el archivo
vi /etc/tmpfiles.d/oracleGI.conf

--Colocar estos en el archivo
x /tmp/.oracle*
x /var/tmp/.oracle*
x /usr/tmp/.oracle*
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------