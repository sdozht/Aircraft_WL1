g               = 9.80665;
Configuration   = Define_Configuration;
Engine          = Define_Engine;
Actuators       = Define_Actuators;

Sim_Control = struct;
Sim_Control.init = [0,0,0;... %Xe Ye Ze
                    0,0,0;... %u v w
                    0,0,0;... %roll pitch yaw
                    0,0,0 ]; %p q r
Ts = 0.01;
%%
Lim                     = struct;
% Lim.Mode_stag_Vc_Min    = 20;
% Lim.Mode_stag_Vc_Max    = 30;
Lim.Max_Thetac          = 45*pi/180;
Lim.Max_Phic            = 60*pi/180;
Lim.Max_Steerc_rc       = 60*pi/180;


%%
AeroDerivatives             = struct;
AeroDerivatives.CDAlpha     = 0.10031;
AeroDerivatives.CDBeta      = 8.0356e-06;


%%
run('Aircraft_WL1');
 