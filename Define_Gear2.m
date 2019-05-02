function Gear = Define_Gear
%% 起落架默认配置
    Default_Strut                     = struct;
    Default_Strut.POS_R_GearStrut_B   = [-0.1, 0.49, 0.32]'*4;                % 起落架触地点相对于参考重心的位置(体轴系) [m]
    Default_Strut.h_StrutUndeflected  = 0.32;
    Default_Strut.c                   = 800*40;                                % Strut Spring Constant [N/m]
    Default_Strut.ct                  = 20000*40;                              % Consider tire and ground is also a spring system, so it's Ground Spring Constant [N/m]
    Default_Strut.d                   = 250*40;                                % Strut Damping Constant [N/(m/s)]
    Default_Strut.dt                  = 1000*40;                               % Consider tire and ground is also a spring system, so it's Ground Damping Constant [N/m]    
    Default_Strut.FOR_MaxDamp         = 75000;                                % Maximum Strut Damper Force [N]
    Default_Strut.FOR_MaxSpring       = 75000;                                % Maximum Strut Spring Force [N]
    Default_Strut.Mue_Static          = 0.7;                                % Static  Friction Coefficient [-]
    Default_Strut.Mue_Roll            = 0.03;                              % Rolling Friction Coefficient [-]
    Default_Strut.Mue_Lat_per_Slip    = 5.2;                                % Lateral Friction Coefficient per Slip Angle [1/rad]
    Default_Strut.Mue_Lat_Max         = 5.2*1.25;                           % Maximum Lateral Friction Coefficient [-]
    Default_Strut.Compress_LengthMax  = 0.035*4;                              % Maximum Compression length [m] 起落架最大压缩量
    Default_Strut.Def_Max             = 20*pi/180;                          % Maximum Steer Deflection [rad]
    Default_Strut.Compress_LengthMax_Tire  = 0.01*4;                          % Maximum Compression length of Tire [m] 起落架轮胎最大压缩量

%% BWB Nose Gear Strut Definition
    Gear.NoseStrut                          = Default_Strut;                % Pre-Allocate Nose Strut with Default
    Gear.NoseStrut.POS_R_GearStrut_B        = [0.91, 0, 0.32]'*4;             % Position R of Gear Contact point in Body Frame [m]
    Gear.NoseStrut.c                        = 1040.3*40;                       % Spring Constant of damper strut [N/m]
    Gear.NoseStrut.ct                       = 10*1040.3*40;                    % Spring Constant of tire [N/m]
    Gear.NoseStrut.d                        = 300*40;                          % Damping Constant of damper strut [N/(m/s)]
    Gear.NoseStrut.dt                       = 300*40;                          % Damping Constant of tire [N/(m/s)]
    
%% BWB Left Main Gear Strut Definition
    Gear.LeftMainStrut                      = Default_Strut;                % Pre-Allocate Left Main Gear Strut with Default
    Gear.LeftMainStrut.POS_R_GearStrut_B    = [-0.1, -0.49, 0.32]'*4;         % Position R of Gear Contact point in Body Frame [m]
    Gear.LeftMainStrut.c                    = 4733.4*40;                       % Spring Constant of damper strut [N/m]
    Gear.LeftMainStrut.ct                   = 10*4733.4*40;                    % Spring Constant of tire [N/m]
    Gear.LeftMainStrut.d                    = 300*40;                          % Damping Constant of damper strut [N/(m/s)]
    Gear.LeftMainStrut.dt                   = 300*40;                          % Damping Constant of tire [N/(m/s)]    
    Gear.LeftMainStrut.Def_Max              = 0; 
    
%% BWB Right Main Gear Strut Definition
    Gear.RightMainStrut                     = Default_Strut;                % Pre-Allocate Right Main Gear Strut with Default
    Gear.RightMainStrut.POS_R_GearStrut_B   = [-0.1, +0.49, 0.32]'*4;         % Position R of Gear Contact point in Body Frame [m]
    Gear.RightMainStrut.c                   = 4733.4*40;                       % Spring Constant of damper strut [N/m]
    Gear.RightMainStrut.ct                  = 10*4733.4*40;                    % Spring Constant of tire [N/m]
    Gear.RightMainStrut.d                   = 300*40;                          % Damping Constant of damper strut [N/(m/s)]
    Gear.RightMainStrut.dt                  = 300*40;                          % Damping Constant of tire [N/(m/s)]  
    Gear.RightMainStrut.Def_Max             = 0; 
    
%=========END-OF-FILE======================================================
   
    
    
    
    