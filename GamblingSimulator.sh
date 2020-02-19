#!/bin/bash -x

echo "/******************************************* WELCOME TO GAMBLING SIMULATOR *******************************************/"

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1

# VARIABLES
stake=$STAKE_PER_DAY
winLimit=$(($STAKE_PER_DAY+$(($STAKE_PER_DAY*50/100))))
lossLimit=$(($STAKE_PER_DAY-$(($STAKE_PER_DAY*50/100))))

# LOOP TO PLAY GAME TILL REACH RESIGN CONDITION
while [[ $stake -lt $winLimit && $stake -gt $lossLimit ]]
do
	randomCheck=$((RANDOM%2))
	if [ $randomCheck -eq $WIN ]
	then
		stake=$(($stake+$BET_PER_GAME))
	else
		stake=$(($stake-$BET_PER_GAME))
	fi
done

