#!/bin/bash

# author: Pedro Botelho
# date: 01/10/2023
# Descrition: Sends ICMP packets to the provided IP addresses
#             and returns a list of the IPs in order of average 
#             response time.

# User texts
usage_text="Usage: $0 <ip_files> [replies]"

# Status codes
success=0
invalid_args=1
empty_ip_file=2
inaccessible_ip=3

# Parameters listing
temp_file="$(basename $0 | sed 's/.sh$/.tmp/g')"
ip_addresses=$(cat $1)

if [ ! -s $1 ] || [ ! -f $1 ]
then
	echo "Empty input file."
	exit ${empty_ip_file}
fi

if [ $# -eq 2 ]
then
	num_replies=$2
elif [ $# -eq 1 ]
then
	num_replies=10
else
	echo "${usage_text}"
	exit ${invalid_args}
fi


if [ -s ${temp_file} ] || [ -f ${temp_file} ]
then
	rm -rf ${temp_file}
fi
touch ${temp_file}

for ip_add in ${ip_addresses}
do
	ping_string=$(ping -i 0,2 -c ${num_replies} ${ip_add})
	
	# Verifies whether the ping was successful. 
	if [ $? -ne 0 ]
	then
		echo "Error connecting to IP ${ip_add}."
		rm -rf ${temp_file}
		exit ${inaccessible_ip}
	fi

	# Obtains the ping average time.
	ping_time=$(echo "${ping_string}" | 
		grep ttl | 
		sed "s/^.*tempo=\(.*\) ms.*$/\1/" | 
		paste -s -d '+' | 
		sed "s/^\(.*\)$/scale=1; (\1)\/${num_replies}/" | 
		bc) 

	echo "${ip_add} ${ping_time}ms" >> ${temp_file}
done

sort -k2,2 ${temp_file}

rm -rf ${temp_file}

exit ${success}
