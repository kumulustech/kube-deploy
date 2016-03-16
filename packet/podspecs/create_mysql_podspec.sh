	i=$1
	l=`cat ./podspecs/mysql.json`;
	m=${l//mysql-vol0/mysql-vol$i};
	n=${m//mysql0/mysql$i};
	echo $n;

