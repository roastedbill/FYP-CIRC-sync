#!/bin/sh
##################################################################
# Get name list of patients whose FMRI data is available($1)     #
# For each pateint construct base using filtered crssec data($2) #
# Output as patientid_base                                       #
# Author: rens                                                   #
# Date: 21/Sep/2015                                              #
##################################################################
# Example: recon_all_base 
# /share/users/imganalysis/yeolab/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/fMRI_ID_list.txt 
# /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/QClist_all.tx
#
function findTpPara {
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
}

if [ $# != 2 ]; then 
	echo "Usage: sh recon_all_base.sh <PatientWithFMRI> <CrossSectionalDataAfterQC>"
	exit 1
fi

output_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI"
input_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/"
output_file="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/lists/baseListOnly1tp.txt"
patient_list=$(cat $1)
crssec_list=$(cat $2)
count=0
i=0
patient_name="n"
echo "redo list for crssec structure with only 1 time point" > $output_file
until [ ! -n "$patient_name" ]
do
	i=$(($i+1))
	patient_name=$(echo $patient_list | cut -d ' ' -f$i)
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
		crssec_folder=$input_dir
		findTpPara
	done
	#count=$(($count+1))
	if [ "$k" -eq "1" ]; then
		count=$(($count+1))
		#echo "recon-all -base ${patient_name}_base $recon_para -all"
		echo ${patient_name} >> $output_file
		echo ${recon_para} > ${output_dir}//para${count}.txt
		/apps/sysapps/TORQUE/bin/qsub -q circ-spool -v output_dir=${output_dir},input_dir=${input_dir},name=${patient_name},i=${count} /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/submit_job_base.sh
	fi
done
echo $count
