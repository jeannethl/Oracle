1.- Exportamos el proxy para la salida a internet (en caso de ser nesario)

	export http_proxy=10.132.0.10:8080
	export https_proxy=10.132.0.10:8080

2.- Instalamos los siguientes paquetes

	yum install -y gcc cc make htop gzip gunzip zip unzip compress uncompress
	yum install -y zlib-devel.x86_64 readline-devel.x86_64 libdbi-dbd-pgsql.x86_64
	
3.- Creamos el usuario y grupo postgres

	groupadd postgres
	useradd -g postgres postgres

4.- Validamos los directorios o FS

	mkdir -p /postgres/data
	mkdir -p /postgres/log
	mkdir -p /postgres/binarios
	mkdir -p /postgres/backup

5.- Damos permiso 

	chown -R postgres:postgres /postgres

6.- Ir a la ruta /etc/security y agregar al archivo limits.conf lo siguientes
	
	postgres soft nofile 1024   
	postgres hard nofile 65536  
	postgres soft nproc 4094  
	postgres hard nproc 16384  
	postgres soft stack 10240  
	postgres hard stack 32768  

7.- Descomprimimos el archivo tar.gz

	gzip -d postgresql-9.4.23.tar.gz
	tar -xvf postgresql-9.4.23.tar

8.- Asignar permiso al directorio creado

	chown postgres:postgres /postgres-9.4.23

9.- Entrar al directorio anterior y ejecutar

	./configure -prefix=/postgres/binarios/9.4.1

	NOTA: Este comando debe terminar sin errores, una vez ejecutado sin error se prosigue con la instalacion

10.- Ahora compilamos las funtes e instalamos

	make
	make install

11.- Una vez instlado nos dirigimos a /postgres/binarios/9.4.1/bin y ejecutamos lo siguiente para iniciar la bd

	./initdb -D /postgres/data/zabbix -X /postgres/wall/

	./pg_ctl -D /postgres/data/zabbix -l /postgres/log/postgres.log start

12.- para bajar los servicios de postgres

	./pg_ctl -D /postgres/data/zabbix -l /postgres/log/postgres.log -m fast stop

13.- Para dar status de postgres

	./pg_ctl -D /postgres/data/zabbix status

14.- Para reiniciar postgres

	./pg_ctl -D /postgres/data/zabbix -l /postgres/logs/postgres.log -m fast restart


	