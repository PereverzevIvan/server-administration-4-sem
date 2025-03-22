# Знакомство с Systemd

1. Посмотреть все имеющиеся таймеры можно командой:
   ```
   systemctl list-timers
   ```
2. Чтобы посмотреть логи загрузки системы можно использовать команду:
   ```
   journalctl
   ```
3. Переходим в папку:
   ```
   cd /etc/systemd/system
   ```
4. Создаем файл с названием `myMonitor.service` и вставляем в него следующее:

   ```sh
   [Unit]
   Description=Logs system statistics to the systemd journal
   # Таймер, по истечении которого выполнится сервис
   Wants=myMonitor.timer

   [Service]
   # Сервис просто выполняет работу и не заставляет за собой следить
   Type=oneshot
   # Команды, которую нужно запустить
   ExecStart=echo "Проверка собственного сервиса"
   ExecStart=/usr/bin/free
   ExecStart=/usr/bin/lsblk

   [Install]
   # прописываем цели данного юнита
   WantedBy=multi-user.target
   ```

5. Проверяем сервис:
   ```
   systemctl status myMonitor.service
   ```
6. Запускаем сервис:
   ```
   systemctl start myMonitor.service
   ```
7. Проверяем логи:
   ```
   journalctl -u myMonitor.service
   ```
8. В логах должно быть примерно следующее:
   ```
   мар 22 14:02:20 ivan-comp systemd[1]: Starting Logs system statistics to the systemd journal...
   мар 22 14:02:20 ivan-comp echo[13524]: Проверка собственного сервиса
   мар 22 14:02:20 ivan-comp free[13529]:                total        used        free      shared  buff/cache   available
   мар 22 14:02:20 ivan-comp free[13529]: Mem:        14246868     7344012      321140      153396     7065492     6902856
   мар 22 14:02:20 ivan-comp free[13529]: Swap:              0           0           0
   мар 22 14:02:20 ivan-comp lsblk[13534]: NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
   мар 22 14:02:20 ivan-comp lsblk[13534]: sda           8:0    0 465,8G  0 disk
   мар 22 14:02:20 ivan-comp lsblk[13534]: ├─sda1        8:1    0   600M  0 part /efi
   мар 22 14:02:20 ivan-comp lsblk[13534]: ├─sda2        8:2    0     1G  0 part
   мар 22 14:02:20 ivan-comp lsblk[13534]: └─sda3        8:3    0 464,2G  0 part /home/ivan/Games
   мар 22 14:02:20 ivan-comp lsblk[13534]:                                       /mnt/fedora
   мар 22 14:02:20 ivan-comp lsblk[13534]: nvme0n1     259:0    0 238,5G  0 disk
   мар 22 14:02:20 ivan-comp lsblk[13534]: ├─nvme0n1p1 259:1    0    16M  0 part
   мар 22 14:02:20 ivan-comp lsblk[13534]: ├─nvme0n1p2 259:2    0 117,2G  0 part
   мар 22 14:02:20 ivan-comp lsblk[13534]: └─nvme0n1p3 259:3    0 121,3G  0 part /var/log
   мар 22 14:02:20 ivan-comp lsblk[13534]:                                       /var/cache
   мар 22 14:02:20 ivan-comp lsblk[13534]:                                       /home
   мар 22 14:02:20 ivan-comp lsblk[13534]:                                       /
   мар 22 14:02:20 ivan-comp systemd[1]: myMonitor.service: Deactivated successfully.
   мар 22 14:02:20 ivan-comp systemd[1]: Finished Logs system statistics to the systemd journal.
   ```
9. Создаем файл для таймера `myMonitor.timer`:

   ```sh
   [Unit]
   Description=Logs some system statistics to the systemd journal
   Requires=myMonitor.service

   [Timer]
   Unit=myMonitor.service
   OnCalendar=*-*-* *:*:00  # Таймер будет срабатывать каждую минуту

   [Install]
   WantedBy=timers.target
   ```

10. Снова запускаем наш сервис.
11. Проверяем, запустился ли таймер:
    ```
    sudo systemctl status myMonitor.timer
    ```
12. Включить автозапуск для созданного таймера:

    ```
    systemctl enable myMonitor.timer
    ```

    > Важно
    > При включении автозапуска создается новая ссылка. В папке `/etc/systemd/system/timers.target.wants` создается соответствующий файл-ссылка,
    > который запускает наш изначальный таймер.

13. В итоге наш сервис начинает запускаться по таймеру каждую минуту.

> Куда писать логи:
> Логи всегда лучше писать простой текстовый файл.
