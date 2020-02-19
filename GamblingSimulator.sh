#!/bin/bash -x

echo "/******************************************* WELCOME TO GAMBLING SIMULATOR *******************************************/"

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1
TOTAL_DAYS=20

# VARIABLES
stake=$STAKE_PER_DAY
winLimit=$(($STAKE_PER_DAY+$(($STAKE_PER_DAY*50/100))))
lossLimit=$(($STAKE_PER_DAY-$(($STAKE_PER_DAY*50/100))))
totalStake=0
limit=0

# FUNCTION TO PLAY GAMBLE FOR A DAY
function playGamble(){
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
	echo $stake
	stake=$STAKE_PER_DAY
}

# COMPUTING TOTAL AMOUNT OF WON OR LOST
for (( day=1; day<=$TOTAL_DAYS; day++ ))
{
	gambleResult=$(playGamble)
	if [ $gambleResult -gt $STAKE_PER_DAY ]
	then
		gambleResult=$(($gambleResult-$stake))
	else
		gambleResult=$(($gambleResult-$stake))
	fi
	totalStake=$(($totalStake+$gambleResult))
}

# DISPLAYING TOTAL AMOUNT OF WON OR LOST
if [ $totalStake -gt $limit ]
then
	echo "You won $totalStake amount after 20 days"
else
	echo "You lost $totalStake amount after 20 days"
fi
