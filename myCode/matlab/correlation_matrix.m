function coe = correlation_matrix(fmri_path)
x=MRIread(fmri_path);
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
toc;
% save '/data/users/rens/myCode/coe_0040000_bold.mat' coe;
end
