Project_Handle  = simulinkproject();
Root_Folder     = Project_Handle.RootFolder;

Interface_Folder    = [Project_Handle.RootFolder,'/Interfaces'];
Files_in_Folder     = dir(Interface_Folder);                           

for Act_File = 1 : length(Files_in_Folder)                             
    if (findstr(Files_in_Folder(Act_File).name, 'BUS_DEF_'))           
        load([Interface_Folder,'/',Files_in_Folder(Act_File).name]);   
    end
end

%%
load Trimpoint7
load Linmod7
load('Configurations_WL1.mat')