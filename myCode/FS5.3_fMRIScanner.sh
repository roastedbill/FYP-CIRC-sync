#!/bin/bash
##############################################################
# Find all fmri data ~ "Resting_State_fMRI"                  #
# Record patient ID, session number and scanning date in fout#
# Author: rens    					     #
# Date: 21/Aug/2015 					     #
##############################################################

# root folder where all data are stored
rootdir=$1
# file to store extracted data
foutList="/data/users/rens/myCode/fMRI_session_list.txt"
foutID="/data/users/rens/myCode/fMRI_ID_list.txt"
cd $rootdir
# use find to show all the fmri data ---'*Resting_State_fMRI*.nii'
# all warnings are ignored
# fmri data path are stored in local variable fmri_data
# extended fmri data are extracted as normal (no specification)
find -iname '*Resting_State_fMRI*.nii' 2>&1 | grep -v 'Permission denied'>$foutList
sed -i '/Extended_/d' $foutList
fmri_data=`cat $foutList`
fmri_data_old=""
lastID=""
ID_list=""
matched_mri=""
mri_old=""
total_num=0
rm $foutList
#echo $fmri_data ###for testing
while true; do
    fmri="$(echo ${fmri_data}|cut -d ' ' -f 1)"
    if [[ $fmri =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
        date=${BASH_REMATCH[1]}
    fi
    if [[ $fmri =~ ([0-9]{3}_S_[0-9]{4}) ]]; then
	ID=${BASH_REMATCH[1]}
   	if [ "${ID}" != "${lastID}" ]; then
	    ID_list="${ID_list} ${ID}"
	    lastID=${ID}
	    total_num=$((1+$total_num))
	fi
    fi
    mri=$(echo `find \( -name "*$date*" \) 2>&1`)
    while true; do
	cur_mri="$(echo ${mri}|cut -d ' ' -f 1)"
        mri=${mri#*[[:space:]]}
	if [[ $cur_mri =~ "N3" ]]; then
	    for cur_mri_nii in ${cur_mri}/*/*.nii
	    do
		echo $cur_mri_nii
		cur_mri_nii=${cur_mri_nii##*/}
                matched_mri="${matched_mri} ${cur_mri_nii}"
	    done
	fi
	if [ "$mri" == "$mri_old" ]; then
            break
        fi
	mri_old=$mri
    done
    echo ${fmri##*/} ${matched_mri} >> $foutList
    matched_mri=''
    fmri_data=${fmri_data#*[[:space:]]}
    if [ "$fmri_data" == "$fmri_data_old" ]; then
	break
    fi
    fmri_data_old=$fmri_data
done
echo $ID_list > $foutID
echo $total_num
