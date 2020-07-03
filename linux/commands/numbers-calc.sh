#!/bin/bash

# read X
X="5+50*3/20 + (19*2)/7"


R=$(echo "scale=4;${X}" | bc -l)
echo $R
echo "$R" | awk '{printf("%.3f\n",$0+=$0<0?-0.00001:0.00001)}'
