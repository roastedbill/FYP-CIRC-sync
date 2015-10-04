cd /share/users/imganalysis/yeolab/data/hnu_ccbd/subj01/func1/gs-removal
lh_fsavg5=MRIread('rest.pp.sm0.fsaverage5.lh.nii.gz');
rh_fsavg5=MRIread('rest.pp.sm0.fsaverage5.rh.nii.gz');
lh_avg5_mesh=ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
rh_avg5_mesh=ReadNCAvgMesh('rh','fsaverage5','inflated','cortex');
% Remove Nodes whose MARS_label == 1
lh_fsavg3_vol_cortex=lh_fsavg5.vol(1,lh_avg5_mesh.MARS_label(1:642)==2,1,:);
rh_fsavg3_vol_cortex=rh_fsavg5.vol(1,rh_avg5_mesh.MARS_label(1:642)==2,1,:);
% Save reaults here
coe_lh=zeros(lh_fsavg5.width,length(lh_fsavg3_vol_cortex(1,:,1,1)));
coe_rh=zeros(rh_fsavg5.width,length(rh_fsavg3_vol_cortex(1,:,1,1)));
% Squeeze matrix
lh_fsavg5_vol=squeeze(lh_fsavg5.vol);
rh_fsavg5_vol=squeeze(rh_fsavg5.vol);
lh_fsavg3_vol=squeeze(lh_fsavg3_vol_cortex);
rh_fsavg3_vol=squeeze(rh_fsavg3_vol_cortex);

% Combine matrix
both_fsavg3_vol=[lh_fsavg3_vol;rh_fsavg3_vol];

% Fill matrix
tic
lh_normed_5=bsxfun(@minus,lh_fsavg5_vol,mean(lh_fsavg5_vol,2));
both_normed_3_T=bsxfun(@minus,both_fsavg3_vol,mean(both_fsavg3_vol,2))';
coe_lh=(lh_normed_5*both_normed_3_T)./(sqrt(sum(lh_normed_5.^2,2)*sum(both_normed_3_T.^2)));
rh_normed_5=bsxfun(@minus,rh_fsavg5_vol,mean(rh_fsavg5_vol,2));
coe_rh=(rh_normed_5*both_normed_3_T)./(sqrt(sum(rh_normed_5.^2,2)*sum(both_normed_3_T.^2)));
toc
%ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
%avg_mesh=ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');

