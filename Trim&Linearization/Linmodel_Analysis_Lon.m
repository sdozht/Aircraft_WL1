AeroDerivatives = Define_AeroDerivatives;
Configuration = Define_Configuration;
g = 9.80665;
load('Linmod5flag1.mat');
load('Trimpoint5flag1.mat');
%flag1:��������
%flag2:Ѳ������1
%flag3:Ѳ������2
%flag4:�»�����
%% ����
G2=ss(Linmod.Lon_5.A,Linmod.Lon_5.B,Linmod.Lon_5.C,Linmod.Lon_5.D);
G2.StateName = {'ub','wb','q','theta','H'}';
G2.InputName = {'De','Thr'};
G2.OutputName = {'ub','wb','q','theta','H'};

Gtmp=G2;
%% ʱ����Ӧ
t=linspace(0,0.1,100);
step(Gtmp,t)

%% ������
damp(Gtmp)

%% ����ͼ���ȶ�ԣ��
margin(-Gtmp(4,1))
grid on
%% ��¶�˹ͼ
nichols(-Gtmp(4,1))
grid on

%% 1��theta�ǵĳ�ʼ�Ŷ�
x0=[0;0;0;1/57.3;0];
t(1,:)=linspace(0,5,100);
t(2,:)=linspace(0,200,100);

f=figure(1);
for i=1:2
y=initial(Gtmp,x0,t(i,:))
subplot(4,2,(i-1)+1)
plot(t(i,:),y(:,1),'LineWidth',1.5)
ylabel('ub[m/s]')
subplot(4,2,(i-1)+3)
plot(t(i,:),y(:,2),'LineWidth',1.5)
ylabel('wb[m/s]')
subplot(4,2,(i-1)+5)
plot(t(i,:),y(:,3)*57.3,'LineWidth',1.5)
ylabel('q[\circ/s]')
subplot(4,2,(i-1)+7)
plot(t(i,:),y(:,4)*57.3,'LineWidth',1.5)
ylabel('\theta[\circ]')
xlabel('Time[s]')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',16)

%% 1rad������ƫ�ǵĲ�������Ӧ
t(1,:)=linspace(0,5,100);
t(2,:)=linspace(0,200,100);
opts = stepDataOptions('StepAmplitude',1/57.3);
Gtmp=G2(:,1);
f=figure(2);
for i=1:2
y=step(Gtmp,t(i,:),opts);
subplot(5,2,(i-1)+1)
plot(t(i,:),y(:,1),'LineWidth',1.5)
ylabel('ub[m/s]')
subplot(5,2,(i-1)+3)
plot(t(i,:),y(:,2),'LineWidth',1.5)
ylabel('wb[m/s]')
subplot(5,2,(i-1)+5)
plot(t(i,:),y(:,3)*57.3,'LineWidth',1.5)
ylabel('q[\circ/s]')
subplot(5,2,(i-1)+7)
plot(t(i,:),y(:,4)*57.3,'LineWidth',1.5)
ylabel('\theta[\circ]')
subplot(5,2,(i-1)+9)
plot(t(i,:),y(:,5),'LineWidth',1.5)
ylabel('H[m]')
xlabel('Time[s]')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',16)

%% ������ƽ������
syms aa de
Vp=linspace(25,100,20);

S=Configuration.S;
m=Configuration.Mass; %ע�⣺�������»�������Ѳ������2ʱ��Ӧʹ�ÿ�ȼ������Configuration.Mass_Constr
aaxset=zeros(1,length(Vp));
dexset=zeros(1,length(Vp));
for i=1:length(Vp)
    eq1 = AeroDerivatives.CLAlpha*(aa*180/pi+2)+AeroDerivatives.CLDe*de == m*g/(0.5*1.11*Vp(i)^2*S);
    eq2 = AeroDerivatives.Cm0+AeroDerivatives.CmAlpha*aa+AeroDerivatives.CmDe*de == 0;
    [aax,dex]=solve(eq1,eq2);
    aaxset(i)=vpa(aax,4);
    dexset(i)=vpa(dex,4);
