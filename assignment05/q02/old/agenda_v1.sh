#!/bin/bash

# author: Pedro Botelho
# date: 22/09/2023
# Descrition: Manages a database file that has persons names and emails.

# Database File
db=$(echo $0 | sed 's/^.\///g' | sed 's/.sh$/.db/g')

# User texts
usage_text="Usage: $0 <operation> <op_args>"
help_text=$(cat <<EOF
Manages persons in a database file.
${usage_text}
-h			Help.
-a <name> <email>	Add a person with name and email.
-l			List all persons.
-r <email>		Remove the person with the email.
EOF
)

# Error codes
invalid_args_error=1
empty_db_error=2
email_already_exists=3
email_does_not_exist=4

# Main code
if [ $# -lt 1 ]
then
	echo "${usage_text}"
	exit ${invalid_args_error}
fi

case $1 in
-a)
	if [ ! -f ${db} ]
	then
		touch ${db}
		echo "Database file ${db} created."
	elif [ $# -ne 3 ]
	then
		echo "Invalid -a arguments."
		echo "${help_text}"
		exit ${invalid_args_error}
	fi
	cut -f2 -d':' ${db} | grep -q -E "^$3$"

	if [ $? -eq 0 ]
	then
		echo "The given e-mail already exists!"
		exit ${email_already_exists}
	fi
	echo "$2:$3" >> ${db}
	echo "Added user \"$2\"."
	;;
-l)
	if [ ! -f ${db} ] || [ ! -s ${db} ]
	then
		echo "Empty database file."
		exit ${empty_db_error}
	fi
	cat ${db}
	;;
-r)
	if [ ! -f ${db} ] || [ ! -s ${db} ]
	then
		echo "Empty database file."
		exit ${empty_db_error}
	elif [ $# -ne 2 ]
	then
		echo "Invalid -r arguments."
		echo "${help_text}"
		exit ${invalid_args_error}
	fi
	cut -f2 -d':' ${db} | grep -q -E "^$2$"
	if [ $? -ne 0 ]
	then
		echo "The given e-mail does not exist!"
		exit ${email_does_not_exist}
	fi
	removed_user=$(grep -E ":$2$" ${db} | cut -f1 -d':')
	sed -i "/^.*:$2$/d" ${db}
	echo "Removed user \"${removed_user}\"."
	;;
-h)
	echo "${help_text}"
	;;
*)
	echo "Invalid operation!"
	echo "${help_text}"
	exit ${invalid_args_error}
	;;
esac

exit 0
