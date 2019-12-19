#!/usr/bin/env bash

for i in 1 2 3
do
   cat output.txt
   jq -c ' .[]' output.json
   sleep 5
done
