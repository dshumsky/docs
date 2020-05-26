#!/bin/bash

function sum() {
  sum=0
  for i in "$@";
  do
    sum=$(expr $sum + $i)
  done
  echo "$sum"
}

function echo_odd_numbers() {
  i="$1"
  while [ $i -lt "$2" ]
  do
    echo $i
    i=$(expr $i + 2)
  done
}

sum=$(sum 1 2 3)
echo "sum 1 2 3 = $sum"
echo ""

echo "odd numbbers from 1 to 5:"
echo_odd_numbers 1 6
