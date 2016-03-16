i=$1	
v=`expr $i + 0`
v=`./pad.sh $v`
	mod=`expr $i % 12`
	l=`cat ./podspecs/mongo0_repl.json`;
	m=${l//vol0/vol$v};
	n=${m//mongo0/mongo$i};
#	o=${n//rs0/rs$mod};
	p=${n//138.0/138.2$i};
	echo $p;

