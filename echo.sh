#!/bin/bash

echo "Received arguments:"
echo "Number of arguments: $#"
echo "All arguments: $@"

i=1
for arg in "$@"
do
    echo "Argument $i: $arg"
    i=$((i + 1))
done
