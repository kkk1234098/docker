#!/bin/sh
read a < runs;

if [ $a == "1" ]
then
   echo "a is equal to b"
else
   echo "a is not equal to b"
fi

a=$[$a+1];
echo $a;
echo $a > runs;
