#!/bin/bash
##############################################################
# Cross-sectional process for all data(except M3) under      #
# SUBJECTS_DIR which is also the output folder               #
# All the outputs are named by id_S_I_date                   #
# Author: rens                                               #
# Date: 26/Aug/2015                                          #
##############################################################

# root folder where all data are stored
export SUBJECTS_DIR=$1
foutList="`pwd`/crssec_list.txt"
cd $SUBJECTS_DIR
data_path_list="$(find -iname '*.nii' 2>&1)"
#data_path_list=${data_path_list#*[[:space:]]}
#echo $data_path_list
old_list=""
crssec_list=""
while true;do 
data_path="$(echo ${data_path_list}|cut -d ' ' -f 1)"
if [ "$data_path_list" == "$old_list" ]; then
    break
fi
old_list=$data_path_list
data_path_list=${data_path_list#*[[:space:]]}
#data_path_list="$(echo ${data_path_list}|cut -d ' ' -f 2-)"
#echo datapath: $data_path
#echo list: $data_path_list
if [[ $data_path =~ N3_Br_ ]]; then
    #echo "inif"
    continue
fi
if [[ $data_path =~ ([0-9]{3}_S_[0-9]{4}) ]]; then
        ID=${BASH_REMATCH[1]}
fi
if [[ $data_path =~ ([0-9]{4}-[0-9]{2}-[0-9]{2}) ]]; then
        date=${BASH_REMATCH[1]}
fi
if [[ $data_path =~ (S[0-9]{5,6}) ]]; then
        serial_num=${BASH_REMATCH[1]}
fi
if [[ $data_path =~ (I[0-9]{5,6}) ]]; then
        image_num=${BASH_REMATCH[1]}
fi
data_name=$(echo ${ID}_"$serial_num"_"$image_num"_"$date")
crssec_list="${crssec_list}${data_name}\n"
echo $data_path
echo $data_name
#bash /data/users/rens/myCode/submit_job_crssec.sh $data_name $data_path
#/apps/sysapps/TORQUE/bin/qsub -q circ-spool -v root_dir=${SUBJECTS_DIR},name=${data_name},path=${data_path} /data/users/rens/myCode/submit_job_crssec.sh
done
echo -e $crssec_list > $foutList
