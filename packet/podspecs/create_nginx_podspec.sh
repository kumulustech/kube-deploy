for i in `seq $1 $2`; do
	l=`cat ./podspecs/nginx.json`;
	n=${l//nginx0/nginx$i};
	echo $n;
done

