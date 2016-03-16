echo executing master_next.sh
#cd /usr/local/bin

ls -l / 


echo executing make_db.prop.sh
./make_db.prop.sh > ycsb-0.5.0/db.properties

echo creating ycsb database
mysqladmin -h $target_ip --password=admin create ycsb

echo getting workload file
curl http://$master_ip/workloaddwsmysql -o /usr/local/bin/ycsb-0.5.0/workloads/workloaddwsmysql

echo running ycsb test
./run_ycsb_task.sh

echo end master_next.sh

