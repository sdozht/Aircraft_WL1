%% Search for a specified operating point for the model - Trim_Model.
%
% This MATLAB script is the command line equivalent of the trim model
% tab in linear analysis tool with current specifications and options.
% It produces the exact same operating points as hitting the Trim button.

% MATLAB(R) file generated by MATLAB(R) 9.3 and Simulink Control Design (TM) 5.0.
%
% Generated on: 01-May-2019 10:36:22

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
Tr_alpha = 4*pi/180;
Tr_V=50;
Tr_Gamma = 0;
Tr_flap = 0;
Sim_Control = struct;
Sim_Control.init = [0,0,2000;... %Xe Ye Ze
                    Tr_V*cos(Tr_alpha),0,Tr_V*sin(Tr_alpha);... %ub vb wb 
                    0,Tr_alpha-Tr_Gamma,0;... %roll pitch yaw
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
model = 'Trim_Model';

%% Create the operating point specification object.
opspec = operspec(model);

%% Set the constraints on the states in the model.
% - The defaults for all states are Known = false, SteadyState = true,
%   Min = -Inf, Max = Inf, dxMin = -Inf, and dxMax = Inf.

% State (1) - Trim_Model/Flight_physics|Flight_Physics_forTrim/Subsystem/6DOF (Euler Angles)/Calculate DCM & Euler Angles/phi theta psi
opspec.States(1).x = [0;Tr_alpha-Tr_Gamma;0];

% State (2) - Trim_Model/Flight_physics|Flight_Physics_forTrim/Subsystem/6DOF (Euler Angles)/Determine Force,  Mass & Inertia/mass
% - Default model initial conditions are used to initialize optimization.

% State (3) - Trim_Model/Flight_physics|Flight_Physics_forTrim/Subsystem/6DOF (Euler Angles)/p,q,r
% - Default model initial conditions are used to initialize optimization.

% State (4) - Trim_Model/Flight_physics|Flight_Physics_forTrim/Subsystem/6DOF (Euler Angles)/ub,vb,wb
opspec.States(4).x = [Tr_V*cos(Tr_alpha);0;Tr_V*sin(Tr_alpha)];

% State (5) - Trim_Model/Flight_physics|Flight_Physics_forTrim/Subsystem/6DOF (Euler Angles)/xe,ye,ze
% - Default model initial conditions are used to initialize optimization.
if Tr_flag == 1 || Tr_flag == 4
opspec.States(5).SteadyState = [false;false;false];
end
if Tr_flag == 2 || Tr_flag == 3
opspec.States(5).SteadyState = [false;false;true];
end
%% Set the constraints on the inputs in the model.
% - The defaults for all inputs are Known = false, Min = -Inf, and
% Max = Inf.

% Input (1) - Trim_Model/Xi
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(1).Max = 1;
opspec.Inputs(1).Min = -1;
% Input (2) - Trim_Model/Eta
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(2).Max = 1;
opspec.Inputs(2).Min = -1;
% Input (3) - Trim_Model/Throttle
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(3).Max = 1;
opspec.Inputs(3).Min = 0;
% if Tr_flag == 1
%     opspec.Inputs(3).u = 1;
%     opspec.Inputs(3).Known = true;
% end
% if Tr_flag == 4
%     opspec.Inputs(3).u = 0.1;
%     opspec.Inputs(3).Known = true;
% end
% Input (4) - Trim_Model/Zeta
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(4).Max = 1;
opspec.Inputs(4).Min = -1;
%% Set the constraints on the outputs in the model.
% - The defaults for all outputs are Known = false, Min = -Inf, and
% Max = Inf.

% Output (1) - Trim_Model/VEL_K_R_E
% - Default model initial conditions are used to initialize optimization.

% Output (2) - Trim_Model/POS_R_E
% - Default model initial conditions are used to initialize optimization.

% Output (3) - Trim_Model/ATT_EULER
% - Default model initial conditions are used to initialize optimization.
if Tr_flag == 4
    opspec.Outputs(3).Min = [-Inf;0;-Inf];
end
% Output (4) - Trim_Model/M_BE
% - Default model initial conditions are used to initialize optimization.

% Output (5) - Trim_Model/VEL_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (6) - Trim_Model/ROT_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (7) - Trim_Model/ROT_DOT_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (8) - Trim_Model/VEL_DOT_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (9) - Trim_Model/FUEL_Availible
% - Default model initial conditions are used to initialize optimization.

% Output (10) - Trim_Model/VEL_K_R_ABS
% - Default model initial conditions are used to initialize optimization.
% if Tr_flag == 1||Tr_flag == 4
%     opspec.Outputs(10).y = Tr_V;
%     opspec.Outputs(10).Known = true;
% end
% Output (11) - Trim_Model/Chi_K_R_B
% - Default model initial conditions are used to initialize optimization.

% Output (12) - Trim_Model/Gamma_K_R_B
% - Default model initial conditions are used to initialize optimization.
if Tr_flag == 1||Tr_flag == 4
    opspec.Outputs(12).y = Tr_Gamma;
    opspec.Outputs(12).Known = true;
end
% Output (13) - Trim_Model/Alpha_A_R_B
% - Default model initial conditions are used to initialize optimization.
% if Tr_flag == 2||Tr_flag == 3
%     opspec.Outputs(13).y = Tr_alpha;
%     opspec.Outputs(13).Known = true;
% end
% Output (14) - Trim_Model/Beta_A_R_B
% - Default model initial conditions are used to initialize optimization.
opspec.Outputs(14).y = 0;
opspec.Outputs(14).Known = true;

%% Create the options
opt = findopOptions('DisplayReport','iter');

%% Perform the operating point search.
[op,opreport] = findop(model,opspec,opt);

%% save data
datapath = [Root_Folder,'/Trim&Linearization/ResultData'];
save([datapath,'/Trimpoint7'],'opreport','Tr_V','Tr_alpha','Tr_Gamma','Tr_flap','Tr_flag');

