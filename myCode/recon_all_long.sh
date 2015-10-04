#!/bin/bash
#######################################################################
# Do longitutinal process for each mri                                #
# Take two parameters:                                                #
# 	Base list and cross-sectional list after QC                   #
# Author: rens                                                        #
# Date: 22/Sep/2015                                                   #
#######################################################################
crssec_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/crossSectional/"
base_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/base/"
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
		continue
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
		crssec_folder=''
		if [[ $crssec_id =~ $patient_name ]]; then
		if [[ $crssec_id =~ ([0-9]{3}_S_[0-9]{4}) ]]; then
			crssec_folder+=${BASH_REMATCH[1]}
			crssec_folder+="_"
                	if [[ $crssec_id =~ (S[0-9]{5,6}) ]]; then
				crssec_folder+=${BASH_REMATCH[1]}
                        	crssec_folder+="_"
				if [[ $crssec_id =~ (I[0-9]{5,6}) ]]; then
					crssec_folder+=${BASH_REMATCH[1]}
					crssec_folder+="_"
					if [[ $crssec_id =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
                                        	crssec_folder+=${BASH_REMATCH[1]}
						echo "recon-all -long ${crssec_dir}${crssec_folder} ${base_dir}${patient_name}_base -all"
						count=$((count+1))
						#/apps/sysapps/TORQUE/bin/qsub -q circ-spool -v root_dir=${root_dir},base=${base_dir}${patient_name}_base,crssec=${crssec_dir}${crssec_folder} /data/users/rens/myCode/submit_job_long.sh
					fi

                        	fi
                	fi
       		fi					
		fi
	done
done
echo $count
