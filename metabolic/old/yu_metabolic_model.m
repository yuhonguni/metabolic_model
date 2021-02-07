%matlab toolbox installed
%Human-GEM, https://github.com/SysBioChalmers/Human-GEM
%RAVEN 
%CORBA



% read the rpkm data of neural stem cells
NSCctrlmeanrpkm = readtable('NSC_ctrl_mean_rpkm.txt','Format','%s%f')



% build structure
data_struct.tissues = NSCctrlmeanrpkm.Properties.VariableNames(2);
data_struct.genes = NSCctrlmeanrpkm.ensemblID;
data_struct.levels = table2array(NSCctrlmeanrpkm(:,2));
data_struct.threshold = 0.5;


% test essential tasks
essentialTasks= parseTaskList('/home/yu/Software/MATLAB/Toolbox/Human-GEM/data/metabolicTasks/metabolicTasks_Essential.xlsx')
% '/home/yu/Software/MATLAB/Toolbox/Human-GEM/' is your install directory of Human-GEM


%import the humanGEM 
load('HumanGEM.mat');

% set the parameters
refModel = ihuman;  % the reference model from which the GEM will be extracted
tissue = 'mean_rpkm';  % must match the tissue name in data_struct.tissues
celltype = [];  % used if tissues are subdivided into cell type, which is not the case here
hpaData = [];  % data structure containing protein abundance information (not used here)
arrayData = data_struct;  % data structure with gene (RNA) abundance information
metabolomicsData = [];  % list of metabolite names if metabolomic data is available
removeGenes = true;  % (default) remove lowly/non-expressed genes from the extracted GEM
taskFile = [];  % we already loaded the task file, so this input is not required
useScoresForTasks = true;  % (default) use expression data to decide which reactions to keep
printReport = true;  % (default) print status/completion report to screen
taskStructure = essentialTasks;  % metabolic task structure (used instead "taskFile")
params = [];  % additional optimization parameters for the INIT algorithm
paramsFT = [];  % additional optimization parameters for the fit-tasks algorithm

% run the modeling building
NSC_GEM = getINITModel2(refModel, tissue, celltype, hpaData, arrayData, metabolomicsData, removeGenes, taskFile, useScoresForTasks, printReport, taskStructure, params, paramsFT);
