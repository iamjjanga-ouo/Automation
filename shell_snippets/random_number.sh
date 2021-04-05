#!/bin/bash
# ref : (https://blog.eduonix.com/shell-scripting/generating-random-numbers-in-linux-shell-scripting/)
# Random Number Generation

# 1. Using the Random Variable
RANDOM=$$
for i in `seq 10`
do
    echo $RANDOM
done


# 2. Random Numbers within a Range
if [ $# -ne 2]; then
    echo -e "\nUsage:\t$0 START END\n"
    exit 1
fi

DIFF=$(($2-$1+1))
RANDOM=$$
for i in `seq 5`
do
    R=$(($(($RANDOM%$DIFF)) + $1))
    echo $R
done