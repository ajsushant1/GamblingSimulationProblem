#!/bin/bash -x

echo "/******************************************* WELCOME TO GAMBLING SIMULATOR *******************************************/"

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1
TOTAL_DAYS=30
LIMIT=0

# VARIABLES
stake=$STAKE_PER_DAY
winLimit=$(($STAKE_PER_DAY+$(($STAKE_PER_DAY*50/100))))
lossLimit=$(($STAKE_PER_DAY-$(($STAKE_PER_DAY*50/100))))
totalStake=0
wonDays=0
lostDays=0
totalWinInMonth=0
totalLostInMonth=0
luckyDayAmount=0
unLuckyDayAmount=0
luckyDay=0
unLuckyDay=0

# DECLARING DICTIONARY
declare -A resultOfMonth

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

# FUNCTION TO GET LUCKY DAY AND UNLUCKY DAY AND AMOUNT
function getLuckyUnluckyDay(){
	amount=$1
	if [ $amount -gt $luckyDayAmount ]
	then
		luckyDay=$2
		luckyDayAmount=$amount
	fi
	if [ $amount -lt $unLuckyDayAmount ]
	then
		unLuckyDay=$2
		unLuckyDayAmount=$amount
	fi
}

# COMPUTING AND STORING TOTAL AMOUNT OF WON OR LOST FOR MONTH
while [[ $stake -ge $LIMIT && $totalStake -ge $LIMIT ]]
do
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
		resultOfMonth[Day$day]=$totalStake
		if [ $day -eq 1 ]
		then
			luckyDayAmount=$totalStake
			unLuckyDayAmount=$totalStake
			luckyDay=$day
			unLuckyDay=$day
		fi
		getLuckyUnluckyDay $totalStake $day
	echo "Day$day : $totalStake"
	}

# DISPLAYING TOTAL AMOUNT OF WON OR LOST AFTER PLAYED FOR MONTH
	if [ $totalStake -gt $LIMIT ]
	then
		echo "You won $totalStake amount after 30 days"
	else
		echo "You lost $totalStake amount after 30 days"
	fi
	echo "In month you won $totalWinInMonth in $wonDays days"
	echo "In month you lost $totalLostInMonth in $lostDays days"

# DISPLAYING LUCKIEST DAY AND UNLUCKIEST DAY IN MONTH 
	if [ $luckyDayAmount -le $LIMIT ]
	then
		echo "Your Luckiest Day is day $luckyDay where you lost minimum $luckyDayAmount amount"
	else
		echo "Your Luckiest Day is day $luckyDay where you won maximum $luckyDayAmount"
	fi
	echo "Your UnLuckiest Day is day $unLuckyDay where you lost maximum $unLuckyDayAmount"
	echo "********************* End Of Month *********************"

# REINITIALIZING VARIABLE FOR NEXT MONTH
	wonDays=0
	lostDays=0
	totalWinInMonth=0
	totalLostInMonth=0
	luckyDay=0
	unLuckyDay=0
done
