function mat_band= subnet_matgenxv2(iccmat,yeoROIs)
    % subnet_matgenxv2() groups the thresolded nodal ICC matrix into
    % Yeo-ordered subnetworks. The 7 subnetworks are: (1) Visual, 
    % (2) Somatomotor, (3) Dorsal attention, (4) Ventral attention,  
    % (5) Limbic, (6) Frontoparietal, and (7) Default-mode network.  
    
    % Mat_band is the 7x7 matrix hosting the subnetwork-grouped and 
    % averaged ICC scores. Diagonal cobtains the intra-network ICC scores
    % and other locations contain the inter-network ICC scores.
    
    mat_band=zeros(7,7);
    %VIS
    mask_ut_vis = false(148);
    mask_ut_vis(find(yeoROIs==1), find(yeoROIs==1)) = true;
    mask_ut_vis = triu(mask_ut_vis,1);

    %SM
    mask_ut_sm = false(148);
    mask_ut_sm(find(yeoROIs==2), find(yeoROIs==2)) = true;
    mask_ut_sm = triu(mask_ut_sm,1);

    %DA
    mask_ut_da = false(148);
    mask_ut_da(find(yeoROIs==3), find(yeoROIs==3)) = true;
    mask_ut_da = triu(mask_ut_da,1);

    %VA
    mask_ut_va = false(148);
    mask_ut_va(find(yeoROIs==4), find(yeoROIs==4)) = true;
    mask_ut_va = triu(mask_ut_va,1);

    %L
    mask_ut_l = false(148);
    mask_ut_l(find(yeoROIs==5), find(yeoROIs==5)) = true;
    mask_ut_l = triu(mask_ut_l,1);

    %FP
    mask_ut_fp = false(148);
    mask_ut_fp(find(yeoROIs==6), find(yeoROIs==6)) = true;
    mask_ut_fp = triu(mask_ut_fp,1);

    %DMN
    mask_ut_dmn = false(148);
    mask_ut_dmn(find(yeoROIs==7), find(yeoROIs==7)) = true;
    mask_ut_dmn = triu(mask_ut_dmn,1);
    
    %intra-network connections
    mat_band(1,1)=mean(iccmat(mask_ut_vis));
    mat_band(2,2)=mean(iccmat(mask_ut_sm));
    mat_band(3,3)=mean(iccmat(mask_ut_da));
    mat_band(4,4)=mean(iccmat(mask_ut_va));
    mat_band(5,5)=mean(iccmat(mask_ut_l));
    mat_band(6,6)=mean(iccmat(mask_ut_fp));
    mat_band(7,7)=mean(iccmat(mask_ut_dmn));

    % inter-network connections
    %vis
    mask_ut_vis_sm=false(148); mask_ut_vis_sm(find(yeoROIs==1), find(yeoROIs==2)) = true;
    mask_ut_vis_da=false(148); mask_ut_vis_da(find(yeoROIs==1), find(yeoROIs==3)) = true;
    mask_ut_vis_va=false(148); mask_ut_vis_va(find(yeoROIs==1), find(yeoROIs==4)) = true;
    mask_ut_vis_l=false(148); mask_ut_vis_l(find(yeoROIs==1), find(yeoROIs==5)) = true;
    mask_ut_vis_fp=false(148); mask_ut_vis_fp(find(yeoROIs==1), find(yeoROIs==6)) = true;
    mask_ut_vis_dmn=false(148); mask_ut_vis_dmn(find(yeoROIs==1), find(yeoROIs==7)) = true;

    mat_band(1,2)=mean(iccmat(mask_ut_vis_sm));
    mat_band(1,3)=mean(iccmat(mask_ut_vis_da));
    mat_band(1,4)=mean(iccmat(mask_ut_vis_va));
    mat_band(1,5)=mean(iccmat(mask_ut_vis_l));
    mat_band(1,6)=mean(iccmat(mask_ut_vis_fp));
    mat_band(1,7)=mean(iccmat(mask_ut_vis_dmn));

    %sm
    mask_ut_sm_vis=false(148); mask_ut_sm_vis(find(yeoROIs==2), find(yeoROIs==1)) = true;
    mask_ut_sm_da=false(148); mask_ut_sm_da(find(yeoROIs==2), find(yeoROIs==3)) = true;
    mask_ut_sm_va=false(148); mask_ut_sm_va(find(yeoROIs==2), find(yeoROIs==4)) = true;
    mask_ut_sm_l=false(148); mask_ut_sm_l(find(yeoROIs==2), find(yeoROIs==5)) = true;
    mask_ut_sm_fp=false(148); mask_ut_sm_fp(find(yeoROIs==2), find(yeoROIs==6)) = true;
    mask_ut_sm_dmn=false(148); mask_ut_sm_dmn(find(yeoROIs==2), find(yeoROIs==7)) = true;

    mat_band(2,1)=mean(iccmat(mask_ut_sm_vis));
    mat_band(2,3)=mean(iccmat(mask_ut_sm_da));
    mat_band(2,4)=mean(iccmat(mask_ut_sm_va));
    mat_band(2,5)=mean(iccmat(mask_ut_sm_l));
    mat_band(2,6)=mean(iccmat(mask_ut_sm_fp));
    mat_band(2,7)=mean(iccmat(mask_ut_sm_dmn));

    %da
    mask_ut_da_vis=false(148); mask_ut_da_vis(find(yeoROIs==3), find(yeoROIs==1)) = true;
    mask_ut_da_sm=false(148); mask_ut_da_sm(find(yeoROIs==3), find(yeoROIs==2)) = true;
    mask_ut_da_va=false(148); mask_ut_da_va(find(yeoROIs==3), find(yeoROIs==4)) = true;
    mask_ut_da_l=false(148); mask_ut_da_l(find(yeoROIs==3), find(yeoROIs==5)) = true;
    mask_ut_da_fp=false(148); mask_ut_da_fp(find(yeoROIs==3), find(yeoROIs==6)) = true;
    mask_ut_da_dmn=false(148); mask_ut_da_dmn(find(yeoROIs==3), find(yeoROIs==7)) = true;

    mat_band(3,1)=mean(iccmat(mask_ut_da_vis));
    mat_band(3,2)=mean(iccmat(mask_ut_da_sm));
    mat_band(3,4)=mean(iccmat(mask_ut_da_va));
    mat_band(3,5)=mean(iccmat(mask_ut_da_l));
    mat_band(3,6)=mean(iccmat(mask_ut_da_fp));
    mat_band(3,7)=mean(iccmat(mask_ut_da_dmn));

    %va
    mask_ut_va_vis=false(148); mask_ut_va_vis(find(yeoROIs==4), find(yeoROIs==1)) = true;
    mask_ut_va_sm=false(148); mask_ut_va_sm(find(yeoROIs==4), find(yeoROIs==2)) = true;
    mask_ut_va_da=false(148); mask_ut_va_da(find(yeoROIs==4), find(yeoROIs==3)) = true;
    mask_ut_va_l=false(148); mask_ut_va_l(find(yeoROIs==4), find(yeoROIs==5)) = true;
    mask_ut_va_fp=false(148); mask_ut_va_fp(find(yeoROIs==4), find(yeoROIs==6)) = true;
    mask_ut_va_dmn=false(148); mask_ut_va_dmn(find(yeoROIs==4), find(yeoROIs==7)) = true;

    mat_band(4,1)=mean(iccmat(mask_ut_va_vis));
    mat_band(4,2)=mean(iccmat(mask_ut_va_sm));
    mat_band(4,3)=mean(iccmat(mask_ut_va_da));
    mat_band(4,5)=mean(iccmat(mask_ut_va_l));
    mat_band(4,6)=mean(iccmat(mask_ut_va_fp));
    mat_band(4,7)=mean(iccmat(mask_ut_va_dmn));

    %l
    mask_ut_l_vis=false(148); mask_ut_l_vis(find(yeoROIs==5), find(yeoROIs==1)) = true;
    mask_ut_l_sm=false(148); mask_ut_l_sm(find(yeoROIs==5), find(yeoROIs==2)) = true;
    mask_ut_l_da=false(148); mask_ut_l_da(find(yeoROIs==5), find(yeoROIs==3)) = true;
    mask_ut_l_va=false(148); mask_ut_l_va(find(yeoROIs==5), find(yeoROIs==4)) = true;
    mask_ut_l_fp=false(148); mask_ut_l_fp(find(yeoROIs==5), find(yeoROIs==6)) = true;
    mask_ut_l_dmn=false(148); mask_ut_l_dmn(find(yeoROIs==5), find(yeoROIs==7)) = true;

    mat_band(5,1)=mean(iccmat(mask_ut_l_vis));
    mat_band(5,2)=mean(iccmat(mask_ut_l_sm));
    mat_band(5,3)=mean(iccmat(mask_ut_l_da));
    mat_band(5,4)=mean(iccmat(mask_ut_l_va));
    mat_band(5,6)=mean(iccmat(mask_ut_l_fp));
    mat_band(5,7)=mean(iccmat(mask_ut_l_dmn));

    %fp
    mask_ut_fp_vis=false(148); mask_ut_fp_vis(find(yeoROIs==6), find(yeoROIs==1)) = true;
    mask_ut_fp_sm=false(148); mask_ut_fp_sm(find(yeoROIs==6), find(yeoROIs==2)) = true;
    mask_ut_fp_da=false(148); mask_ut_fp_da(find(yeoROIs==6), find(yeoROIs==3)) = true;
    mask_ut_fp_va=false(148); mask_ut_fp_va(find(yeoROIs==6), find(yeoROIs==4)) = true;
    mask_ut_fp_l=false(148); mask_ut_fp_l(find(yeoROIs==6), find(yeoROIs==5)) = true;
    mask_ut_fp_dmn=false(148); mask_ut_fp_dmn(find(yeoROIs==6), find(yeoROIs==7)) = true;

    mat_band(6,1)=mean(iccmat(mask_ut_fp_vis));
    mat_band(6,2)=mean(iccmat(mask_ut_fp_sm));
    mat_band(6,3)=mean(iccmat(mask_ut_fp_da));
    mat_band(6,4)=mean(iccmat(mask_ut_fp_va));
    mat_band(6,5)=mean(iccmat(mask_ut_fp_l));
    mat_band(6,7)=mean(iccmat(mask_ut_fp_dmn));

    %dmn
    mask_ut_dmn_vis=false(148); mask_ut_dmn_vis(find(yeoROIs==7), find(yeoROIs==1)) = true;
    mask_ut_dmn_sm=false(148); mask_ut_dmn_sm(find(yeoROIs==7), find(yeoROIs==2)) = true;
    mask_ut_dmn_da=false(148); mask_ut_dmn_da(find(yeoROIs==7), find(yeoROIs==3)) = true;
    mask_ut_dmn_va=false(148); mask_ut_dmn_va(find(yeoROIs==7), find(yeoROIs==4)) = true;
    mask_ut_dmn_l=false(148); mask_ut_dmn_l(find(yeoROIs==7), find(yeoROIs==5)) = true;
    mask_ut_dmn_fp=false(148); mask_ut_dmn_fp(find(yeoROIs==7), find(yeoROIs==6)) = true;

    mat_band(7,1)=mean(iccmat(mask_ut_dmn_vis));
    mat_band(7,2)=mean(iccmat(mask_ut_dmn_sm));
    mat_band(7,3)=mean(iccmat(mask_ut_dmn_da));
    mat_band(7,4)=mean(iccmat(mask_ut_dmn_va));
    mat_band(7,5)=mean(iccmat(mask_ut_dmn_l));
    mat_band(7,6)=mean(iccmat(mask_ut_dmn_fp));
end