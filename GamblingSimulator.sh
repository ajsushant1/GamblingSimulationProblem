#!/bin/bash -x

echo "/******************************************* WELCOME TO GAMBLING SIMULATOR *******************************************/"

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1
TOTAL_DAYS=30

# VARIABLES
stake=$STAKE_PER_DAY
winLimit=$(($STAKE_PER_DAY+$(($STAKE_PER_DAY*50/100))))
lossLimit=$(($STAKE_PER_DAY-$(($STAKE_PER_DAY*50/100))))
totalStake=0
limit=0
wonDays=0
lostDays=0
totalWinInMonth=0
totalLostInMonth=0

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
		((wonDays++))
		gambleResult=$(($gambleResult-$stake))
		totalWinInMonth=$(($totalWinInMonth+$gambleResult))
	else
		((lostDays++))
		gambleResult=$(($gambleResult-$stake))
		totalLostInMonth=$(($totalLostInMonth+$gambleResult))
	fi
	totalStake=$(($totalStake+$gambleResult))
}

# DISPLAYING TOTAL AMOUNT OF WON OR LOST AFTER PLAYED FOR MONTH
if [ $totalStake -gt $limit ]
then
	echo "You won $totalStake amount after 30 days"
else
	echo "You lost $totalStake amount after 30 days"
fi
echo "In month you won $totalWinInMonth in $wonDays days"
echo "In month you lost $totalLostInMonth in $lostDays days"
