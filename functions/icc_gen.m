function [ICC_mat]=icc_gen(tensor1,tensor2,band)
    %% [ICC matrix computing]

    % Note- Estimating ICC matrices only for frequency bands of interest i.e. 
    % alpha (band=3) and beta (band=4). For delta, theta and gamma band change
    % band variable to 1, 2 and 5 respectively. 
   
    if strcmp(band,'delta')
        b=1;
    elseif  strcmp(band,'theta')
        b=2;
    elseif strcmp(band,'alpha')
        b=3;
    elseif strcmp(band,'beta')
        b=4;
    elseif strcmp(band,'gamma')
        b=5;
    end
    
    % ICC mat generation of selected band
    ICC_mat=zeros(148,148);
    for i=1:148
        for j=1:148
            if i<j
                temp1=squeeze(tensor1(i,j,b,:));
                temp2=squeeze(tensor2(i,j,b,:));
                temp_comp=[temp1, temp2];
                [r, ~, ~, ~, ~, ~, ~] = ICC(temp_comp,'1-1', 0.05, 0);
                ICC_mat(i,j)=r;
            end
        end
    end
    ICC_mat=ICC_mat+ICC_mat';   
end