#!/bin/bash

# author: Pedro Botelho
# description: Return the biggest out of thrree numbers.
# date: 21/09/2023

if [ $# -ne 3 ]
then
	echo "Usage: $0 int1 int2 int3"
	exit 1
fi

if [[ ! $1 =~ ^-?[0-9]+$ ]] || [[ ! $2 =~ ^-?[0-9]+$ ]] || [[ ! $3 =~ ^-?[0-9]+$ ]]
then
	echo "All parameters must be integers."
	exit 1
fi

if [ $1 -ge $2 ] && [ $1 -ge $3 ]
then
	echo $1
elif [ $2 -ge $3 ] && [ $2 -ge $1 ]
then
	echo $2
else
	echo $3
fi

