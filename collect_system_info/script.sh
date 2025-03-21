#!/bin/bash -e

# Печатает меню выбора действия
printInfo() {
    echo "Информация о системе:"
    echo "1. Текущий рабочий каталог"
    echo "2. Текущий запущенный процесс"
    echo "3. Домашний каталог"
    echo "4. Название и версия операционной системы"
    echo "5. Все возможные оболочки"
    echo "6. Текущие пользователи, вошедшие в систему"
    echo "7. Количество пользователей, вошедших в систему"
    echo "8. Информация о жестких дисках"
    echo "9. Информация о процессоре"
    echo "10. Информация о ОЗУ"
    echo "11. Информация о файловой системе"
    echo "12. Информацию об установленных пакетах ПО"
    echo "13. Выйти из приложения"
}

# Получение текущего рабочего каталога
showСurrentWorkDirectory() {
    echo "Текущий рабочий каталог: $(pwd)" # present working directory
}

# Получение текущего запущенного процесса
showCurrentProcess() {
    echo "Текущий запущенный процесс:"
    # u - получение процесса для пользователя
    # p - получение процесса по PID
    # $$ - PID текущего процесса
    ps -up $$ 
}

# Печатает домашний каталог пользователя
showHomeDirectory() {
    echo "Домашний каталог: $HOME"
}

# Печатает информацию об операционной системе: сама ОС и версия ядра
showOSInfo() {
    # hostnamectl 
    echo "Информация об операционной системе:"
    echo "1) Название операционной системы: $( hostnamectl | grep "Operating System:" | sed 's/Operating System:\s//g' )"
    echo "2) Версия ядра: $( hostnamectl | grep "Kernel:" | sed 's/\s*Kernel:\s//g' )"
}

# Печатает информацию о вошедших пользователях
showCurrentUsers() {
    echo "Текущие пользователи, вошедшие в систему:"
    who
}

# Печатает возможные оболочки терминала
showAvailableShells() {
    echo "Доступные оболочки:"
    cat /etc/shells | grep '/'
}

# Печатает количество вошедших пользователей
countOfCurrentUsers() {
    echo "На данный момент в системе работает $(who | wc -l) пользователей"
}

# Печатает информацию о дисках
showDiskInfo() {
    echo "Информация о диске:"
    df -h
}

# Печатает информацию о процессоре
showCpuInfo() {
    echo "Информация о процессоре:"
    lscpu | sed "s/$( lscpu | grep "Флаги" )//g"
}

showFilesystemInfo() {
    echo "Информация о файловой системе:"
    df -T
}

# Печатает информацию об ОЗУ
showMemoryInfo() {
    echo "Информация о памяти: "
    free -ht
}

# Печатает информацию об установленных пакетах
showInstalledPakages() {
    echo "Установленные пакеты:"
    yum list installed
}

# Печатает разделитель полей
printSeparator() {
    for (( i=0; i < 100; i++ )); do
    echo -n "="
    done
    echo
}

# Печатает все сведения, которые может собрать программа
showAllInfo() {
    showСurrentWorkDirectory
    printSeparator

    showCurrentProcess
    printSeparator

    showHomeDirectory
    printSeparator
    
    showOSInfo
    printSeparator

    showAvailableShells
    printSeparator

    
    showCurrentUsers
    printSeparator

    countOfCurrentUsers
    printSeparator

    showDiskInfo
    printSeparator

    showCpuInfo
    printSeparator

    showMemoryInfo
    printSeparator

    showFilesystemInfo
    printSeparator

    showInstalledPakages
    printSeparator
}


# Переменная для выбора определенной опции
command=0

# Если передан параметр "--tofile"
if [[ -n "$1" && "$1" == --tofile ]]; then
    if [[ -n "$2" ]]; then
        showAllInfo > $2
        exit
    fi
fi 

# До тех пор, пока не будет введена команда выхода
while true; do
    clear
    printInfo
    read -p "Введите команду: " command
    clear
    case $command in
        1) showСurrentWorkDirectory;;
        2) showCurrentProcess;;
        3) showHomeDirectory;;
        4) showOSInfo;;
        5) showAvailableShells;;
        6) showCurrentUsers;;
        7) countOfCurrentUsers;;
        8) showDiskInfo;;
        9) showCpuInfo;;
        10) showMemoryInfo;;
        11) showFilesystemInfo;;
        12) showInstalledPakages;;
        13) exit;;
    esac
    read -p "Нажмите enter"
done
