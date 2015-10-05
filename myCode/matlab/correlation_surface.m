function [coe_lh, coe_rh] = correlation_surface(smri_id)
cd /share/users/imganalysis/yeolab/data/COBRE/procsurffast/COBRE/
lh_fsavg5=MRIread([smri_id '/surf' '/lh.' smri_id '_bld002_rest_reorient_skip_faln_mc_g1000000000_bpss_resid_fsaverage6_sm6_fsaverage5.nii.gz']);
rh_fsavg5=MRIread([smri_id '/surf' '/rh.' smri_id '_bld002_rest_reorient_skip_faln_mc_g1000000000_bpss_resid_fsaverage6_sm6_fsaverage5.nii.gz']);
lh_vol=reshape(lh_fsavg5.vol,lh_fsavg5.nvoxels,lh_fsavg5.nframes);
rh_vol=reshape(rh_fsavg5.vol,rh_fsavg5.nvoxels,rh_fsavg5.nframes);
lh_avg5_mesh=ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
rh_avg5_mesh=ReadNCAvgMesh('rh','fsaverage5','inflated','cortex');
% Remove Nodes whose MARS_label == 1
lh_vol_cortex=lh_vol(lh_avg5_mesh.MARS_label==2,:);
rh_vol_cortex=rh_vol(rh_avg5_mesh.MARS_label==2,:);
% Save reaults here
seed_index=2393;
seed_vector=lh_vol(seed_index,:);
coe_lh=zeros(length(lh_vol(:,1)));
coe_rh=zeros(length(rh_vol(:,1)));
% Find coe
tic
seed_normed=bsxfun(@minus,seed_vector,mean(seed_vector));
lh_normed=bsxfun(@minus,lh_vol,mean(lh_vol,2));
coe_lh=(lh_normed*(seed_normed'))./(sqrt(sum(lh_normed.^2,2)*sum(seed_normed.^2)));
rh_normed=bsxfun(@minus,rh_vol,mean(rh_vol,2));
coe_rh=(rh_normed*(seed_normed'))./(sqrt(sum(rh_normed.^2,2)*sum(seed_normed.^2)));
toc
% Filter with threshold
threshold=-1;
coe_lh(coe_lh<threshold)=0;
coe_rh(coe_rh<threshold)=0;
% DrawSurfaceMaps(coe_lh,coe_rh,'fsaverage5','inflated');
end

