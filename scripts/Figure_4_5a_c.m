
%% Setting the path to directories
clear all; close all; clc

% Define main directory in github repo
main_folder = fullfile('..');

% addpaths
addpath(genpath([main_folder filesep 'functions']))

% Directory of the tensor data
dir_tensor=dir([main_folder, filesep, 'data/Fig_4_5a', filesep, 'tensor_sub*']);

%%
% Create output directory
output_dir = [main_folder '/data/ICC/'];

if ~exist(output_dir,'dir')
    mkdir(output_dir);
end

%% 1. [ICC matrix computing]

for i=[1 3 5 7] 
    
    tensor1=struct2array(load([dir_tensor(i).folder, filesep, dir_tensor(i).name]));
    tensor2=struct2array(load([dir_tensor(i+1).folder, filesep, dir_tensor(i+1).name]));
   
    % generate ICC's for bands
    [ICC_mat_delta]=icc_gen(tensor1,tensor2,'delta');
    [ICC_mat_theta]=icc_gen(tensor1,tensor2,'theta');
    [ICC_mat_alpha]=icc_gen(tensor1,tensor2,'alpha');
    [ICC_mat_beta]=icc_gen(tensor1,tensor2,'beta');
    [ICC_mat_gamma]=icc_gen(tensor1,tensor2,'gamma');
    
    % Create structure all mats
    ICC_mat.delta=ICC_mat_delta;
    ICC_mat.theta=ICC_mat_theta;
    ICC_mat.alpha=ICC_mat_alpha;
    ICC_mat.beta=ICC_mat_beta;
    ICC_mat.gamma=ICC_mat_gamma;
    
    
    % Save the ICC matrices
    if contains(dir_tensor(i).name,'rest')
        save([output_dir, filesep ,'ICC_rest1_rest2'],'ICC_mat');
    elseif contains(dir_tensor(i).name,'prose')
        save([output_dir, filesep ,'ICC_prose_task1_task2'],'ICC_mat');      
    elseif contains(dir_tensor(i).name,'assr')
        save([output_dir, filesep ,'ICC_assr_task1_task2'],'ICC_mat');        
    elseif contains(dir_tensor(i).name,'MMN')
        save([output_dir, filesep ,'ICC_MMN_task1_task2'],'ICC_mat');
    end
    
end



%% 2. ICC Plotting

% preload organization of Yeo/Destrieux mapping
load([main_folder '/data/template/aparc_a2009_yeo_RS7_MEG.mat'])
load([main_folder '/data/template/Brainstorm_orderDestrieux.mat'])


% Load surface of lh/rh to plot (combined for SurfStatView)
load([main_folder '/data/template/combined_midthickness_32k_fs_LR.mat'])
x=ft_read_cifti([main_folder '/data/template/Destrieux_2009_148Parcels.dlabel.nii']);


% Make figures [alpha] ICC_mat , surface renders for each brain state
task_names={'rest1_rest2','prose_task1_task2','assr_task1_task2','MMN_task1_task2'};

for i=1:numel(task_names)
    load([main_folder, filesep, 'data', filesep, 'ICC', filesep, 'ICC_' task_names{i}]);
    
    % Reorder ICC matrices according to Destrieux parcellation/Yeo Networks
    ICC_Destr=ICC_mat.alpha(orderDestrieux,orderDestrieux);
    ICC_yeo=ICC_Destr(yeoOrder,yeoOrder);
    
    h=figure; imagesc(ICC_yeo); colormap('zissou'); cbh=colorbar('Xtick',[0.25 0.5, 0.75, 0.90 1]); caxis([0.25 1]);
    title(['ALPHA: ICC ' task_names{i}])
    axis square
    set(gcf,'color','w');
    yticks([29, 51, 64, 83, 99, 112, 148]); yticklabels({'VIS', 'SM', 'DA', 'VA', 'L', 'FP', 'DMN'});

    % 5th-95th percentile view
    ViewSurfaceData(ICC_Destr,SC,x.parcels,0.25,1,1)
    title(['ALPHA: ICC ' task_names{i}])
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    % take average ICC inter network-intra network for polar chart
    netw_conn=subnet_matgenxv2(ICC_Destr,yeoROIs);
    intra=diag(netw_conn);
    
    % take inter average
    remove_diagonal = @(t)reshape(netw_conn(~diag(ones(1,size(t, 1)))), size(t)-[1 0]);
    inter=remove_diagonal(netw_conn);
    inter=transpose(mean(inter,1));
    
    brain=1:7; brain=transpose(brain);
    ICC_polar=[brain inter intra];
    
    save([main_folder '/data/Fig_4-5c/alpha_polar_' task_names{i} '.mat'],'ICC_polar')
    
    
end


% Make figures [Beta] ICC_mat , surface renders for each brain state

for i=1:numel(task_names)
    load([main_folder, filesep, 'data', filesep, 'ICC', filesep, 'ICC_' task_names{i}]);
    
    % Reorder ICC matrices according to Destrieux parcellation/Yeo Networks
    ICC_Destr=ICC_mat.beta(orderDestrieux,orderDestrieux);
    ICC_yeo=ICC_Destr(yeoOrder,yeoOrder);
    
    h=figure; imagesc(ICC_yeo); colormap('zissou'); cbh=colorbar('Xtick',[0.25 0.5, 0.75, 0.90 1]); caxis([0.25 1]);
    title(['BETA: ICC ' task_names{i}])
    axis square
    set(gcf,'color','w');
    yticks([29, 51, 64, 83, 99, 112, 148]); yticklabels({'VIS', 'SM', 'DA', 'VA', 'L', 'FP', 'DMN'});

    % 5th-95th percentile view
    ViewSurfaceData(ICC_Destr,SC,x.parcels,0.25,1,1)
    title(['BETA: ICC ' task_names{i}])
    
    set(gcf,'units','normalized','outerposition',[0 0 1 1])
    
    
    % take average ICC inter network-intra network for polar chart
    netw_conn=subnet_matgenxv2(ICC_Destr,yeoROIs);
    intra=diag(netw_conn);
    
    % take inter average
    remove_diagonal = @(t)reshape(netw_conn(~diag(ones(1,size(t, 1)))), size(t)-[1 0]);
    inter=remove_diagonal(netw_conn);
    inter=transpose(mean(inter,1));
    
    brain=1:7; brain=transpose(brain);
    ICC_polar=[brain inter intra];
    
    save([main_folder '/data/Fig_4-5c/beta_polar_' task_names{i} '.mat'],'ICC_polar')
    

end



