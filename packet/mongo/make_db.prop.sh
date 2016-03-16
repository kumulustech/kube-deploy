
cat db.properties.template | grep -v target_ip > db.prop.tmp
l=`cat db.properties.template | grep target_ip`
m=${l//target_ip/$target_ip};

echo $m >> db.prop.tmp
cat db.prop.tmp
rm -rf db.prop.tmp
