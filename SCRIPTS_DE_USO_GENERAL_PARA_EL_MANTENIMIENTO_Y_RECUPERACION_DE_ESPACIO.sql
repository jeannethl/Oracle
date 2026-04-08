----------------------------------------------------------------------------------------
-- SCRIPTS DE USO GENERAL PARA EL MANTENIMIENTO Y RECUPERACION DE ESPACIO EN DATAFILES
----------------------------------------------------------------------------------------
-- DBA TEAM ADSI - 01/08/2024
-- RECOMENDACIONES: 
--  1) ANALIZAR EL ENTORNO Y LA EJECUCIÓN DEL PROCEDIMIENTO A REALIZAR.
--  2) REALIZAR LOS PROCEDIMIENTOS DE MANERA ORDENADA, EN CONSOLAS DIFERENTES.
--  
--  LOS SCRIPTS INDICADOS EN EL PRESENTE DOCUMENTO NO SON PRESENTADOS EN ORDEN DE EJECUCIÓN
--  SINO REFERENCIAL SEGÚN SU USO.    
--------------------------------------------------------
-- 1)  SCRIPT PARA VERFICAR ESPACIO DE UNA BBDD ORACLE
--------------------------------------------------------

SELECT ROUND(SUM(USED.BYTES) / 1024 / 1024 / 1024 ) "DATABASE SIZE IN GB",
        ROUND(SUM(USED.BYTES) / 1024 / 1024 / 1024 ) - ROUND(FREE.P / 1024 / 1024 / 1024) "USED SPACE IN GB",
        ROUND(FREE.P / 1024 / 1024 / 1024) "FREE SPACE IN GB"
FROM (SELECT BYTES FROM V$DATAFILE
      UNION ALL
      SELECT BYTES
      FROM V$TEMPFILE
      UNION ALL
      SELECT BYTES
      FROM V$LOG) USED, (SELECT SUM(BYTES) AS P
      FROM DBA_FREE_SPACE) FREE GROUP BY FREE.P;

--------------------------------------------------------
--------------------------------------------------------
-- 2) SCRIPT PARA VERIFICAR TAMAÑO DE LOS DISKGROUPS
--------------------------------------------------------

    su - grid

    asmcmd lsdg

--------------------------------------------------------
--------------------------------------------------------
-- 3) SCRIPT PARA VERIFICAR TAMAÑO DE TABLESPACES
--------------------------------------------------------

        SET PAGES 999
        COL TABLESPACE_NAME FORMAT A40
        COL "SIZE MB" FORMAT 999,999,999
        COL "FREE MB" FORMAT 99,999,999
        COL "% USED" FORMAT 999
        SELECT INSTANCE_NAME FROM V$INSTANCE;
        SELECT TSU.TABLESPACE_NAME
                , CEIL(TSU.USED_MB) "SIZE MB"
                , DECODE(CEIL(TSF.FREE_MB), NULL,0,CEIL(TSF.FREE_MB)) "FREE MB"
                , DECODE(100 - CEIL(TSF.FREE_MB/TSU.USED_MB*100), NULL, 100,
                        100 - CEIL(TSF.FREE_MB/TSU.USED_MB*100)) "% USED"
        FROM (SELECT TABLESPACE_NAME
                        , SUM(BYTES)/1024/1024 USED_MB
                FROM DBA_DATA_FILES
                GROUP BY TABLESPACE_NAME
                UNION ALL
                SELECT TABLESPACE_NAME || '  **TEMP**'
                        , SUM(BYTES)/1024/1024 USED_MB
                FROM DBA_TEMP_FILES
                GROUP BY TABLESPACE_NAME) TSU
        , (SELECT TABLESPACE_NAME
                        , SUM(BYTES)/1024/1024 FREE_MB
                FROM DBA_FREE_SPACE
                GROUP BY TABLESPACE_NAME) TSF
        WHERE TSU.TABLESPACE_NAME = TSF.TABLESPACE_NAME (+)
        ORDER BY 4
        /

