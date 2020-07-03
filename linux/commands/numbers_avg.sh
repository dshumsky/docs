#!/bin/bash

read N
I=1
R=0
while [ $I -le $N ];
do
   read X
   let R=$R+$X
   let I=$I+1
done
R=$(echo "scale=4;$R/$N" | bc -l)
echo "$R" | awk '{printf("%.3f\n",$0+=$0<0?-0.00001:0.00001)}'
