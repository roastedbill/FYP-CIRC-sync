#!/bin/sh
#PBS -l walltime=960:00:0
echo $root_dir
echo $path
echo $name
export SUBJECTS_DIR=${root_dir}
cd ${root_dir}
recon-all -all -i ${path} -s ${name}
