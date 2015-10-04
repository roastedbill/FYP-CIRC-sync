#!/bin/sh

#PBS -l walltime=960:00:0
export SUBJECTS_DIR=$input_dir
cd $input_dir
recon-all -base ${name} ${recon_para} -all -sd ${output_dir}



