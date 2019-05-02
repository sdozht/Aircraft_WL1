G2=ss(Linmod.Lon_4.A,Linmod.Lon_4.B,Linmod.Lon_4.C,Linmod.Lon_4.D);
G2.StateName = {'ub','wb','q','theta'}';
G2.InputName = {'De','Thr'};
G2.OutputName = {'ub','wb','q','theta'};

Gtmp=G2;
%%

t=linspace(0,0.1,100);
step(Gtmp,t)

%%
damp(Gtmp)


%%
margin(-Gtmp(3,1))
grid on
%%
nichols(-Gtmp(4,1))
grid on














%%
%% ������� ���ٶ�Ϊ50m/s���߶�Ϊ1000m�Ĺ�������ƽ
% ��ƽ���ӭ��Ϊ0.067���ٶ�Ϊ50.3m/s������Ϊ116N���ܶ�Ϊ1.11kg/m3
% CD*Ϊ-116/qs��CL*Ϊ-7.83e03/qs��
g = 9.80665;
alphax = 0.0957;
Vx = 50.3;
Tx = 116;

qs = 0.5*1.11*Vx^2*Configuration.S;
m = Configuration.Mass;
Iy = Configuration.Inertia_G_B(2,2);
CDx = -116/qs;
CLx = -7.83e03/qs;
TDp = Engine.Tmax/100;
Cmq = -25.8054; %����tornado����
TV = 0;
CDV = 0;
CLV = 0;


%���´���������xx_bar
XV = TV*cos(alphax)/m-(CDV+2*CDx)*qs/m/Vx;  %����TV,CDVΪ0
Xalpha = (-Tx*sin(alphax)-AeroDerivatives.CDAlpha*qs)/m;
ZV = TV*sin(alphax)/m/Vx+(CLV+2*CLx)*qs/m/Vx/Vx; %����TV,CLVΪ0
Zalpha = (Tx*cos(alphax)+AeroDerivatives.CLAlpha*qs)/m/Vx;
MV = 0; %CmVΪ0
Malpha = AeroDerivatives.CmAlpha*qs*Configuration.c/Iy;
Mq = Cmq*qs*Configuration.c^2/Iy/2/Vx;
XDe = -AeroDerivatives.CDDe*qs/m;
XDp = TDp*cos(alphax)/m;
ZDe = AeroDerivatives.CLDe*qs/m/Vx;
ZDp = TDp*sin(alphax)/m/Vx;
MDe = AeroDerivatives.CmDe*qs*Configuration.c/Iy;
MDp = 0;

%����״̬����
Aero_A = [XV     Xalpha+g    0   -g;
    -ZV     -Zalpha     1   0;
    MV      Malpha      Mq  0;
    0       0           1   0];
Aero_B = [XDe    XDp;
    -ZDe    -ZDp;
    MDe     MDp;
    0       0];
Aero_C = eye(4);
Aero_D = zeros(4,2);

Aero_G = ss(Aero_A,Aero_B,Aero_C,Aero_D);
%% 
t=linspace(0,100,100);
figure(1)
step(G2(3:4,1),t)
figure(2)
step(Aero_G(3:4,1),t)
figure(3)
pzmap(G2)
hold on
pzmap(Aero_G)

