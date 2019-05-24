bc1 = gcbh;
Simulink.Bus.createObject('Sensors', bc1)


%%
datapath = [Root_Folder,'/Interfaces'];
save([datapath,'/BUS_DEF_Sensors'],'Sensors_BUS')