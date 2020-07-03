#!/bin/bash

sort < /dev/stdin

# reverse
sort -r < /dev/stdin

# numbers
sort -g < /dev/stdin

# column 2 (numeric), column 1, debug
sort -k2rn,2 -k1r,1 -t $'\t' --debug < /dev/stdin