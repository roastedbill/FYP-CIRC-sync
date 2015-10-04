#!/bin/sh
#PBS -l walltime=960:00:0

export SUBJECTS_DIR="/share/users/imganalysis/yeolab/data/ADNI/ADOnly/preprocessed/SMRI"
cd $SUBJECTS_DIR
recon-all -long ${crssec} ${base} -all
