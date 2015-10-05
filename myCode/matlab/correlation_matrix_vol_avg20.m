path=genpath('/data/users/rens/myCode/matlab');
addpath(path);
cd /mnt/eql/yeo1/data/COBRE/procsurffast/COBRE
for i=0:19
    vol_path = ['00' num2str(40000+i) '/vol/00' num2str(40000+i) '_bld002_rest_reorient_skip_faln_mc_g1000000000_bpss_resid_FS1mm_MNI1mm_MNI2mm_sm6.nii.gz'];
    coe = correlation_matrix(vol_path);
    coe_fisher = 0.5*log((1+coe)./(1-coe));
    if(i == 0)
        coe_avg = coe_fisher;
    else
        coe_avg = coe_avg*i/(i+1) + coe_fisher/(i+1); 
    end
end
coe_avg = (exp(2*coe_avg)-1)./(exp(2*coe_avg)+1);
x.nframes=1;
x.vol=coe_avg;
y=MRIwrite(x,'/data/users/rens/myCode/matlab/20avg_bld002_rest_reorient_skip_faln_mc_g1000000000_bpss_resid_FS1mm_MNI1mm_MNI2mm_sm6_coe.nii.gz');
% DrawSurfaceMaps(coeMash,'fsaverage5','inflated');
% ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
% avg_mesh=ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
