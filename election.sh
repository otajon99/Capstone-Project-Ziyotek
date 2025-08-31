#!/bin/bash



# Author: Otajon
# Created: 08/28/2025
# Content: Project election results



echo -n "Your name: "; read name

echo -n "ID number: "; read ID

echo
echo  " A for Democrats: "
echo  " B for Republicans: "
echo 
echo -n "Choose one: "; read result


if [ "$result" == "A" ]; then

echo "Counting results. Wait for results! "
echo $name >> democrats.sh

elif [ "$result" == "B" ]; then

echo "Counting results. Wait for results! "
echo $name >> republicans.sh

else 
echo "Wrong input! Choose A or B  "

fi


countA=$(wc -w democrats.sh | awk '{print $1}')
countB=$(wc -w republicans.sh | awk '{print $1}')


if [ $countA -gt $countB ]; then
echo "Democrats won!"

elif [ $countA -lt $countB ]; then
echo "Republicans won!"

else
 echo "Equal results"

fi

 
