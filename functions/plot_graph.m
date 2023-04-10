function plot_graph(ID_mat,bands,sub, method_n)
%% [Computing ID parameters]
% Computing ID matrices parameters: Idiff, Iself and Iothers

max_array=zeros(1,bands);
for i=1:bands
    dat=ID_mat(:,:,i);
    max_array(1,i)=max(dat(:));
end

upClim=max(max_array);

% id_params() computes Idiff, Iself, and Iothers
[Idiff, ~, ~]=id_params(ID_mat,bands,sub);

% sucrate() computes success rate
sr=zeros(5,1);
ax=figure;
name_band={'Delta','Theta','Alpha','Beta','Gamma'};

for j=1:bands
    sr(j,1)=sucrate(ID_mat(:,:,j),sub);
    %% [Plotting]
    % Plots the ID matrices for the 2 frequency bands (alpha and beta) and displays the ID
    % parameters for each ID matrix.
    
    
    subplot(1,5,j)
    lablx= 'Session 1';
    lably= 'Session 2';
    imagesc(ID_mat(:,:,j)),xlabel(lablx), ylabel(lably),...
        colorbar,caxis([0 upClim])
    axis square;
    title({
        [name_band{j}]
        ['Idiff = ' num2str(Idiff(j)) '   SR = ' num2str(sr(j)) '%' ]
        %['Actual values being n = ' num2str(nactual) ' and i = ' num2str(iactual)]
        });
    % subplot(2,1,j)
    % imagesc(ID_mat(:,:,j)),xlabel(lablx), ylabel(lably),...
    %     colorbar, title([method_n,' | Beta band',' | Idiff=', num2str(Idiff(j)),' | SR=',num2str(sr(j)), '%'])
    %custom_colormap('fake_parula');
    colormap('Zissou')
    axis square;
    xticks([]); xticklabels({});
    yticks([]); yticklabels({});
    
    %cbh=colorbar;
    %cbh.Color='none';
    %cbh.
end

suptitle(method_n)
set(gcf,'color','w');

end