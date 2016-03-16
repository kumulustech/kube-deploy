	i=$1
	l=`cat ./podspecs/mongo0.orig`;
	m=${l//vol0/vol$i};
	n=${m//mongo0/mongo$i};
	echo $n;


