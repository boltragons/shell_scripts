#!/bin/bash

# author: Pedro Botelho
# date: 01/10/2023
# Descrition: Creates some nested directories and files.

# User texts
usage_text="Usage: $0 [topdir subdir num_subdir file num_files]"

# Status codes
success=0
invalid_args=1
num_subdir_not_number=2
num_files_not_number=3

# Variables based in the parameters:
if [ $# -eq 0 ]
then
    topdir="cinco"
    subdir="dir"
    file="arq"
    num_subdir=5
    num_files=4
elif [ $# -eq 5 ]
then
    # Checks whether num_subdir or num_files are numbers or not.
    if [[ ! $3 =~ ^[0-9]+$ ]]
    then
        echo "num_subdir must be a positive number."
        exit ${num_subdir_not_number}
    elif [[ ! $5 =~ ^[0-9]+$ ]]
    then
        echo "num_files must be a positive number."
        exit ${num_files_not_number}
    fi

    topdir=$1
    subdir=$2
    file=$4
    num_subdir=$3
    num_files=$5
else
    echo "Invalid parameters!"
    echo "${usage_text}"
    exit ${invalid_args}
fi

# If the topdir exists, remove it:
if [ -d ${topdir} ]
then
    rm -rf ${topdir}
fi
mkdir ${topdir}

# Creating the subdirectories:
for dir_num in $(seq 1 ${num_subdir})
do
    current_dir="${topdir}/${subdir}${dir_num}"
    mkdir -p ${current_dir}

    # Creating the files:
    for file_num in $(seq 1 ${num_files})
    do
        current_file="${current_dir}/${file}${file_num}.txt"
        touch "${current_file}"

        # Filling the files:
        for iterator in $(seq 1 ${file_num})
        do
            echo "${file_num}" >> ${current_file}
        done
    done
done

exit ${success}
