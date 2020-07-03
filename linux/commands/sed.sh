#!/bin/bash

# remove spaces
uniq -c | sed 's/^ *//' | sed -n '/^1 / p' | sed 's/^1 //' < /dev/stdin

# print only '1 ...' (like grep)
uniq -c | sed 's/^ *//' | sed -n '/^1 / p' < /dev/stdin

