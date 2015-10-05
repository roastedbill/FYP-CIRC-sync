#!/bin/bash
#######################################################################
# Generate lists of SMRI raw data      	      #
# Author: rens                                                        #
# Date: 3/Oct/2015                                                    #
#######################################################################
# Example:
#  sh preprocessFMRI.sh /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/lists/ListAfterLongQC.txt

raw_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/ADNI_150901_ADOnly/ADNI"
preprocessed_smri_dir="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI"
smri_long_qc="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI/scripts/lists/ListAfterLongQC.txt"
fmri_list="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/fMRI_session_list.txt"
smri_list="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/FMRI/scripts/sMRI_session_list.txt"
cd $raw_dir
find `pwd` -xdev -iname '*Resting_State_fMRI*.nii' 2>&1 | grep -v 'Permission denied'>$fmri_list
smri_index_list=$(cat $smri_long_qc)
smri_index='n'
smri=""
i=0
cd $preprocessed_smri_dir
until [ ! -n "$smri_index" ]
do
	echo $smri_index
	i=$(($i+1))
	smri_index=$(echo $smri_index_list | cut -d ' ' -f$i)
	if [ ! -n "$smri_index" ]; then
		break
	fi	
	smri+=$(find `pwd` -regex ".*I${smri_index}.*long.*_base")
	smri+=" "
done
echo $smri > $smri_list 
