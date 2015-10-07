#!/bin/bash
#######################################################################
# Compress all nifti data inside a folder passed in($1)               #
# Author: rens                                                        #
# Date: 7/Oct/2015                                                    #
#######################################################################
# Example:
#  sh compressAllNii.sh /share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/RawDataCompressed
# 

if [ $# -ne 1 ]; then
	echo "Usage: sh compressAllNii.sh <folder_name>"
	exit 1
fi

root_dir=$1
cd $root_dir
nii_list=$(find `pwd` -regex ".*.nii")
nii_path="n"
i=0
count=0
until [ ! -n "$nii_path" ]
do
	i=$(($i+1))
	nii_path=$(echo $nii_list | cut -d ' ' -f$i)
	if [ ! -n "$nii_path" ]; then
		break
	fi
	echo Compressing $nii_path
	gzip $nii_path
	count=$(($count+1))
done
echo ${count} files have been compressed
