#!/bin/sh
#--------------------------------------------------------------------
#Filename:   base_recon.sh
#Date:       7/9/2015
#Author:     nanbos
#Description:This program do base recon-all
#Version:    1.0
#--------------------------------------------------------------------	
export SUBJECTS_DIR=//data/users/nanbos/storage/ADNI
cd ${SUBJECTS_DIR}
#i=0
#j=0
#k=0
#dirname=0
var="141_S_1004"
old_list=""

echo $(find -maxdepth 1 -mindepth 1 -type d -exec basename {} \;)>crosssectional.txt

ID_list=$(cat fMRI_ID_list.txt)
dirnamelist=$(cat crosssectional.txt)
#echo $dirnamelist

#while true;do
#var="$(echo ${ID_list}|cut -d ' ' -f 1)"
echo $var
ID_list=${ID_list#*[[:space:]]}
i=0
j=0
k=0
dirname=0
lengthi=0
until [ ! -n "$dirname" ]
do
	i=$(($i+1))
	dirname=$(echo $dirnamelist | cut -d ' ' -f$i)
	
	if [[ $dirname =~ ([0-9]{3}_S_[0-9]{4}_S) ]]; then
		if [[ $dirname =~ ([0-9]{3}_S_[0-9]{4}) ]]; then
			if [[ "${BASH_REMATCH[1]}" == "$var"  ]]; then
			k=$(($k+1))
			dir[$k]=$dirname
			echo ${dir[$k]}
			fi
		fi
	fi
done
lengthi=${#dir[@]}
#if [[ $lengthi == 0 ]];then
#	echo "No such subject: $var"
#	continue
#fi
echo $lengthi
echo ${dir[2]}
name=$(echo "$var"_"base")
echo "name= $name"
para=
for ((i=1;i<=lengthi;i++))
do
	para="$para -tp ${dir[$i]}"
done
unset dir
echo "para= $para"
if [[ "$ID_list" == "$old_list" ]];then
	break
fi
old_list=$ID_list

recon-all -base $name ${para} -all
if [[ $lengthi == 0 ]];then
         echo "No such subject: $var"
         continue
fi
#done
