/*
OWNER: El propietario del segmento.
SEGMENT_NAME: El nombre del segmento (tabla, índice, etc.).
SEGMENT_TYPE: El tipo de segmento (TABLE, INDEX, etc.).
SIZE_MB: Tamaño del objeto en megabytes.
Asegúrate de tener los permisos necesarios para acceder a DBA_SEGMENTS.
*/
-- 1. Listar todos los objetos en un tablespace específico
SELECT OWNER, SEGMENT_NAME AS OBJECT_NAME, SEGMENT_TYPE AS OBJECT_TYPE
FROM DBA_SEGMENTS
WHERE TABLESPACE_NAME = 'NOMBRE_DEL_TABLESPACE'  -- Reemplaza con el nombre del tablespace
ORDER BY OBJECT_TYPE, OBJECT_NAME;  -- Ordena los resultados por tipo y nombre de objeto

-- 2. Listar los 20 objetos más pesados en un tablespace específico
SELECT *
FROM (
    SELECT OWNER, SEGMENT_NAME AS OBJECT_NAME, SEGMENT_TYPE AS OBJECT_TYPE, 
           ROUND(SUM(BYTES) / 1024 / 1024, 2) AS SIZE_MB  -- Calcula el tamaño en MB
    FROM DBA_SEGMENTS
    WHERE TABLESPACE_NAME = 'DATA'  -- Reemplaza con el nombre del tablespace
    GROUP BY OWNER, SEGMENT_NAME, SEGMENT_TYPE  -- Agrupa por propietario, nombre y tipo de objeto
    ORDER BY SIZE_MB DESC  -- Ordena los resultados por tamaño en orden descendente
)
WHERE ROWNUM <= 20;  -- Limita los resultados a los 20 objetos más pesados

--3 La consulta completa está diseñada para identificar y devolver los 20 segmentos más grandes en términos de tamaño en megabytes dentro del tablespace 'DATA', permitiendo así un análisis efectivo del uso del espacio en disco en la base de datos
SELECT * 
FROM (
    -- Subconsulta que selecciona el nombre del segmento y su tamaño total en MB
    SELECT SEGMENT_NAME, SUM(BYTES)/1024/1024 AS MB 
    FROM DBA_EXTENTS  -- Consulta la vista que contiene información sobre los extents
    WHERE TABLESPACE_NAME = 'NOMBRE_DEL_TABLESPACE'  -- Filtra para incluir solo los segmentos en el tablespace 'DATA'
    GROUP BY SEGMENT_NAME  -- Agrupa los resultados por el nombre del segmento
    ORDER BY MB DESC  -- Ordena los resultados de mayor a menor según el tamaño en MB
)
WHERE ROWNUM <= 20;  -- Limita los resultados a las primeras 20 filas

--EJEMPLO 1
SELECT *
FROM (
    SELECT OWNER, SEGMENT_NAME AS OBJECT_NAME, SEGMENT_TYPE AS OBJECT_TYPE, 
           ROUND(SUM(BYTES) / 1024 / 1024, 2) AS SIZE_MB
    FROM DBA_SEGMENTS
    WHERE TABLESPACE_NAME = 'DATA'
    GROUP BY OWNER, SEGMENT_NAME, SEGMENT_TYPE
    ORDER BY SIZE_MB DESC
)
WHERE ROWNUM <= 20;

--EJEMPLO 2
SELECT OWNER, SEGMENT_NAME AS OBJECT_NAME, SEGMENT_TYPE AS OBJECT_TYPE
FROM DBA_SEGMENTS
WHERE TABLESPACE_NAME = 'DATA'
ORDER BY OBJECT_TYPE, OBJECT_NAME;

--EJEMPLO 3
SELECT * 
FROM (
SELECT SEGMENT_NAME, SUM(BYTES)/1024/1024 AS MB 
FROM DBA_EXTENTS
WHERE TABLESPACE_NAME = 'DATA'
GROUP BY SEGMENT_NAME
ORDER BY MB DESC
)
WHERE ROWNUM <= 20;


