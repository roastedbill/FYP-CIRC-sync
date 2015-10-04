#!/bin/sh
#--------------------------------------------------------------------
#Filename:   recon_all_cross.sh
#Date:       9/9/2015
#Author:     nanbos
#Description:This program do cross-sectional recon-all
#Version:    1.0
#--------------------------------------------------------------------	

export SUBJECTS_DIR=//share/users/imganalysis/yeolab/data/ADNI/ADOnly
output_dir=//data/users/nanbos/storage/ADNI/preprocess_data/sMRI
raw_data_dir=//share/users/imganalysis/yeolab/data/ADNI/ADOnly/ADNI_150901_ADOnly/ADNI
list_dir=//data/users/nanbos/storage/ADNI/LIST

file_num=23

for (( i=1;i<=$file_num;i=i+1 ))
do
/apps/sysapps/TORQUE/bin/qsub -q circ-spool -v file_num=${i},list_dir=${list_dir},output_dir=${output_dir},input_dir=${raw_data_dir} /data/users/nanbos/storage/ADNI/scripts/submit_job_recon_all_cross.sh
done
