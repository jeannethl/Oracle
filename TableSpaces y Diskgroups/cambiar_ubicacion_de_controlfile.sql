SHUTDOWN IMMEDIATE
startup mount
---especificar el viejo y nuevo destino
alter system set control_files='+DATA/INTRNETD/CONTROLFILE/current.314.1200413265','+REDO01'scope=spfile sid='*';

--colocar la BD en nomount y restaurar el controlfile del apartir del viejo
SHUTDOWN IMMEDIATE
startup nomount

rman target /
restore controlfile from '+DATA/INTRNETD/CONTROLFILE/current.314.1200413265';