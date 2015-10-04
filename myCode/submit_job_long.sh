#!/bin/sh
#PBS -l walltime=960:00:0

export SUBJECTS_DIR=${root_dir}
cd ${root_dir}
recon-all -long ${path} ${base} -all