end
fprintf('finished\n')
%% ������ƽ������ ��ͼ
f=figure(3);
subplot(211)
plot(Vp,aaxset*57.3,'LineWidth',1.5)
grid on
ylabel('��ƽӭ��[\circ]')
xlim([Vp(1) Vp(end)])
subplot(212)
plot(Vp,dexset*57.3,'LineWidth',1.5)
grid on
ylabel('��ƽ��ƫ��[\circ]')
xlabel('�ٶ�[m/s]')
xlim([Vp(1) Vp(end)])
set(f.Children,'FontSize',20)
%% ��ƽ��ƫ��������ϵ���仯 ��ͼ
f=figure(4);
CLset=AeroDerivatives.CLAlpha*(aaxset*180/pi+2)+AeroDerivatives.CLDe*dexset;
plot(CLset,dexset*57.3,'LineWidth',1.5)
xlabel('CL')
ylabel('��ƽ��ƫ��[\circ]')
grid on
xlim([CLset(end) CLset(1)])
set(f.Children,'FontSize',20)

%% ÿg��ƫ��
S=Configuration.S;
m=Configuration.Mass; %ע�⣺�������»�������Ѳ������2ʱ��Ӧʹ�ÿ�ȼ������Configuration.Mass_Constr
miu1=2*m/1.11/S/Configuration.c;
Cmq=-17.8879;
V=opreport.Outputs(10).y;
qs=0.5*1.11*V^2*S;
ddedn=-(-0.15+Cmq/miu1)/AeroDerivatives.CmDe*m*g/qs*57.3





%% ֱ���������������������������������ģ�ͣ����������ɶ�ģ�͵���ƽ�߻�ģ�����Ա�
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




%% ������� ���ٶ�Ϊ50m/s���߶�Ϊ1000m�Ĺ�������ƽ
% ��ƽ���ӭ��Ϊ0.0549���ٶ�Ϊ60m/s������Ϊ116N���ܶ�Ϊ1.11kg/m3
% CD*Ϊ-131/qs��CL*Ϊ-7.95e03/qs��
% g = 9.80665;
% alphax = 0.0549;
% Vx = 60;
% Tx = 128;
% 
% qs = 0.5*1.11*Vx^2*Configuration.S;
% m = Configuration.Mass;
% Iy = Configuration.Inertia_G_B(2,2);
% CDx = -131/qs;
% CLx = -7.95e03/qs;
% TDp = Engine.Tmax/100;
% Cmq = -17.8879; %����tornado����
% TV = 0;
% CDV = 0;
% CLV = 0;
% 
% 
% %���´���������xx_bar
% XV = TV*cos(alphax)/m-(CDV+2*CDx)*qs/m/Vx;  %����TV,CDVΪ0
% Xalpha = (-Tx*sin(alphax)-AeroDerivatives.CDAlpha*qs)/m;
% ZV = TV*sin(alphax)/m/Vx+(CLV+2*CLx)*qs/m/Vx/Vx; %����TV,CLVΪ0
% Zalpha = (Tx*cos(alphax)+AeroDerivatives.CLAlpha*qs)/m/Vx;
% MV = 0; %CmVΪ0
% Malpha = AeroDerivatives.CmAlpha*qs*Configuration.c/Iy;
% Mq = Cmq*qs*Configuration.c^2/Iy/2/Vx;
% XDe = -AeroDerivatives.CDDe*qs/m;
% XDp = TDp*cos(alphax)/m;
% ZDe = AeroDerivatives.CLDe*qs/m/Vx;
% ZDp = TDp*sin(alphax)/m/Vx;
% MDe = AeroDerivatives.CmDe*qs*Configuration.c/Iy;
% MDp = 0;
% 
% %����״̬����
% Aero_A = [XV     Xalpha+g    0   -g;
%     -ZV     -Zalpha     1   0;
%     MV      Malpha      Mq  0;
%     0       0           1   0];
% Aero_B = [XDe    XDp;
%     -ZDe    -ZDp;
%     MDe     MDp;
%     0       0];
% Aero_C = eye(4);
% Aero_D = zeros(4,2);
% 
% Aero_G = ss(Aero_A,Aero_B,Aero_C,Aero_D);
% %% 
% t=linspace(0,100,100);
% figure(1)
% step(G2(3:4,1),t)
% figure(2)
% step(Aero_G(3:4,1),t)
% figure(3)
% pzmap(G2)
% hold on
% pzmap(Aero_G)

