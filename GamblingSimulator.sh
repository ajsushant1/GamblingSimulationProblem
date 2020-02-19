#!/bin/bash -x

echo "/******************************************* WELCOME TO GAMBLING SIMULATOR *******************************************/"

#CONSTANTS
STAKE_PER_DAY=100
BET_PER_GAME=1
WIN=1

# TO GET RANDOM VALUE
randomCheck=$((RANDOM%2))

# CHECKING CONDITION FOR WON OR LOST THE BET
if [ $randomCheck -eq $WIN ]
then
	echo "You won the bet \$$BET_PER_GAME"
else
	echo "You loose the bet \$$BET_PER_GAME"
fi
