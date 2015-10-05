cd /mnt/eql/yeo1/data/COBRE/procsurffast/COBRE/0040000/vol
x=MRIread('0040000_bld002_rest_reorient_skip_faln_mc_g1000000000_bpss_resid_FS1mm_MNI1mm_MNI2mm_sm6.nii.gz');
% rh_fsavg5=MRIread('rest.pp.sm0.fsaverage5.rh.nii.gz');
size(x.vol)
% ConvertRas2Vox([-7, -52, 26]', x.vox2ras)
Seed_co=[-3, -49, 25]';
Seed_mri=ConvertRas2Vox(Seed_co, x.vox2ras);
Seed_vol(1)=ceil(Seed_mri(2))+1;
Seed_vol(2)=ceil(Seed_mri(1))+1;
Seed_vol(3)=ceil(Seed_mri(3))+1;
Seed=squeeze(mean(mean(mean(((x.vol(Seed_vol(1)-2:Seed_vol(1)+2,Seed_vol(2)-2:Seed_vol(2)+2,Seed_vol(3)-2:Seed_vol(3)+2, :)))))));

vol=x.vol;
tic;
vol_normed=bsxfun(@minus,vol,mean(vol,4));
seed_normed=Seed-mean(Seed);
norminator=reshape(reshape(vol_normed,x.height*x.width*x.depth,x.nframes)*(seed_normed.'),x.height,x.width,x.depth);
size(norminator);
coe=norminator./sqrt(sum(vol_normed.^2,4).*sum(seed_normed.^2));
% for i=1:x.height
%     for j=1:x.width
%         for k=1:x.depth
%             coe(i,j,k)=corr2(Seed,squeeze(x.vol(i,j,k,:)));
%         end
%     end
% end
toc;
x.nframes=1;
x.vol=coe;
y=MRIwrite(x,'/data/users/rens/myCode/matlab/0040000_bld002_rest_reorient_skip_faln_mc_g1000000000_bpss_resid_FS1mm_MNI1mm_MNI2mm_sm6_coe.nii.gz');
% DrawSurfaceMaps(coeMash,'fsaverage5','inflated');
% ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
% avg_mesh=ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
