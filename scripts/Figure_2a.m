%% Plot graph of ID-mats /w stats

%% Setting the path to directories
clear all; close all; clc

% Define main directory in github repo
main_folder = fullfile('..');

% addpaths
addpath(genpath([main_folder filesep 'functions']))

% Directories of the IDs data
dir_hybrid=dir(fullfile(main_folder, 'data/Fig_2a/','*_hybrid*'));
dir_task=dir(fullfile(main_folder, 'data/Fig_2a/','*_task1_task2*'));
dir_rest=dir(fullfile(main_folder, 'data/Fig_2a','*_rest1_rest2*'));


%% Plotting ID-matrices with Iself/Idiff numbers for each frequency band
Nsub=20;

for i=1:numel(dir_hybrid)
    
    
    % Hybrid REST-TASK matrices
    load(fullfile(dir_hybrid(i).folder, dir_hybrid(i).name))
    
    if contains(dir_hybrid(i).name,'MMN')
        plot_graph(mID_mat,5,Nsub, ['AEC: MMN x REST'])
    elseif contains(dir_hybrid(i).name,'assr')
        plot_graph(mID_mat,5,Nsub,['AEC: ASSR x REST'])
    elseif contains(dir_hybrid(i).name,'prose')
        plot_graph(mID_mat,5,Nsub,['AEC: PROSE x REST'])
    end
       
    % Regular TASK combination
    load(fullfile(dir_task(i).folder, dir_task(i).name))
   
    if contains(dir_hybrid(i).name,'MMN')
        plot_graph(ID_mat,5,Nsub, ['AEC: MMN S1-S2'])
    elseif contains(dir_hybrid(i).name,'assr')
        plot_graph(ID_mat,5,Nsub,['AEC: ASSR S1-S2'])
    elseif contains(dir_hybrid(i).name,'prose')
        plot_graph(ID_mat,5,Nsub,['AEC: PROSE S1-S2'])
    end
   
end

% Regular REST combination
load(fullfile(dir_rest(1).folder, dir_rest(1).name))
plot_graph(ID_mat,5,Nsub, ['AEC: REST S1-S2'])

colormap('Zissou')
