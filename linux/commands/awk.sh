#!/bin/bash

# convert file to
#   line1 line2 line3
#   line4 line5 line6

awk '
BEGIN {
  i=1
  s1=""
  s2=""
}
{
  if (i%3==1) {
    s1=$0
  } else if (i%3==2){
    s2=$0
  } else {
    printf "%s\t%s\t%s\n",s1,s2,$0;
  }
  i=i+1;
}' < /dev/stdin

# convert file to 'line1;line2;...;lineN'
awk '
BEGIN {
first=0
}
{
  if (first==0) {
    printf "%s",$0;
    first=1
  } else {
    printf ";%s",$0;
  }
}
' < /dev/stdin
