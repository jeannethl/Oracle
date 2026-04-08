Consultas Usuarios de ORACLE DATA_BASE

-- Consulta todos los usuario de BD
select USERNAME, ACCOUNT_STATUS from dba_users; 


-- Consulta un usuario expecifico de BD
select USERNAME, ACCOUNT_STATUS from dba_users where USERNAME like 'SYS%';



