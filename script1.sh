#!/bin/bash
# это комментарий
# начальные представления
neofetch
ls
pwd
whoami
echo "------------------------------------------"

echo "Имя пользователя $USER"
name="internal77"
str="Имя пользователя"
echo "$str $name"
echo "------------------------------------------"

# pwd
mydir=`pwd`
echo "My place $mydir"
mydir2=$(pwd)
echo "My place 2 $mydir2"
number1=10
number2=15
number3=$(($number1 + $number2))
echo "Сумма равна = $number3"
echo "------------------------------------------"
