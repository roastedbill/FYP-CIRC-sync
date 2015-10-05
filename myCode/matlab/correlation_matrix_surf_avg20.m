path=genpath('/data/users/rens/myCode/matlab');
addpath(path);
for i=0:19
    smri_id = ['00' num2str(40000+i) ];
    [coe_lh, coe_rh] = correlation_surface(smri_id);
    coe_fisher_lh = 0.5*log((1+coe_lh)./(1-coe_lh));
    coe_fisher_rh = 0.5*log((1+coe_rh)./(1-coe_rh));
    if(i == 0)
        coe_avg_lh = coe_fisher_lh;
        coe_avg_rh = coe_fisher_rh;
    else
        coe_avg_lh = coe_avg_lh*i/(i+1) + coe_fisher_lh/(i+1); 
        coe_avg_rh = coe_avg_rh*i/(i+1) + coe_fisher_rh/(i+1); 
    end
end
coe_avg_lh = (exp(2*coe_avg_lh)-1)./(exp(2*coe_avg_lh)+1);
coe_avg_rh = (exp(2*coe_avg_rh)-1)./(exp(2*coe_avg_rh)+1);

save '/data/users/rens/myCode/matlab/coe_20avg_lh.mat' coe_avg_lh
save '/data/users/rens/myCode/matlab/coe_20avg_rh.mat' coe_avg_rh
DrawSurfaceMaps(coe_avg_lh,coe_avg_rh,'fsaverage5','inflated');
% ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
% avg_mesh=ReadNCAvgMesh('lh','fsaverage5','inflated','cortex');
