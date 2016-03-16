echo creating usertable
ip addr
echo 'create database ycsb;' | mysql -h $target_ip 
mysql -h $target_ip ycsb < createtable.sql
psql -h $target_ip -U postgres -c 'create database ycsb;' 

#psql -h $target_ip -d ycsb -U postgres < createtable.sql

echo $phase = phase

echo runing ycsb job
cd /usr/local/bin/ycsb-0.5.0
if [ "$phase" == "load" ]; then

	bin/ycsb load jdbc -threads 50 -P workloads/workloada -P workloads/workloaddwsmysql -P db.properties -cp /usr/share/java/mysql-connector-java.jar -s
fi

if [ "$phase" == "run" ]; then

	bin/ycsb run jdbc -threads 10 -P workloads/workloada -P workloads/workloaddwsmysql -P db.properties -cp /usr/share/java/mysql-connector-java.jar -s
	bin/ycsb run jdbc -threads 20 -P workloads/workloada -P workloads/workloaddwsmysql -P db.properties -cp /usr/share/java/mysql-connector-java.jar -s
	bin/ycsb run jdbc -threads 40 -P workloads/workloada -P workloads/workloaddwsmysql -P db.properties -cp /usr/share/java/mysql-connector-java.jar -s
fi

