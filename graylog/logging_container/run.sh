#!/bin/sh

cat output.txt
jq -c ' .[]' output.json