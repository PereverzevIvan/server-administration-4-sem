k=$1  
for ((i = 1; i <= k; i++)); do
  for ((j = 1; j <= i; j++)); do
    echo -n "$j "
  done
  echo  
done 
