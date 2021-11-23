#/bin/bash

# Возвращение вывода к стандартному форматированию
NORMAL='\033[0m'      # ${NORMAL}

# Цветом текста (жирным) (bold) :
WHITE='\033[1;37m'    # ${WHITE}

# Цвет фона
BGRED='\033[41m'      # ${BGRED}
BGGREEN='\033[42m'    # ${BGGREEN}
BGBLUE='\033[44m'     # ${BGBLUE}

#ПОЛУЧАЯ СТАТУС ОТ СЕРВЕРА nginx ЗАПИСЫВАЕМ ЕГО В ПЕРЕМЕННУЮ
nginxstatus=$(systemctl status nginx | grep -Eo "running|dead|failed")

if [[ $nginxstatus = 'running' ]]
        then
                echo -en  "${WHITE} ${BGGREEN} Веб сервер NGINX работает ${NORMAL}\n"
        else
                echo -en "${WHITE} ${BGRED} NGINX не работает ${NORMAL}\n"
                systemctl restart nginx #перезапуск nginx
                sleep 1 #ожидаем 1 секунду, что бы сервер точно загрузился
                echo -en  "${WHITE} ${BGGREEN} Статус сервера NGINX после перезапуска $(systemctl status nginx | grep -Eo "running|dead|failed") ${NORMAL}\n"
                echo  "curl -I 192.168.0.170 | grep OK" #проверяем вебсервер http код 80

fi

#ПОЛУЧАЯ СТАТУС ОТ СЕРВЕРА php ЗАПИСЫВАЕМ ЕГО В ПЕРЕМЕННУЮ
phpstatus=$(systemctl status php7.2-fpm | grep -Eo "running|dead|failed")

if [[ $phpstatus = 'running' ]]
        then
                echo -en  "${WHITE} ${BGGREEN} Веб сервер PHP работает ${NORMAL}\n"
                systemctl restart php7.2-fpm #перезапуск php
                sleep 1 #ожидаем 1 секунду, что бы сервер точно загрузился
                echo -en  "${WHITE} ${BGGREEN} Статус сервера PHP после перезапуска $(systemctl status php7.2-fpm | grep -Eo "running|dead|failed") ${NORMAL}\n"
                echo  "curl -I 192.168.0.170 | grep OK" #проверяем вебсервер http код 80

fi
