#!/bin/bash
#######################################################################
# Check if recon-all is done without error                            #
# Author: rens                                                        #
# Date: 30/Sep/2015                                                   #
#######################################################################
# Example:
# sh check_log_file.sh &>checkLogResult.txt
# Redirect the output to a file
root_dir=/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI
cd $root_dir
log_list=$(find -iname 'recon-all.log')
finish_flag='finished without error'
log_file='n'
i=0
total_count=0
error_count=0
until [ ! -n "$log_file" ]
do
	i=$(($i+1))
	log_file=$(echo $log_list | cut -d ' ' -f$i)
	if [ ! -n "$log_file" ]; then
		break
	fi
	log=`cat $log_file`
	if [[ ! $log =~ $finish_flag ]]; then
		echo $log_file
		error_count=$(($error_count+1))
	fi
	total_count=$(($total_count+1))
done
echo 'Total log files scanned: '$total_count
echo 'Errors detected: '$error_count
