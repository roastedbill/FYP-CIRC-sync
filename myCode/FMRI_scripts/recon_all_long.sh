#!/bin/bash
#######################################################################
# Do longitutinal process for each mri                                #
# Take two parameters:                                                #
# 	Base list and cross-sectional list after QC                   #
# Author: rens                                                        #
# Date: 22/Sep/2015                                                   #
#######################################################################
# Example:
# recon_all_long.sh /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/baseList1.txt
# /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/QClist_all.txt
#

function parseLongName2Job {
	crssec_folder=''
	if [[ $1 =~ $patient_name ]]; then
		if [[ $1 =~ ([0-9]{3}_S_[0-9]{4}) ]]; then
			crssec_folder+=${BASH_REMATCH[1]}
			crssec_folder+="_"
                	if [[ $1 =~ (S[0-9]{5,6}) ]]; then
				crssec_folder+=${BASH_REMATCH[1]}
                        	crssec_folder+="_"
				if [[ $1 =~ (I[0-9]{5,6}) ]]; then
					crssec_folder+=${BASH_REMATCH[1]}
					crssec_folder+="_"
					if [[ $1 =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
                                        	crssec_folder+=${BASH_REMATCH[1]}
						#echo "recon-all -long ${crssec_dir}${crssec_folder} ${base_dir}${patient_name}_base -all"
						count=$((count+1))
						/apps/sysapps/TORQUE/bin/qsub -q circ-spool -v base=${base_dir}${patient_name}_base,crssec=${crssec_dir}${crssec_folder} /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/submit_job_long.sh
					fi

                        	fi
                	fi
       		fi					
	fi

}

if [ $# != 2 ]; then 
	echo "Usage: sh recon_all_long.sh <BaseListAfterQC> <CrossSectionalListAfterQC>"
	exit 1
fi
crssec_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/"
base_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/"
base_list=$(cat $1)
crssec_list=$(cat $2)
count=0
i=0
patient_name="n"
until [ ! -n "$patient_name" ]
do
	i=$(($i+1))
	patient_name=$(echo $base_list | cut -d ' ' -f$i)
	if [ ! -n "$patient_name" ]; then
		break
	fi
	recon_para=''
	echo $patient_name
	j=0
	k=0
	crssec_id="n"
	until [ ! -n "$crssec_id" ]
	do
		j=$(($j+1))
		crssec_id=$(echo $crssec_list | cut -d ' ' -f$j)
		parseLongName2Job $crssec_id
	done
done
echo $count
