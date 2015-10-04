#!/bin/sh
#--------------------------------------------------------------------
#Filename:   submit_job_recon_all_cross.sh
#Date:       9/9/2015
#Author:     nanbos
#Description:This program submit job to HPC for doing recon-all
#Version:    1.0
#--------------------------------------------------------------------

#PBS -l walltime=960:00:0
export SUBJECTS_DIR=//data/users/nanbos/storage/ADNI

while read myline
do
	if [[ $myline =~ ([0-9]{3}_S_[0-9]{4}) ]]; then
		subID=${BASH_REMATCH[1]}
	fi
	if [[ $myline =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
		date=${BASH_REMATCH[1]}
	fi
	if [[ $myline =~ (S[0-9]{5,6}) ]]; then
		serial_num=${BASH_REMATCH[1]}
	fi
	if [[ $myline =~ (I[0-9]{5,6}) ]]; then
		image_num=${BASH_REMATCH[1]}
	fi
	name=$(echo "$subID"_"$serial_num"_"$image_num"_"$date")
	recon-all -s ${name} -sd ${output_dir} -i ${input_dir}${myline} -all
done < $list_dir/cross_job$file_num.txt



