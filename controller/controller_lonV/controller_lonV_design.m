%Linmod5flag2,基于巡航工况1设计控制律
%% initialize
KP_q = 1;
KP_q2 = 1;
KP_theta = 1;
KI_theta = 0;
KF_theta = 0;
KP_Hdot = 1;
KI_Hdot = 0;
KF_Hdot = 0;
CSim_Hdot = 1;
Tau_DE = 0.05;

%%
KI_V = 0;
KP_V = 1;
KF_V = 0;
CSim_V = 1;
CSim_Hdot = 0;
Tau_DTHR = 0.1;
%% 保存增益数据
save('lonV_gain20190526','KP_q','KP_q2','KP_theta','KI_theta','KF_theta','KP_Hdot','KI_Hdot','KF_Hdot','CSim_Hdot','Tau_DE','KI_V','KP_V','KF_V')

%% 
fprintf("\nKP_q = %f\nKP_q2 = %f\nKP_theta = %f\nKI_theta = %f\nKF_theta = %f\nKI_Hdot = %f\nKP_Hdot = %f\nKF_Hdot = %f\n",KP_q,KP_q2,KP_theta,KI_theta,KF_theta,KI_Hdot,KP_Hdot,KF_Hdot);


%% 验证稳定裕度
cmarginde = getLoopTransfer(CL1,'controller_lonHdot/ActuatorsDynamics/1');
figure(1)
nichols(-cmarginde);
grid on
figure(2)
margin(-cmarginde);
grid on

%% 验证稳定裕度
[A,B,C,D]=linmod('controller_lonHdot_for_bode');

G=ss(A,B,C,D);

margin(-G)

