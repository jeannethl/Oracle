---- activación auditoría para DDL en base de datos de producción

drop trigger audit_ddl_trg_solutor;
drop table ddl_audit_solutor;

CREATE TABLE DDL_AUDIT_SOLUTOR
(
OBJECT_OWNER VARCHAR2 (30),
OSUSER VARCHAR2 (255),
SESSION_USER VARCHAR2 (255),
HOST VARCHAR2 (255),
TERMINAL VARCHAR2 (255),
MODULE VARCHAR2 (255),
TYPE VARCHAR2 (30),
Executed_date DATE,
OBJECT_NAME VARCHAR2 (200),
SQL_STATEMENT VARCHAR2 (2000)
)
TABLESPACE DATA_AUDITORIA;

create or replace trigger audit_ddl_trg_solutor after ddl on database
declare
v_sql_text ora_name_list_t;
v_stmt VARCHAR2(2000) := '';
v_n number;
begin
v_n:=ora_sql_txt(v_sql_text);
for i in 1..v_n
loop
v_stmt:=substr(v_stmt||v_sql_text(i),1,2000);
end loop;

insert into DDL_AUDIT_SOLUTOR(object_owner,osuser,session_user,host,terminal,module,type,executed_date,Object_name,sql_statement)
values(
ora_dict_obj_owner,
sys_context('USERENV','OS_USER') ,
sys_context('USERENV','SESSION_USER') ,
sys_context('USERENV','HOST') ,
sys_context('USERENV','TERMINAL') ,
sys_context('USERENV','MODULE') ,
ora_dict_obj_type,
sysdate,
ora_dict_obj_name,
v_stmt
);
end;
/



-- SE AMPLIA TAMAÑO DEL CAMPO OBJECT_NAME POR ERROR ------

ALTER TRIGGER SYS.audit_ddl_trg_solutor DISABLE;
ALTER TABLE SYS.DDL_AUDIT_SOLUTOR
MODIFY(OBJECT_NAME VARCHAR2(200 BYTE));
ALTER TRIGGER SYS.audit_ddl_trg_solutor ENABLE;