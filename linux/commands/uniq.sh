#!/bin/bash

uniq -c | sed 's/^ *//' < /dev/stdin
