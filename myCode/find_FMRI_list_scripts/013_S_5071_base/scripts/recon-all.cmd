#--------------------------------------------
#@# Longitudinal Base Subject Creation Thu Sep 24 14:05:17 SGT 2015

 mri_diff --notallow-pix /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S182448_I362974_2013-02-12/mri/rawavg.mgz /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S212225_I415830_2014-02-11/mri/rawavg.mgz 


 mri_diff --notallow-pix /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S190215_I374497_2013-05-20/mri/rawavg.mgz /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S212225_I415830_2014-02-11/mri/rawavg.mgz 


 mri_diff --notallow-pix /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S212216_I415831_2014-02-11/mri/rawavg.mgz /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S212225_I415830_2014-02-11/mri/rawavg.mgz 


 mri_robust_template --mov /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S212225_I415830_2014-02-11/mri/norm.mgz /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S182448_I362974_2013-02-12/mri/norm.mgz /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S190215_I374497_2013-05-20/mri/norm.mgz /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_S212216_I415831_2014-02-11/mri/norm.mgz --lta /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_base/mri/transforms/013_S_5071_S212225_I415830_2014-02-11_to_013_S_5071_base.lta /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_base/mri/transforms/013_S_5071_S182448_I362974_2013-02-12_to_013_S_5071_base.lta /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_base/mri/transforms/013_S_5071_S190215_I374497_2013-05-20_to_013_S_5071_base.lta /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_base/mri/transforms/013_S_5071_S212216_I415831_2014-02-11_to_013_S_5071_base.lta --template /mnt/eql/yeo1/data/ADNI/ADOnly/fMRI_MRI_correspondance/scripts/013_S_5071_base/mri/norm_template.mgz --average 1 --sat 4.685 

