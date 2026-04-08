
spool 08_constraints_faltantes_U.lst
set time on set timi on
prompt ALTER TABLE "TX"."STREET" ADD CONSTRAINT "UNQ_STREET_CITYRID" UNIQUE ("CITYID", "RID") RELY                                                                                       
ALTER TABLE "TX"."STREET" ADD CONSTRAINT "UNQ_STREET_CITYRID" UNIQUE ("CITYID", "RID") RELY                                                                                       
  USING INDEX "TX"."IDX_STREET_CITYRID"  ENABLE NOVALIDATE;                                                                                                                         

spool off
