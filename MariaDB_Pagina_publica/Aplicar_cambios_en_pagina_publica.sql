--Entrar en el ambiente de calidad
--Consultar el filesystem mariadb/backup
df -h

Filesystem                                     Size  Used Avail Use% Mounted on
devtmpfs                                       3.9G     0  3.9G   0% /dev
tmpfs                                          3.9G     0  3.9G   0% /dev/shm
tmpfs                                          3.9G  251M  3.7G   7% /run
tmpfs                                          3.9G     0  3.9G   0% /sys/fs/cgroup
/dev/mapper/mdbppc-root                         20G  6.5G   14G  33% /
/dev/sda2                                     1014M  240M  775M  24% /boot
/dev/sda1                                       50M  5.8M   45M  12% /boot/efi
/dev/mapper/mdbppc-home                         10G  643M  9.4G   7% /home
/dev/mapper/mdbppc-mariadb_logs_metricasbdv     20G  176M   20G   1% /mariadb/logs/metricasbdv
/dev/mapper/mdbppc-mariadb_backup              100G  4.4G   96G   5% /mariadb/backup
/dev/mapper/mdbppc-mariadb_binario              10G  2.3G  7.8G  23% /mariadb/binario
/dev/mapper/mdbppc-mariadb_logs_paginapublica   20G  195M   20G   1% /mariadb/logs/paginapublica
/dev/mapper/mdbppc-var                         5.0G  630M  4.4G  13% /var
/dev/mapper/mdbppc-mariadb_data_paginapublica  100G  2.5G   98G   3% /mariadb/data/paginapublica
/dev/mapper/mdbppc-mariadb_data_metricasbdv    100G  901M  100G   1% /mariadb/data/metricasbdv
/dev/mapper/mdbppc-tmp                          15G  140M   15G   1% /tmp
/dev/mapper/mdbppc-var_log                      15G  169M   15G   2% /var/log
/dev/mapper/mdbppc-var_log_audit               2.0G  189M  1.9G  10% /var/log/audit
tmpfs                                          794M     0  794M   0% /run/user/1000
tmpfs                                          794M     0  794M   0% /run/user/1001

cd /mariadb/backup
ls -ltr


---listamos el crontab -l y consultamos el ultimo script
crontab -l
############################################
## SCRIPTS DE RESPALDO
## Khelvyn Carrasquel - ADSI - 2024/10/24
############################################
#0 22 * * * sh /home/mariadb/utils/scripts/full_backup_mariadb.sh >> /mariadb/backup/full/full_backup.log 2>&1
#0 */2 * * * sh /home/mariadb/utils/scripts/dump_database.sh paginapublica wordpress_qa
----------------------------------------------------------------------------------------------------------------
sh /home/mariadb/utils/scripts/dump_database.sh paginapublica wordpress_qa
cd dump
ls -ltr
--Listamos y tomamos el ultimo descargandolo en nuestra equipo
total 2141192
-rw-r--r--. 1 mariadb mariadb 180391936 Dec 19 22:00 dump_paginapublica_20241219-2200.sql
-rw-r-----. 1 mariadb mariadb 143511755 Feb  6 16:59 dump_paginapublica_20250206-1657.sql.gz
-rw-r-----. 1 mariadb mariadb       355 Feb  6 17:00 dump_paginapublica_20250206-1657.log
-rw-r--r--. 1 mariadb mariadb 143511755 Feb  6 18:02 dump_paginapublica_20250206-1800.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  6 18:03 dump_paginapublica_20250206-1800.log
-rw-r--r--. 1 mariadb mariadb 143511755 Feb  6 20:02 dump_paginapublica_20250206-2000.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  6 20:02 dump_paginapublica_20250206-2000.log
-rw-r--r--. 1 mariadb mariadb 143511756 Feb  6 22:05 dump_paginapublica_20250206-2200.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  6 22:06 dump_paginapublica_20250206-2200.log
-rw-r--r--. 1 mariadb mariadb 143511756 Feb  7 00:03 dump_paginapublica_20250207-0000.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 00:03 dump_paginapublica_20250207-0000.log
-rw-r--r--. 1 mariadb mariadb 143511756 Feb  7 02:01 dump_paginapublica_20250207-0200.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 02:02 dump_paginapublica_20250207-0200.log
-rw-r--r--. 1 mariadb mariadb 143511756 Feb  7 04:04 dump_paginapublica_20250207-0400.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 04:04 dump_paginapublica_20250207-0400.log
-rw-r--r--. 1 mariadb mariadb 143511756 Feb  7 06:02 dump_paginapublica_20250207-0600.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 06:03 dump_paginapublica_20250207-0600.log
-rw-r--r--. 1 mariadb mariadb 143511756 Feb  7 08:03 dump_paginapublica_20250207-0800.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 08:03 dump_paginapublica_20250207-0800.log
-rw-r--r--. 1 mariadb mariadb 143512503 Feb  7 10:04 dump_paginapublica_20250207-1000.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 10:04 dump_paginapublica_20250207-1000.log
-rw-r--r--. 1 mariadb mariadb 143514657 Feb  7 12:03 dump_paginapublica_20250207-1200.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 12:03 dump_paginapublica_20250207-1200.log
-rw-r--r--. 1 mariadb mariadb 143511827 Feb  7 14:04 dump_paginapublica_20250207-1400.sql.gz
-rw-r--r--. 1 mariadb mariadb       355 Feb  7 14:04 dump_paginapublica_20250207-1400.log
-rw-r-----. 1 mariadb mariadb 143807549 Feb 10 08:57 dump_paginapublica_20250210-0855.sql.gz
-rw-r-----. 1 mariadb mariadb       355 Feb 10 08:57 dump_paginapublica_20250210-0855.log
-rw-r-----. 1 mariadb mariadb 146129646 Feb 13 22:36 dump_paginapublica_20250213-2234.sql.gz
-rw-r-----. 1 mariadb mariadb       355 Feb 13 22:36 dump_paginapublica_20250213-2234.log
------------------------------------------------------------------------------------------------------------------------

