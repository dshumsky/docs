#!/bin/bash

# awk '{printf("%s: index(a)=%s\n", $0, index($0, "a"))}' < /dev/stdin

# convert '...' to '-...-'
awk '{printf "%s\n",sprintf("-%s-",$0)}' < /dev/stdin

# convert 'A..' to '_..'
awk '{gsub(/^[A-Z]/,"_",$0),sprintf("%s",$0)}' < /dev/stdin
