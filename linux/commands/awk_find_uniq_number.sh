#!/bin/bash

echo '1 1 2 3 3 2 4 5 4' | \
awk '
{
 split($0,aa," ")
 for (a in aa) {
   # printf "a[%s]=%s\n", a, aa[a]
   bb[aa[a]]=bb[aa[a]]+1
 }
 for (b in bb) {
   # printf "b[%s]=%s\n", b, bb[b]
   if (bb[b]==1) {
     printf "%s\n", b
   }
 }
}
'
