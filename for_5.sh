#!/bin/bash



# Author: Otajon
# Created: 08/19/2025
# Content: Conting 1 to 5 and opposide




let i=0;

for i in 1 2 3 4 5; do
echo "counting 1 to 5: $i"
sleep 1
done


let a=5;
while [ $a -ge 1 ]; do

echo "Counting backwards: $a"
let a--;
sleep 1

done


