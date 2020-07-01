#!/bin/bash

# replace
tr '()' '[]' < /dev/stdin

# delete
tr -d 'a-z' < /dev/stdin

# replace sequance
tr -s ' ' ' ' < /dev/stdin
