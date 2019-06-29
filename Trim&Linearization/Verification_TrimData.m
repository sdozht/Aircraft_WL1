load('Trimpoint7.mat')
%%
Tr_flap = 0;

Sim_Control = struct;
Sim_Control.init = [0,0,opreport.States(12).x;... %Xe Ye Ze
                    opreport.States(7).x,0,opreport.States(9).x;... %ub vb wb 
                    0,opreport.States(6).x,0;... %roll pitch yaw
                    0,0,0]; %p q r
                
Sim_trimInput = [opreport.Inputs(1).u...%Xi
                ,opreport.Inputs(2).u...%Eta
                ,opreport.Inputs(3).u...%Throttle
                ,opreport.Inputs(4).u];%Zeta




% Tr_flap = 0;
% TP_uvwb = opreport.States(4).x;
% TP_Euler = opreport.States(1).x;
% 
% Sim_Control = struct;
% Sim_Control.init = [0,0,opreport.States(5).x(3);... %Xe Ye Ze
%                     TP_uvwb(1),0,TP_uvwb(3);... %ub vb wb 
%                     0,TP_Euler(2),0;... %roll pitch yaw
%                     0,0,0]; %p q r
%                 
% Sim_trimInput = [opreport.Inputs(1).u...%Xi
%                 ,opreport.Inputs(2).u...%Eta
%                 ,opreport.Inputs(3).u...%Throttle
%                 ,opreport.Inputs(4).u];%Zeta