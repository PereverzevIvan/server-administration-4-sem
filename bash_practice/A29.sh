#!/bin/bash -e

function findFS {
    needFS=$1
    IFS=$'\n'
    count=$(df -h | tail -n +2 | grep "$needFS" | wc -l)
    if [[ "$count" == "0" ]]; then
        echo "Файловая система $needFS не смонтирована"
        exit
    fi
    allFS=$(df -h | tail -n +2 | grep "$needFS")
    for row in $allFS; do
        echo "======================================="
        IFS=' '
        curFS=$(echo $row | awk '{print $1}')
        memoryLeft=$(echo $row | awk '{print $4}')
        mountPoint=$(echo $row | awk '{print $6}')

        echo "Файловая система: $curFS"
        echo "Точка монтирования: $mountPoint"
        echo "На разделе осталось: $memoryLeft"

        IFS=$'\n'
        i+=1
    done
    echo "======================================="
}

if [[ -n "$1" ]]; then
    needFS=$1
    findFS $needFS
else
    echo "Вы не указали аргумент"
fi
