#!/bin/sh

for i in {1..5}
do
   cat output.txt
   jq -c ' .[]' output.json
   sleep 5
done
