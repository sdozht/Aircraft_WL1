bc1 = gcbh;
Simulink.Bus.createObject('Flight_Physics', bc1)


%%
datapath = [Root_Folder,'/Interfaces'];
save([datapath,'/BUS_DEF_FOR_MOM_TOT'],'FOR_MOM_TOT_BUS')