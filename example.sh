#!/bin/bash
apt install -y vim
rm -rf test
mkdir test
touch test/test.txt
echo "I am a test!!!!!!!!!!!!" > test/test.txt
echo "---------------------------------"
cat test/test.txt
