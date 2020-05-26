#!/bin/bash

TEXT="Name1 Name2
Name3
Name4
"

echo "$TEXT" | xargs -n 1 sh -c 'echo \"Hello $0!\"'
