function SurfStat_calibrate5Views(data, Slo, pos, handles, clim, cmap,background)
% function SurfStat_calibrate5Views(data, Slo, pos4by4, handes4by1, clim)
% shows lateral and medial/superior for the left/right hemisphere at 1 specified position 
% vectors [x y h w] 
%
%
% author: boris@bic.mni.mcgill.ca


if nargin<7
    background='white';
end


v=length(data);
vl=1:(v/2);
vr=vl+v/2;
t=size(Slo.tri,1);
tl=1:(t/2);
tr=tl+t/2;

a(handles(1)) =axes('position',[pos(1,1) pos(1,2) pos(1,3) pos(1,4)]);
trisurf(Slo.tri(tl,:),Slo.coord(1,vl),Slo.coord(2,vl),Slo.coord(3,vl),...
double(data(vl)),'EdgeColor','none');
view(-90,0); 
daspect([1 1 1]); axis tight; camlight; axis vis3d off;
lighting phong; material dull; shading interp;
set(a(handles(1)),'CLim',clim);   
colormap(a(handles(1)),cmap)

a(handles(2))=axes('position',[pos(2,1) pos(2,2) pos(2,3) pos(2,4)]);
trisurf(Slo.tri(tl,:),Slo.coord(1,vl),Slo.coord(2,vl),Slo.coord(3,vl),...
double(data(vl)),'EdgeColor','none');
view(90,0); 
daspect([1 1 1]); axis tight; camlight; axis vis3d off;
lighting phong; material dull; shading interp;
set(a(handles(2)),'CLim',clim); 
colormap(a(handles(2)),cmap)

a(handles(3))=axes('position',[pos(3,1) pos(3,2) pos(3,3) pos(3,4)]);
trisurf(Slo.tri(tr,:)-v/2,Slo.coord(1,vr),Slo.coord(2,vr),Slo.coord(3,vr),...
    double(data(vr)),'EdgeColor','none');
view(-90,0); 
daspect([1 1 1]); axis tight; camlight; axis vis3d off;
lighting phong; material dull; shading interp;
set(a(handles(3)),'CLim',clim); 
colormap(a(handles(3)),cmap)

a(handles(4))=axes('position',[pos(4,1) pos(4,2) pos(4,3) pos(4,4)]);
trisurf(Slo.tri(tr,:)-v/2,Slo.coord(1,vr),Slo.coord(2,vr),Slo.coord(3,vr),...
    double(data(vr)),'EdgeColor','none');
view(90,0); 
daspect([1 1 1]); axis tight; camlight; axis vis3d off;
lighting phong; material dull; shading interp;
set(a(handles(4)),'CLim',clim); 
colormap(a(handles(4)),cmap)


a(handles(5))=axes('position',[pos(5,1) pos(5,2) pos(5,3) pos(5,4)]);
trisurf(Slo.tri,Slo.coord(1,:),Slo.coord(2,:),Slo.coord(3,:),...
    double(data),'EdgeColor','none');
view(0,90); 
daspect([1 1 1]); axis tight; camlight; axis vis3d off;
lighting phong; material dull; shading interp;
set(a(handles(5)),'CLim',clim); 
colormap(a(handles(5)),cmap)


cb=colorbar('location','South');
set(cb,'Position',[0.48 0.20 0.10 0.03]);
set(cb,'XAxisLocation','bottom');
%set(cb,'TickLabels',[0.25 0.5, 0.75, 0.90 1])
%h=get(cb,'Title');
%set(h,'String',title);

whitebg(gcf,background);
set(gcf,'Color',background,'InvertHardcopy','off');

