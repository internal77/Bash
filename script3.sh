#!/bin/bash
# for cycle
for items in First Second Thid Fourth Fifth
do
echo "$items элемент"
done

echo "------------------------------------------"

for item in "Первая строка" "Вторая строка" "Третья строка" "Четвертая строка"
do
echo "$item"
done

echo "------------------------------------------"

IFS=$'\n'
file="items.txt"
for str in $(cat $file)
do
echo "$str"
done

echo "------------------------------------------"

dir=/home/internal77/*
for file in $dir
do
if [ -d "$file" ]
then
echo "$file ----Дериктория!"
elif [ -f "$file" ]
then
echo "$file -----Файл!"
else
echo "---------Неизвестное Значение"
fi
done
echo "------------------------------------------"

for ((i=1; i<=10; i++))
do
echo "Значение i = $i"
done

echo "------------------------------------------"