--------------------------------------------------------
--------------------------------------------------------
-- 4) SCRIPT PARA MANEJO DE LA MARCA DE AGUA
--------------------------------------------------------   

        SET VERIFY OFF
        SET LINE 180 PAGES 1000
        COL VALUE FORMAT A20
        COLUMN FILE_NAME FORMAT A80 WORD_WRAPPED
        COLUMN SMALLEST FORMAT 999,990 HEADING "SMALLEST|SIZE|POSS."
        COLUMN CURRSIZE FORMAT 999,990 HEADING "CURRENT|SIZE"
        COLUMN SAVINGS FORMAT 999,999,990 HEADING "POSS.|SAVINGS"
        BREAK ON REPORT
        COMPUTE SUM LABEL "TOTAL_SAVE:" OF SAVINGS ON REPORT
        COLUMN VALUE NEW_VAL BLKSIZE
        SELECT VALUE 
        FROM V$PARAMETER 
        WHERE NAME = 'DB_BLOCK_SIZE'
        /
        SELECT FILE_NAME,
            CEIL( (NVL(HWM,1)*&&BLKSIZE)/1024/1024 ) SMALLEST,
            CEIL( BLOCKS*&&BLKSIZE/1024/1024) CURRSIZE,
            CEIL( BLOCKS*&&BLKSIZE/1024/1024) -
            CEIL( (NVL(HWM,1)*&&BLKSIZE)/1024/1024 ) SAVINGS
        FROM DBA_DATA_FILES A,
            ( SELECT FILE_ID
            , MAX(BLOCK_ID+BLOCKS-1) HWM
            FROM DBA_EXTENTS
            GROUP BY FILE_ID ) B
        WHERE A.FILE_ID = B.FILE_ID(+)
        -- ORDER BY SAVINGS 
        /

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- 5) SCRIPT CON ALTERS PARA REDIMENSIONAR DATAFILES DE UN TABLESPECE EN ESPECIFICO 
------------------------------------------------------------------------------------

    -- NOTA: SI SE DESEA, SE INDICA UN TABLESPACE ESPECÍFICO SINO SE COMENTA 
        SET PAGES 1000
        COLUMN CMD FORMAT A150 WORD_WRAPPED
        SELECT 'ALTER DATABASE DATAFILE ''' || FILE_NAME || ''' RESIZE ' ||
                CEIL( (NVL(HWM,1)*&&BLKSIZE)/1024/1024 ) || 'M;' CMD
        FROM DBA_DATA_FILES A,
            ( SELECT FILE_ID, MAX(BLOCK_ID+BLOCKS-1) HWM
            FROM DBA_EXTENTS
            GROUP BY FILE_ID ) B
        WHERE A.FILE_ID = B.FILE_ID(+)
        AND CEIL( BLOCKS*&&BLKSIZE/1024/1024) - CEIL( (NVL(HWM,1)*&&BLKSIZE)/1024/1024 ) > 0
        AND TABLESPACE_NAME = '%SYSAUX%' ---------- <----- EN ESTE PUNTO SE AGREGA EL TABLESPACE
        ORDER BY CEIL( (NVL(HWM,1)*&&BLKSIZE)/1024/1024 )
        /

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- 6) SCRIPT CON ALTERS PARA MODIFICAR DEL TAMAÑO DE LOS DATAFILE QUE SON MENORES A 32 GB
------------------------------------------------------------------------------------

        SET PAGESIZE 300
        SET LINESIZE 700
        COL X FORMAT A110
        SELECT 'alter database datafile '||''''||file_name||''' resize '||'32767 ' ||'M;' X
        --,FILE_NAME
        , (bytes)/1024/1024 TAMANO
        FROM  DBA_DATA_FILES
        WHERE TABLESPACE_NAME = 'SYSAUX'
        AND (bytes)/1024/1024 < 32767;

------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------