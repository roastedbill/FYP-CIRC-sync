#!/bin/sh
#PBS -l walltime=960:00:0

export SUBJECTS_DIR=${input_dir}
cd ${input_dir}
recon_para=$(cat "$output_dir/para${i}.txt")
recon-all -base ${name}_base ${recon_para} -all
rm "$output_dir/para${i}.txt"



