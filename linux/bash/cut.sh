#!/bin/bash

# some characters
cut -b 1-4 < /dev/stdin

# some columns (TAB is default delimiter)
cut -d " " -f 1-2 < /dev/stdin
