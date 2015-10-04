#!/bin/sh
##################################################################
# Get name list of patienrs whose FMRI data is available($1)     #
# For each pateint construct base using filtered crssec data($2) #
# Output as patientid_base                                       #
# Author: rens                                                   #
# Date: 21/Sep/2015                                              #
##################################################################
output_dir="/data/users/rens/storage/ADNI/base"
input_dir="/data/users/nanbos/storage/ADNI/preprocess_data/sMRI"
patient_list=$(cat $1)
crssec_list=$(cat $2)
count=0
i=0
patient_name="n"
until [ ! -n "$patient_name" ]
do
	i=$(($i+1))
	patient_name=$(echo $patient_list | cut -d ' ' -f$i)
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
						recon_para+=' -tp '
						recon_para+=$crssec_folder
						k=$(($k+1))
					fi

                        	fi
                	fi
       		fi					
		fi
	done
	#count=$(($count+1))	
	if [ "$k" -gt "1" ]; then
		count=$(($count+1))
		#echo "recon-all -base ${patient_name}_base $recon_para -all"
		/apps/sysapps/TORQUE/bin/qsub -q circ-spool -v output_dir=${output_dir},input_dir=${input_dir},recon_para=${recon_para},name=${patient_name}_base /data/users/rens/storage/ADNI/base/scripts/submit_job_bash.sh
	fi
done
echo $count
