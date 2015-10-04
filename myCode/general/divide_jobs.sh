#!/bin/sh
#--------------------------------------------------------------------
#Filename:   divide_jobs.sh
#Date:       9/9/2015
#Author:     nanbos
#Description:This program do cross-sectionally recon-all
#Version:    1.0
#--------------------------------------------------------------------	

export SUBJECTS_DIR=//data/users/nanbos/storage/ADNI/preprocess_data/sMRI
raw_data_dir=//share/users/imganalysis/yeolab/data/ADNI/ADOnly/ADNI_150901_ADOnly/ADNI
list_dir=//data/users/nanbos/storage/ADNI/LIST


i=0
#cat $list_dir/crssec_list.txt
while read myline
do
	i=$(($i+1))
#	echo "$myline"
	dirlist[$i]=${myline:1}
#	echo ${dirlist[$i]}
		
done < $list_dir/crssec_list.txt
echo $i
length=${#dirlist[@]}
echo $length
k=1
j=0
for (( i=1;i<=$length;i=i+1 ))
do
	if [[ $j == 10 ]];then
	k=$(($k+1))
	j=0
	fi
	j=$(($j+1))
	touch $list_dir/cross_job$k.txt
	echo ${dirlist[$i]}>>$list_dir/cross_job$k.txt
done
