g               = 9.80665;
Configuration   = Define_Configuration;
Engine          = Define_Engine;
Actuators       = Define_Actuators;
AeroDerivatives = Define_AeroDerivatives;
Gear            = Define_Gear;

Ts              = 0.01;
%%
% load Trimpoint5flag2
%%
Sim_Elevation = 40;
Sim_Control = struct;
Sim_Control.init = [0,0,-2000;... %Xe Ye Ze
                    50,0,0;... %ub vb wb 
                    0,0,0;... %roll pitch yaw 
                    0,0,0]; %p q r                      


%%
Lim                     = struct;
% Lim.Mode_stag_Vc_Min    = 20;
% Lim.Mode_stag_Vc_Max    = 30;
Lim.Max_Thetac          = 45*pi/180;
Lim.Max_Phic            = 60*pi/180;
Lim.Max_Steerc_rc       = 60*pi/180;


%%
run('Aircraft_WL1');


%% 从空中某点起飞
% TP_uvwb = opreport.States(4).x;
% TP_Euler = opreport.States(1).x;
% 
% Sim_Control = struct;
% Sim_Control.init = [0,0,-1000;... %Xe Ye Ze
%                     TP_uvwb(1),0,TP_uvwb(3);... %ub vb wb 
%                     0,TP_Euler(2),0;... %roll pitch yaw
%                     0,0,0]; %p q r
%                 
% Sim_trimInput = [opreport.Inputs(1).u...%Xi
%                 ,opreport.Inputs(2).u...%Eta
%                 ,opreport.Inputs(3).u...%Throttle
%                 ,opreport.Inputs(4).u];%Zeta
% Sim_trimInput = [0 ...%Xi
%                 ,0 ...%Eta
%                 ,0 ...%Throttle
%                 ,0];%Zeta

%% 从地面起飞
% VAR_Airport_On = 0;
% Sim_Elevation = 40;
% 
% dh = Gear.NoseStrut.POS_R_GearStrut_B(3);
% Sim_Control = struct;
% Sim_Control.init = [0,0,-(Sim_Elevation+dh);... %Xe Ye Ze
%                     0,0,0;... %ub vb wb 
%                     0,0,0;... %roll pitch yaw
%                     0,0,0]; %p q r
%                 
%%
% sys=tf([tauw_r 0],[tauw_r 1]);
% dsys=c2d(sys,0.01,'tustin'); % 传函离散 
% [Wnum,Wden]=tfdata(dsys,'v'); % 离散后提取分子分母

%%
% save('Configurations_WL1','cs')