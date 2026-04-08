-----------------------tablespace en ASM------------------------------------------
*se busca el nombre del tablespace el cual se va a expandir.
	IND_SHCLOG_2

*Ver el porcentaje el cual se encuentra el tablespace
set pages 999
		col tablespace_name format a40
		col "size MB" format 999,999,999
		col "free MB" format 99,999,999
		col "% Used" format 999
		select     tsu.tablespace_name, ceil(tsu.used_mb) "size MB"
		,    decode(ceil(tsf.free_mb), NULL,0,ceil(tsf.free_mb)) "free MB"
		,    decode(100 - ceil(tsf.free_mb/tsu.used_mb*100), NULL, 100,
		               100 - ceil(tsf.free_mb/tsu.used_mb*100)) "% used"
		from    (select tablespace_name, sum(bytes)/1024/1024 used_mb
		    from     dba_data_files group by tablespace_name union all
		    select     tablespace_name || '  **TEMP**'
		    ,    sum(bytes)/1024/1024 used_mb
		    from     dba_temp_files group by tablespace_name) tsu
		,    (select tablespace_name, sum(bytes)/1024/1024 free_mb
		    from     dba_free_space group by tablespace_name) tsf
		where    tsu.tablespace_name = tsf.tablespace_name (+)
		--and tsu.tablespace_name ='SYSAUX'
		order    by 4
		/


*Revisar diskgroup y secuencia 
	select file_name , bytes/(1024*1024) from dba_data_files where tablespace_name='SYSAUX' order by file_name;


+DG_CTDATA01/ist1/datafile/ind_shclog_2.291.946738793  1024



*Abrir otra ventana
*Setearse en la instancia de asm por .oraenv para estar seguro
*luego que estes seteado en ASM
	asmcmd

*Listar los diskgroup 
	lsgd

*ver si tiene espacio y anotar el nombre 
+DG_CTDATA01

*Ejecutar el aumento del tablespace (nombre del tablespace   nombre del diskgroup   y tamaño con que se le da espacio.)

	alter tablespace CROSSNETLOB add datafile '+DG_DATA_JURID' size 20G;



	* RESIZE a un datafile

	alter database datafile '+DG_DATA_ADS/ads/datafile/indx01.622.1060759041' resize 10G;