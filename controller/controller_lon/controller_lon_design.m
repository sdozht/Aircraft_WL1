%Linmod5flag2,基于巡航工况1设计控制律
%% initialize
KP_q = 1;
KP_q2 = 1;
KP_theta = 1;
KI_theta = 0;
KF_theta = 0;
CSim_theta = 1;

%% 保存增益数据
save('lon_gain20190526','KP_q','KP_q2','KP_theta','KI_theta','KF_theta')

%% 
fprintf("\nKP_q = %f\nKP_q2 = %f\nKP_theta = %f\nKI_theta = %f\nKF_theta = %f\n",KP_q,KP_q2,KP_theta,KI_theta,KF_theta);


%%
cmarginde = -getLoopTransfer(CL1,'controller_lon/ActuatorsDynamics/1');
figure(1)
nichols(cmarginde);
grid on
figure(2)
margin(cmarginde);
grid on


%%
KP_q = 1.7;
KP_q2 = 0.3;
KP_theta = 1.2;
KI_theta = 0.3;
KF_theta = 0.000000;

sim('controller_lon')
