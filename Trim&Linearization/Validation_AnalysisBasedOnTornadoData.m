Cf              = Define_Configuration;
AD              = Define_AeroDerivatives;
Engine          = Define_Engine;
%% ����С�Ŷ����̾�����ʽ
g = 9.80665;
rho = 1.11;
m = Cf.Mass;
Iyy = Cf.Inertia_G_B(2,2);

V0 = 50;
alpha0 = 0.0489;
CD0 = 0.0024505*15; 
%�볣���ɻ���CD0���һ�����������ǵ�Tornado�������ļ��㱾��Ͳ�׼ȷ��
%���Դ˴��Ŵ�15��,�Ŵ��ɻ�����Ƚ��ƴﵽ15,���Ϊ����

qS = 0.5*rho*V0^2*Cf.S;
T0 = CD0*qS/cos(alpha0);
CL0 = (m*g-T0*sin(alpha0))/qS;

DD = struct;
DD.TV = 0;
AD.CDV = 0;
AD.CLV = 0;
DD.TDp = Engine.Tmax/1;


%���´���������xx_bar
DD.XV = DD.TV*cos(alpha0)/m-(AD.CDV+2*CD0)*qS/m/V0;  %����TV,CDVΪ0
DD.Xalpha = (-T0*sin(alpha0)-AD.CDAlpha*qS)/m;
DD.ZV = DD.TV*sin(alpha0)/m/V0+(AD.CLV+2*CL0)*qS/m/V0/V0; %����TV,CLVΪ0
DD.Zalpha = (T0*cos(alpha0)+AD.CLAlpha*qS)/m/V0;
DD.MV = 0; %CmVΪ0
DD.Malpha = AD.CmAlpha*qS*Cf.c/Iyy;
DD.Mq = AD.Cmq*qS*Cf.c^2/Iyy/2/V0;
DD.XDe = -AD.CDDe*qS/m;
DD.XDp = DD.TDp*cos(alpha0)/m;
DD.ZDe = AD.CLDe*qS/m/V0;
DD.ZDp = DD.TDp*sin(alpha0)/m/V0;
DD.MDe = AD.CmDe*qS*Cf.c/Iyy;
DD.MDp = 0;

%����״̬����
Aero_A = [DD.XV     DD.Xalpha+g    0   -g;
    -DD.ZV     -DD.Zalpha     1   0;
    DD.MV      DD.Malpha      DD.Mq  0;
    0       0           1   0];
Aero_B = [DD.XDe   DD.XDp;
    -DD.ZDe    -DD.ZDp;
    DD.MDe     DD.MDp;
    0       0];
Aero_C = eye(4);
Aero_D = zeros(4,2);

Aero_G = ss(Aero_A,Aero_B,Aero_C,Aero_D);
Gtmp = Aero_G;
%% ʱ����Ӧ
figure(1)
t=linspace(0,0.1,100);
step(Gtmp,t)

%% ������
damp(Gtmp)

%% ����ͼ���ȶ�ԣ��
figure(2)
margin(-Gtmp(4,1))
grid on
%% ��¶�˹ͼ
figure(3)
nichols(-Gtmp(4,1))
grid on

%% �ẽ��С�Ŷ����̾�����ʽ
Ixx = Cf.Inertia_G_B(1,1);
Izz = Cf.Inertia_G_B(3,3);
Ixz = Cf.Inertia_G_B(1,3);

Cf.V0 = V0;

DD.LBeta = AD.ClBeta*qS*Cf.b;
DD.Lp = AD.Clp*qS*Cf.b*Cf.b/2/Cf.V0;
DD.Lr = AD.Clr*qS*Cf.b*Cf.b/2/Cf.V0;
DD.LDa = AD.ClDa*qS*Cf.b;
DD.LDr = AD.ClDr*qS*Cf.b;

DD.NBeta = AD.CnBeta*qS*Cf.b;
DD.Np = AD.Cnp*qS*Cf.b*Cf.b/2/Cf.V0;
DD.Nr = AD.Cnr*qS*Cf.b*Cf.b/2/Cf.V0;
DD.NDa = AD.CnDa*qS*Cf.b;
DD.NDr = AD.CnDr*qS*Cf.b;


DD.LBeta_ = (DD.LBeta+Cf.Ixz/Cf.Izz*DD.NBeta)/(Cf.Ixx-Cf.Ixz^2/Cf.Izz);
DD.Lp_ = (DD.Lp+Cf.Ixz/Cf.Izz*DD.Np)/(Cf.Ixx-Cf.Ixz^2/Cf.Izz);
DD.Lr_ = (DD.Lr+Cf.Ixz/Cf.Izz*DD.Nr)/(Cf.Ixx-Cf.Ixz^2/Cf.Izz);
DD.LDa_ = (DD.LDa+Cf.Ixz/Cf.Izz*DD.NDa)/(Cf.Ixx-Cf.Ixz^2/Cf.Izz);
DD.LDr_ = (DD.LDr+Cf.Ixz/Cf.Izz*DD.NDr)/(Cf.Ixx-Cf.Ixz^2/Cf.Izz);

DD.NBeta_ = (DD.NBeta+Cf.Ixz/Cf.Ixx*DD.LBeta)/(Cf.Izz-Cf.Ixz^2/Cf.Ixx);
DD.Np_ = (DD.Np+Cf.Ixz/Cf.Ixx*DD.Lp)/(Cf.Izz-Cf.Ixz^2/Cf.Ixx);
DD.Nr_ = (DD.Nr+Cf.Ixz/Cf.Ixx*DD.Lr)/(Cf.Izz-Cf.Ixz^2/Cf.Ixx);
DD.NDa_ = (DD.NDa+Cf.Ixz/Cf.Ixx*DD.LDa)/(Cf.Izz-Cf.Ixz^2/Cf.Ixx);
DD.NDr_ = (DD.NDr+Cf.Ixz/Cf.Ixx*DD.LDr)/(Cf.Izz-Cf.Ixz^2/Cf.Ixx);

DD.YBeta_ = AD.CYBeta*qS/m/V0;
DD.Yp_ = AD.CYp*qS/m/V0*Cf.b/2/V0;
DD.Yr_ = AD.CYr*qS/m/V0*Cf.b/2/V0;
DD.YDa_ = AD.CYDa*qS/m/V0;
DD.YDr_ = AD.CYDr*qS/m/V0;

%%
theta0 = Cf.alpha0;
Aero_A2 = [DD.YBeta_, alpha0+DD.Yp_, DD.Yr_-1, g*cos(theta0)/V0;
    DD.LBeta_, DD.Lp_, DD.Lr_, 0;
    DD.NBeta_, DD.Np_, DD.Nr_, 0;
    0, 1, tan(theta0), 0];
Aero_B2 = [0, DD.YDr_;
    DD.LDa_, DD.LDr_;
    DD.NDa_, DD.NDr_;
    0, 0];
Aero_C2 = eye(4);
Aero_D2 = zeros(4,2);

Aero_G2 = ss(Aero_A2,Aero_B2,Aero_C2,Aero_D2);
Gtmp = Aero_G2;

%% ʱ����Ӧ
figure(1)
t=linspace(0,0.1,100);
step(Gtmp,t)

%% ������
damp(Gtmp)

%% ����ͼ���ȶ�ԣ��
figure(2)
margin(-Gtmp(4,1))
grid on
%% ��¶�˹ͼ
figure(3)
nichols(-Gtmp(4,1))
grid on

%% KARI
KARI = -(DD.NDa_-DD.LDa_*tan(alpha0))/(DD.NDr_-DD.LDr_*tan(alpha0))



