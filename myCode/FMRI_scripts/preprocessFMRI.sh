#!/bin/bash
#######################################################################
# Preprocess FMRI data given corresponding SMRI data                  #
# Receive lists of FMRI raw data ($1) and SMRI raw data ($2)	      #
# Author: rens                                                        #
# Date: 30/Sep/2015                                                   #
#######################################################################
# Example:
#  sh preprocessFMRI.sh /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/fMRI_session_list.txt 
# /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/sMRI_session_list.txt
# 
function matchName {
	SMRI_found='n'
	if [[ $1 =~ ([0-9]{3}_S_[0-9]{4}) ]]; then
		SMRI_id=${BASH_REMATCH[1]}
		if [[ $1 =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
                	SMRI_date=${BASH_REMATCH[1]}
			if [[ $2 == *"${SMRI_id}"* ]]; then
				if [[ $2 == *"${SMRI_date}"* ]]; then
					SMRI_found='y'
					anat_dir=$2
					if [[ $2 =~ (I[0-9]{5,6}) ]]; then
						smri_I=${BASH_REMATCH[1]}
					fi
					echo ".*${SMRI_id}.*${SMRI_date}.*${smri_I}.*nii"
					SMRI_nii=$(find `pwd` -regex ".*${SMRI_id}.*${SMRI_date}.*${smri_I}.*nii")
					echo $SMRI_nii	
					echo $1		
				fi
			fi
               	fi
       	fi					
}

if [ $# -ne 2 ]; then
	echo "Usage: sh preprocessFMRI.sh <rawFMRIData.txt> <rawSMRIData.txt>"
	exit 1
fi

raw_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/ADNI_150901_ADOnly/ADNI"
root_anat_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI"
output_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI"
smri_nii="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/smri.txt"
fmri_nii="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/fmri.txt"
FMRI_list=$(cat $1)
SMRI_list=$(cat $2)
i=0
no_SMRI_count=0
skip=4
surf_smooth=6
vol_smooth=6
bold=2
mpr=1
num_slices=""
SMRI_found="n"
anat_dir="n"
export sliceOrder="1:2:$num_slices 2:2:$num_slices"
FMRI_name="n"
SMRI_raw=""
count=0
cd $raw_dir
until [ ! -n "$FMRI_name" ]
do
	i=$(($i+1))
	FMRI_name=$(echo $FMRI_list | cut -d ' ' -f$i)
	if [ ! -n "$FMRI_name" ]; then
		break
	fi
	j=0
	SMRI_name="n"
	until [ ! -n "$SMRI_name" ]
	do
		j=$(($j+1))
		SMRI_name=$(echo $SMRI_list | cut -d ' ' -f$j)
		if [ ! -n "$SMRI_name" ]; then
			break
		fi
		matchName $FMRI_name $SMRI_name
		if [ $SMRI_found = 'y' ]; then
			count=$(($count+1))
			echo ${FMRI_name} > $fmri_nii
			echo ${SMRI_raw} > $smri_nii
			cmd="csh procsurffast_nii.csh -s ${patient_id} -rawnii ${fmri_nii} -anat_rawnii ${smri_nii} -anat_dir ${anat_dir} -tr ${tr} -mpr ${mpr} -bold ${bold} -sdir ${output_dir} -lowmem_fast -matlab_qc_plot -volproj_lowmem -surfsmooth ${surfsmooth} -fs_volsmooth ${vol_smooth} -skip ${skip}"
			echo $cmd
			break
		fi
	done
	# anat_dir=$(find . -regex ".*${SMRI_id}.*${SMRI_date}.*long.*_base")	
done
echo $count
echo $(($j+$i-2))
