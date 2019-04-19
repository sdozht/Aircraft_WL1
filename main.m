Configuration = Define_Configuration;


Sim_Control = struct;
Sim_Control.init = [0,0,0;... %Xe Ye Ze
                    0,0,0;... %u v w
                    0,0,0;... %roll pitch yaw
                    0,0,0]; %p q r
%%
run('Aircraft_WL1');