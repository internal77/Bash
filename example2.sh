#!/bin/bash
users=$(cat users.txt) # считываем файл и все записываем в переменную
for user in $users # цикл для чтения каждой строки в файле
do
    if [[ $user == *"admin" ]] # ищем в строке имя с ролью
    then
      user=$(echo $user | cut -d ':' -f  1) # разделяем строку имя от роли
      useradd $user # добавляем юзера с ролью
      usermod -G sudo # добаляем его же в группу суперпользователя
    else
      useradd $user # иначе просто создаем пользователя без роли админа
    fi
done
cat /etc/passwd
cat /etc/group
