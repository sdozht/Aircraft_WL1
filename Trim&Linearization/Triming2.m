%% Search for a specified operating point for the model - Trim_Model2.
%
% This MATLAB script is the command line equivalent of the trim model
% tab in linear analysis tool with current specifications and options.
% It produces the exact same operating points as hitting the Trim button.

% MATLAB(R) file generated by MATLAB(R) 9.3 and Simulink Control Design (TM) 5.0.
%
% Generated on: 27-Jun-2019 16:22:58
%% Trim initialization
Configuration.Mass = 800;
% 爬升工况
% Tr_flag = 1;
% Tr_alpha = 2*pi/180;
% Tr_V=30;
% Tr_Gamma = -6*pi/180;
% Tr_flap = 20/(Actuators.DFR.Def_Max*180/pi);  %这里襟翼偏转后给机翼的增幅，应该与迎角有关
% Sim_Control = struct;
% Sim_Control.init = [0,0,500;... %Xe Ye Ze
%                     Tr_V*cos(Tr_alpha),0,Tr_V*sin(Tr_alpha);... %ub vb wb 
%                     0,Tr_alpha-Tr_Gamma,0;... %roll pitch yaw
%                     0,0,0]; %p q r
                
% 巡航工况1
Tr_flag = 2;
Tr_alpha = 2.8*pi/180;
Tr_V=50;
Tr_Gamma = 0;
Tr_flap = 0;
Sim_Control = struct;
Sim_Control.init = [0,0,-2000;... %Xe Ye Ze
                    Tr_V*cos(Tr_alpha),0,Tr_V*sin(Tr_alpha);... %ub vb wb 
                    0,Tr_alpha+Tr_Gamma,0;... %roll pitch yaw
                    0,0,0]; %p q r


% 巡航工况2
% Tr_flag = 3;
% Tr_alpha = 4*pi/180;
% Tr_V=50;
% Tr_Gamma = 0*pi/180;
% Tr_flap = 0;
% Configuration.Mass = 800*0.7+1;
% Sim_Control = struct;
% Sim_Control.init = [0,0,2000;... %Xe Ye Ze
%                     Tr_V*cos(Tr_alpha),0,Tr_V*sin(Tr_alpha);... %ub vb wb 
%                     0,Tr_alpha-Tr_Gamma,0;... %roll pitch yaw
%                     0,0,0]; %p q r        

% % 下滑工况
% Tr_flag = 4;
% Tr_alpha = 6*pi/180;
% Tr_V=20;
% Tr_Gamma = 1*pi/180;
% Tr_flap = 30/(Actuators.DFR.Def_Max*180/pi);
% Configuration.Mass = 800*0.7+1;
% Sim_Control = struct;
% Sim_Control.init = [0,0,500;... %Xe Ye Ze
%                     Tr_V*cos(Tr_alpha),0,Tr_V*sin(Tr_alpha);... %ub vb wb 
%                     0,Tr_alpha-Tr_Gamma,0;... %roll pitch yaw
%                     0,0,0]; %p q r        

% Trim_Model([],[],[],'term');
%% Specify the model name
model = 'Trim_Model2';

%% Create the operating point specification object.
clear opspec
opspec = operspec(model);

%% Set the constraints on the states in the model.
% - The defaults for all states are Known = false, SteadyState = true,
%   Min = -Inf, Max = Inf, dxMin = -Inf, and dxMax = Inf.

% State (1) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/p
% - Default model initial conditions are used to initialize optimization.

% State (2) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/phi
% - Default model initial conditions are used to initialize optimization.

% State (3) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/psi
% - Default model initial conditions are used to initialize optimization.

% State (4) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/q
% - Default model initial conditions are used to initialize optimization.

% State (5) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/r
% - Default model initial conditions are used to initialize optimization.

% State (6) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/theta
% - Default model initial conditions are used to initialize optimization.

% State (7) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/u
% - Default model initial conditions are used to initialize optimization.

% State (8) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/v
% - Default model initial conditions are used to initialize optimization.

% State (9) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/w
% - Default model initial conditions are used to initialize optimization.

% State (10) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/xe
% - Default model initial conditions are used to initialize optimization.
opspec.States(10).SteadyState = false;

% State (11) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/ye
% - Default model initial conditions are used to initialize optimization.
opspec.States(11).SteadyState = false;

% State (12) - Trim_Model2/Subsystem/Equations|DynamicEquation2/Subsystem5/ze
% - Default model initial conditions are used to initialize optimization.

%% Set the constraints on the inputs in the model.
% - The defaults for all inputs are Known = false, Min = -Inf, and
% Max = Inf.

% Input (1) - Trim_Model2/Xi
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(1).Min = -1;
opspec.Inputs(1).Max = 1;

% Input (2) - Trim_Model2/Eta
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(2).Min = -1;
opspec.Inputs(2).Max = 1;

% Input (3) - Trim_Model2/Throttle
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(3).Min = 0;
opspec.Inputs(3).Max = 1;

% Input (4) - Trim_Model2/Zeta
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(4).Min = -1;
opspec.Inputs(4).Max = 1;

%% Set the constraints on the outputs in the model.
% - The defaults for all outputs are Known = false, Min = -Inf, and
% Max = Inf.

% Output (1) - Trim_Model2/VEL_K_R_E
% - Default model initial conditions are used to initialize optimization.

% Output (2) - Trim_Model2/POS_R_E
% - Default model initial conditions are used to initialize optimization.

% Output (3) - Trim_Model2/ATT_EULER
% - Default model initial conditions are used to initialize optimization.

% Output (4) - Trim_Model2/M_BE
% - Default model initial conditions are used to initialize optimization.

% Output (5) - Trim_Model2/VEL_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (6) - Trim_Model2/ROT_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (7) - Trim_Model2/ROT_DOT_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (8) - Trim_Model2/VEL_DOT_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (9) - Trim_Model2/FUEL_Availible
% - Default model initial conditions are used to initialize optimization.

% Output (10) - Trim_Model2/VEL_K_R_ABS
opspec.Outputs(10).y = 50;
opspec.Outputs(10).Known = true;

% Output (11) - Trim_Model2/Chi_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (12) - Trim_Model2/Gamma_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (13) - Trim_Model2/Alpha_A_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (14) - Trim_Model2/Beta_A_R_B
% - Default model initial conditions are used to initialize optimization.


%% Create the options
clear opt
opt = findopOptions('DisplayReport','iter');

%% Perform the operating point search.
clear op opreport
[op,opreport] = findop(model,opspec,opt);
%% save data
datapath = [Root_Folder,'/Trim&Linearization/ResultData'];
save([datapath,'/Trimpoint7'],'opreport','Tr_V','Tr_alpha','Tr_Gamma','Tr_flap','Tr_flag');
