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
		patient_id=${BASH_REMATCH[1]}
		if [[ $1 =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
                	SMRI_date=${BASH_REMATCH[1]}
			if [[ $2 == *"${patient_id}"* ]]; then
				if [[ $2 == *"${SMRI_date}"* ]]; then
					SMRI_found='y'
					anat_dir=$2
					if [[ $2 =~ (I[0-9]{5,6}) ]]; then
						SMRI_I=${BASH_REMATCH[1]}
					fi
					# echo ".*${patient_id}.*${SMRI_date}.*${SMRI_I}.*nii"
					SMRI_nii=$(find `pwd` -regex ".*${patient_id}.*${SMRI_date}.*${SMRI_I}.*nii.gz")
					# echo $SMRI_nii	
					# echo $1		
				fi
			fi
               	fi
       	fi					
}
if [ $# -ne 2 ]; then
	echo "Usage: sh preprocessFMRI.sh <rawFMRIData.txt> <rawSMRIData.txt>"
	exit 1
fi
raw_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/RawDataCompressed"
compressed_raw_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/RawDataCompressed"
log_file="/data/users/rens/myCode/preprocessFMRI_log.txt"
output_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI"
SMRI_nii_txt="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/smri.txt"
FMRI_nii_txt="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/fmri.txt"
FMRI_info_txt="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/lists/SliceOrder_TR.txt" #<ImageID>,<SliceOrd>,<tr>
FMRI_list=$(cat $1)
SMRI_list=$(cat $2)
echo `date` > $log_file
i=0
skip=4
surf_smooth=6
vol_smooth=6
mpr=1
# bold=2 --- to be constructed 
# tr=3 --- to be find in info file
num_slices=""
SMRI_found="n"
anat_dir=""
FMRI_name="n"
SMRI_nii=""
count=0
FMRI_done=""
patient_id=""
SMRI_I=""
cd $compressed_raw_dir
until [ ! -n "$FMRI_name" ]
do
	i=$(($i+1))
	FMRI_name=$(echo $FMRI_list | cut -d ' ' -f$i)
	if [ ! -n "$FMRI_name" ]; then
		break
	fi
	echo ${FMRI_name} > $FMRI_nii_txt
	FMRI_date_session=$(echo $FMRI_name | rev | cut -d '/' -f2- | rev)
	run_count=1
	if [[ $FMRI_done == *"${FMRI_date_session}"* ]]; then
		continue
	else
		# echo $FMRI_date_session
		FMRI_done=${FMRI_done}${FMRI_date_session}
		k=$(($i+1))	
		FMRI_name_pair='n'
		until [ ! -n "$FMRI_name_pair" ]
		do
			FMRI_name_pair=$(echo $FMRI_list | cut -d ' ' -f$k)
			# echo $FMRI_name_pair
			FMRI_date_session_pair=$(echo $FMRI_name_pair | rev | cut -d '/' -f2- | rev)
			if [ "$FMRI_date_session_pair" == "$FMRI_date_session" ]; then
				run_count=$(($run_count+1))
				echo ${FMRI_name_pair} >> $FMRI_nii_txt			
			fi
			k=$(($k+1))
		done
	fi
	j=0
	SMRI_name="n"
	until [ ! -n "$SMRI_name" ]
	do
		j=$(($j+1))
		SMRI_name=$(echo $SMRI_list | cut -d ' ' -f$j)
		# echo $SMRI_name
		if [ ! -n "$SMRI_name" ]; then
			break
		fi
		matchName $FMRI_name $SMRI_name
		if [ $SMRI_found = 'y' ]; then
			count=$(($count+1))
			echo ${SMRI_nii} > $SMRI_nii_txt
			# find corresponding slice order and tr from info txt file
			if [[ $FMRI_name =~ (I[0-9]{5,6}) ]]; then
				FMRI_I=${BASH_REMATCH[1]}
				FMRI_I=${FMRI_I:1}
			fi
			sliceOrder=$(grep ${FMRI_I} ${FMRI_info_txt} | cut -d ',' -f3)
			tr=$(grep ${FMRI_I} ${FMRI_info_txt} | cut -d ',' -f2)
			export sliceOrder=$sliceOrder
			# construct bold parameter
			run_index=1
			bold=2
			until [ $run_index -eq $run_count ]
			do
				run_index=$(($run_index+1))
				bold=${bold}","$(($run_index+1))
			done
			cmd="procsurffast_nii.csh -s ${patient_id}_${SMRI_date} -rawnii ${FMRI_nii_txt} -anat_rawnii ${SMRI_nii_txt} -anat_dir ${anat_dir} -tr ${tr} -mpr ${mpr} -bold ${bold} -sdir ${output_dir} -volproj_lowmem -niireorient -surfsmooth ${surf_smooth} -fs_volsmooth ${vol_smooth} -mni_volsmooth ${vol_smooth} -skip ${skip}"
			# -lowmem_fast -matlab_qc_plot
			echo $cmd >> $log_file
			echo $run_count `cat $FMRI_nii_txt` >> $log_file
			echo $sliceOrder >> $log_file
			#tcsh -c "$cmd"
			#sleep 5
			break
		fi
	done	
done
echo finished without error, ${count} cmds are generated
