i=$1
	mod=`expr $i % 12`
	l=`cat ./podspecs/mongo0-svc.json`;
	n=${l//mongo0/mongo$i};
	o=${n//rs0/rs$mod};
	echo $o;

