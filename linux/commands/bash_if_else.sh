#!/bin/bash

read X
read Y

if [ $X -gt $Y ]
then
  echo "$X is greater than $Y"
elif [ $X -lt $Y ]
then
  echo "$X is less than $Y"
else
  echo "$X is equal to $Y"
fi

read X
read Y
read Z

if [ $X -eq $Y ] && [ $Y -eq $Z ]
then
  echo "EQUILATERAL"
elif [ $X -eq $Y ] || [ $X -eq $Z ] || [ $Y -eq $Z ]
then
  echo "ISOSCELES"
else
  echo "SCALENE"
fi
