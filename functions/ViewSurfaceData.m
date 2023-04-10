function ViewSurfaceData(ICC,SC,label,lowClim,upClim,percentile)
%% input
% ICC : ICC matrix
% SC  : surface want to visualize on SC (combined l/r surfaces) fslr32k 
% (combined_midthickness_32k_fs_LR.mat)
% label : parcellation .dlabel file (1 x V) vector.
nodal_strength=mean(ICC);

if nargin > 5
    pc_thr=prctile(nodal_strength,[5 95],'all');
    ind=find([nodal_strength>pc_thr(1) & nodal_strength<pc_thr(2)]);
%    nodal_ind=zeros(148,1);
%    nodal_ind(ind)=nodal_strength(ind);
end

%nodal_strength=normalize(nodal_strength);
data=parcel2full(nodal_strength',label);
data(isnan(data))=-inf;
data=SurfStatSmooth(data',SC,1);

figure;
if nargin >5
    %my_cmap=[zissou(246); 0.7 0.7 0.7];
    %my_cmap=[0.7 0.7 0.7; zissou(246)];
    
    %data=parcel2full(nodal_ind,label);
    %data(data==0)=1;
    %data(isnan(data))=10;
    data(isnan(data))=-inf;
    %data=SurfStatSmooth(data',SC,1);
    
    SurfStat_calibrate5Views(data,SC,[0.28 0.5 .25 .25; 0.52 0.50 .25 .25; 0.28 0.25 .25 .25; 0.52 0.25 .25 .25;0.4 0.4 .25 .25],1:5, [pc_thr(1) pc_thr(2)],zissou)
    %colormap(my_cmap)
else
    SurfStat_calibrate5Views(data,SC,[0.28 0.5 .25 .25; 0.52 0.50 .25 .25; 0.28 0.25 .25 .25; 0.52 0.25 .25 .25;0.4 0.4 .25 .25],1:5, [lowClim-0.1 upClim],zissou)
end
%my_cmap = [.7 .7 .7; zissou(256)];
%colormap(my_cmap);


end