--Entramos ahora al ambiente de producción ahora y aplicamos los siguiente comando:
/*
Seleccionamos la instancia 2 y el comando paginapublica_connect para conectar con la BD
*/
[mariadb@plbdmdbpp01 restore]$ menubd
---------------------
    MENU DE ACCESO
---------------------
1  =  metricasbdv
2  =  paginapublica
3  =  SALIR
---------------------
SELECT INSTANCE: 2

### COMANDOS PARA INICIAR BD: paginapublica ###

* paginapublica_start
* paginapublica_stop
* paginapublica_status
* paginapublica_connect

+ PUERTO: 3308
+ DATA: /mariadb/data/paginapublica
+ VERSION MARIADB: 11.4.3

[mariadb@plbdmdbpp01 restore]$ paginapublica_connect
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 20338680
Server version: 11.4.3-MariaDB-log MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
-----------------------------------------------------------------------------------------------------------------------------

--Ya dentro de la base de datos aplicamos los siguientes comandos:
--Muestra las bases de datos en el servidor.
22:46:22 mariadb@(none)>show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
5 rows in set (0.001 sec)

--Eliminamos la base de datos de wordpress ya que mas adelante lo vamos a restaurar con el backup de calidad
22:46:33 mariadb@(none)>drop database wordpress;
Query OK, 55 rows affected (0.224 sec)

--Ahora la creamos nuevamente y salimos  
create database wordpress;
show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
exit


--El archivo que trajimos de calidad a producción lo descomprimimos y luego se utiliza para importar datos desde el archivo SQL a la base de datos de Wordpress 
gzip -d dump_paginapublica_20250213-2000.sql.gz
paginapublica_connect wordpress < dump_paginapublica_20250213-2234.sql

--Luego nos conectamos de nuevo a la base de datos y chequeamos que haya data:

[mariadb@plbdmdbpp01 restore]$ paginapublica_connect
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 20340909
Server version: 11.4.3-MariaDB-log MariaDB Server

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

22:50:59 mariadb@(none)>show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
5 rows in set (0.000 sec)

22:51:16 mariadb@(none)>use wordpress;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
22:51:36 mariadb@wordpress>show tables;
+---------------------------------------------+
| Tables_in_wordpress                         |
+---------------------------------------------+
| tasa                                        |
| version                                     |
| wp_actionscheduler_actions                  |
| wp_actionscheduler_claims                   |
| wp_actionscheduler_groups                   |
| wp_actionscheduler_logs                     |
| wp_asl_brands                               |
| wp_asl_categories                           |
| wp_asl_configs                              |
| wp_asl_countries                            |
| wp_asl_markers                              |
| wp_asl_settings                             |
| wp_asl_specials                             |
| wp_asl_storelogos                           |
| wp_asl_stores                               |
| wp_asl_stores_categories                    |
| wp_asl_stores_meta                          |
| wp_asl_stores_view                          |
| wp_commentmeta                              |
| wp_comments                                 |
| wp_cp_calculated_fields_form_discount_codes |
| wp_cp_calculated_fields_form_posts          |
| wp_cp_calculated_fields_form_revision       |
| wp_cp_calculated_fields_form_settings       |
| wp_ditty_itemmeta                           |
| wp_ditty_items                              |
| wp_e_events                                 |
| wp_e_notes                                  |
| wp_e_notes_users_relations                  |
| wp_e_submissions                            |
| wp_e_submissions_actions_log                |
| wp_e_submissions_values                     |
| wp_export_page_to_html_logs                 |
| wp_export_urls_logs                         |
| wp_hfcm_scripts                             |
| wp_links                                    |
| wp_nextend2_image_storage                   |
| wp_nextend2_section_storage                 |
| wp_nextend2_smartslider3_generators         |
| wp_nextend2_smartslider3_sliders            |
| wp_nextend2_smartslider3_sliders_xref       |
| wp_nextend2_smartslider3_slides             |
| wp_options                                  |
| wp_postmeta                                 |
| wp_posts                                    |
| wp_simply_static_pages                      |
| wp_tec_events                               |
| wp_tec_occurrences                          |
| wp_term_relationships                       |
| wp_term_taxonomy                            |
| wp_termmeta                                 |
| wp_terms                                    |
| wp_usermeta                                 |
| wp_users                                    |
| wp_wow_coder                                |
| wp_wpfm_backup                              |
+---------------------------------------------+
56 rows in set (0.000 sec)








