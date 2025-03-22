read -p "Введите размерность поля: " n

for ((i = 0; i < n; i++)); do
	for ((j = 0; j < n; j++)); do
		if [[ $((i % 2)) -eq 0 ]]; then
			if [[ $((j % 2)) -eq 0 ]]; then
				echo -e -n "\\e[47m" " "
			else
				echo -e -n "\\e[40m" " "
			fi
		else
			if [[ $((j % 2)) -eq 0 ]]; then
				echo -e -n "\\e[40m" " "
			else
				echo -e -n "\\e[47m" " "
			fi
		fi
	done
	echo -e -n "\\e[0m" " "
	echo
done

echo
flagi=0
flagj=0

for ((i = 0; i < n; i++)); do
	if [[ flagi -eq 0 ]]; then
		flagj=0
		flagi=$((flagi + 1))
	else
		flagj=1
		flagi=$((flagi - 1))
	fi

	for ((j = 0; j < n; j++)); do
		if [[ flagj -eq 0 ]]; then
			echo -e -n "\\e[47m" " "
			flagj=$((flagj + 1))
		else
			echo -e -n "\\e[40m" " "
			flagj=$((flagj - 1))
		fi
	done
	echo -e -n "\\e[0m" " "
	echo
done
