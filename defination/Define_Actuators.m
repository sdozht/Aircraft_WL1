function Actuators = Define_Actuators
%% 默认舵机配置
Default_Actuators               = struct;
Default_Actuators.State_Name    = 'zheyoushenmeyong?';
Default_Actuators.Def_Min       = -30*pi/180;
Default_Actuators.Def_Max       = 30*pi/180;
Default_Actuators.Def_Bias      = 0;


%% 真实舵机，用于控制分配

Actuators.DAR                   = Default_Actuators;
Actuators.DAL                   = Default_Actuators;

Actuators.DFR                   = Default_Actuators;
Actuators.DFL                   = Default_Actuators;

Actuators.DVTR                  = Default_Actuators;
Actuators.DVTL                  = Default_Actuators;


%% 假想舵机，用于控制律设计
Actuators.Pseudo.DEDef_Max      = 30*pi/180;
Actuators.Pseudo.DADef_Max      = 30*pi/180;
Actuators.Pseudo.DRDef_Max      = 30*pi/180;
Actuators.Pseudo.FWDef_Max      = 20*pi/180;
Actuators.Pseudo.CAweight_De    = 0.5;
Actuators.Pseudo.CAweight_Dr    = 0.5;

end


