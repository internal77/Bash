#!/bin/bash
# управляющие конструкции  if [[ condition ]]; then
  #statements
#fi
# -z – строка пуста
#-n – строка не пуста
#=, ( == ) – строки равны
#!= – строки неравны
#-eq – равно
#-ne – неравно
#-lt,(< ) – меньше
#-le,(<=) – меньше или равно
#-gt,(>) – больше
#-ge,(>=) - больше или равно
#! - отрицание логического выражения
#-a,(&&) – логическое «И»
#-o,(||) -логическое «ИЛИ»

neofetch
user_name=internal77
if grep $user_name /etc/passwd
  then
  echo "Пользователь найден в системе"
  cd ~
  ls
  else
  echo "Такого товарища нет"
fi
echo "------------------------------------------"

# Математические вычисления

number1=5
number2=10

if [ $number1 -eq $number2 ]
then
  echo "Значения равны"
elif [ $number1 -gt $number2 ];
then
  echo "Значение 1 больше значения 2"
elif [ $number1 -lt $number2 ];
then
  echo "Значение 1 меньше значения 2"
else
  echo "Непонятное Значение"
fi
echo "------------------------------------------"

# Сравнение строк

str1="Программирование на С"
srt2="Скрипты на Bash"

if [ srt1 > str2 ]
then
  echo "Первая строка больше второй"
elif [ str1 < str2 ];
then
  echo "Первая строка меньше второй"
elif [ str1 = str2 ];
then
  echo "Строки равны"
else
  echo "Непонятные Строки"
fi
echo "------------------------------------------"
