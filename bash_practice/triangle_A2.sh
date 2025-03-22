read n

for ((i = 1; i <= n; i++)); do
	s=""
	for ((j = 1; j <= i; j++)); do
		s+="${j} "
	done
	echo ${s}
done
