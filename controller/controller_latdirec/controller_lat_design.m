%Linmod5flag2,基于巡航工况1设计控制律
%% initialize
KP_p = 1;
KP_p2 = 1;
KP_phi = 1;
KI_phi = 0;
KF_phi = 0;
CSim_phi = 1;
Tau_DA = 0.05;

CSim_r = 0;
KP_r = 1;%手动调节至0.003
Tau_DR = 0.05;
tauw_r = 4;

Nda = Linmod.Lat_6.B(4,1);
Lda = Linmod.Lat_6.B(1,1);
Ndr = Linmod.Lat_6.B(4,2);
Ldr = Linmod.Lat_6.B(1,2);
alphax = opreport.Outputs(13).y;
K_ARI = -(Nda-Lda*tan(alphax))/(Ndr-Ldr*tan(alphax));
% -(Nda-Lda*tan(alphax))/(Ndr-Ldr*tan(alphax));
%% 保存增益数据
save('lat_gain20190526','KP_p','KP_p2','KP_r','KP_phi','KI_phi','KF_phi','K_ARI','tauw_r','Tau_DR','alphax','CSim_r','CSim_phi','Tau_DA')

%% 
fprintf("\nKP_p = %f\nKP_p2 = %f\nKP_r = %f\nKP_phi = %f\nKI_phi = %f\nKF_phi = %f\n",KP_p,KP_p2,KP_r,KP_phi,KI_phi,KF_phi);


%%
tauw_r = 5;
KP_r = 0.1;
K_ARI = -0.1;
sim('controller_lat');
figure(1)
hold on
plot(simr)