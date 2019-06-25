AeroDerivatives = Define_AeroDerivatives;
Configuration = Define_Configuration;
g = 9.80665;
load('Linmod5flag1.mat');
load('Trimpoint5flag1.mat');
%flag1:爬升工况
%flag2:巡航工况1
%flag3:巡航工况2
%flag4:下滑工况
%% 纵向
G2=ss(Linmod.Lon_5.A,Linmod.Lon_5.B,Linmod.Lon_5.C,Linmod.Lon_5.D);
G2.StateName = {'ub','wb','q','theta','H'}';
G2.InputName = {'De','Thr'};
G2.OutputName = {'ub','wb','q','theta','H'};

Gtmp=G2;
%% 时域响应
t=linspace(0,0.1,100);
step(Gtmp,t)

%% 特征根
damp(Gtmp)

%% 伯德图与稳定裕度
margin(-Gtmp(4,1))
grid on
%% 尼柯尔斯图
nichols(-Gtmp(4,1))
grid on

%% 1度theta角的初始扰动
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

%% 1rad升降舵偏角的操纵下响应
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

%% 升降舵平衡曲线
syms aa de
Vp=linspace(25,100,20);

S=Configuration.S;
m=Configuration.Mass; %注意：当计算下滑工况及巡航工况2时，应使用空燃油质量Configuration.Mass_Constr
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
%% 升降舵平衡曲线 作图
f=figure(3);
subplot(211)
plot(Vp,aaxset*57.3,'LineWidth',1.5)
grid on
ylabel('配平迎角[\circ]')
xlim([Vp(1) Vp(end)])
subplot(212)
plot(Vp,dexset*57.3,'LineWidth',1.5)
grid on
ylabel('配平舵偏角[\circ]')
xlabel('速度[m/s]')
xlim([Vp(1) Vp(end)])
set(f.Children,'FontSize',20)
%% 配平舵偏角随升力系数变化 作图
f=figure(4);
CLset=AeroDerivatives.CLAlpha*(aaxset*180/pi+2)+AeroDerivatives.CLDe*dexset;
plot(CLset,dexset*57.3,'LineWidth',1.5)
xlabel('CL')
ylabel('配平舵偏角[\circ]')
grid on
xlim([CLset(end) CLset(1)])
set(f.Children,'FontSize',20)

%% 每g舵偏角
S=Configuration.S;
m=Configuration.Mass; %注意：当计算下滑工况及巡航工况2时，应使用空燃油质量Configuration.Mass_Constr
miu1=2*m/1.11/S/Configuration.c;
Cmq=-17.8879;
V=opreport.Outputs(10).y;
qs=0.5*1.11*V^2*S;
ddedn=-(-0.15+Cmq/miu1)/AeroDerivatives.CmDe*m*g/qs*57.3





%% 直接利用气动组的线性气动导数构造线性模型，与搭建的六自由度模型的配平线化模型作对比
%% 计算大导数 在速度为50m/s，高度为1000m的工作点配平
% 配平后的迎角为0.067，速度为50.3m/s，推力为116N，密度为1.11kg/m3
% CD*为-116/qs，CL*为-7.83e03/qs，
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
Cmq = -25.8054; %来自tornado数据
TV = 0;
CDV = 0;
CLV = 0;


%以下大导数都简化自xx_bar
XV = TV*cos(alphax)/m-(CDV+2*CDx)*qs/m/Vx;  %假设TV,CDV为0
Xalpha = (-Tx*sin(alphax)-AeroDerivatives.CDAlpha*qs)/m;
ZV = TV*sin(alphax)/m/Vx+(CLV+2*CLx)*qs/m/Vx/Vx; %假设TV,CLV为0
Zalpha = (Tx*cos(alphax)+AeroDerivatives.CLAlpha*qs)/m/Vx;
MV = 0; %CmV为0
Malpha = AeroDerivatives.CmAlpha*qs*Configuration.c/Iy;
Mq = Cmq*qs*Configuration.c^2/Iy/2/Vx;
XDe = -AeroDerivatives.CDDe*qs/m;
XDp = TDp*cos(alphax)/m;
ZDe = AeroDerivatives.CLDe*qs/m/Vx;
ZDp = TDp*sin(alphax)/m/Vx;
MDe = AeroDerivatives.CmDe*qs*Configuration.c/Iy;
MDp = 0;

%构造状态矩阵
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




%% 计算大导数 在速度为50m/s，高度为1000m的工作点配平
% 配平后的迎角为0.0549，速度为60m/s，推力为116N，密度为1.11kg/m3
% CD*为-131/qs，CL*为-7.95e03/qs，
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
% Cmq = -17.8879; %来自tornado数据
% TV = 0;
% CDV = 0;
% CLV = 0;
% 
% 
% %以下大导数都简化自xx_bar
% XV = TV*cos(alphax)/m-(CDV+2*CDx)*qs/m/Vx;  %假设TV,CDV为0
% Xalpha = (-Tx*sin(alphax)-AeroDerivatives.CDAlpha*qs)/m;
% ZV = TV*sin(alphax)/m/Vx+(CLV+2*CLx)*qs/m/Vx/Vx; %假设TV,CLV为0
% Zalpha = (Tx*cos(alphax)+AeroDerivatives.CLAlpha*qs)/m/Vx;
% MV = 0; %CmV为0
% Malpha = AeroDerivatives.CmAlpha*qs*Configuration.c/Iy;
% Mq = Cmq*qs*Configuration.c^2/Iy/2/Vx;
% XDe = -AeroDerivatives.CDDe*qs/m;
% XDp = TDp*cos(alphax)/m;
% ZDe = AeroDerivatives.CLDe*qs/m/Vx;
% ZDp = TDp*sin(alphax)/m/Vx;
% MDe = AeroDerivatives.CmDe*qs*Configuration.c/Iy;
% MDp = 0;
% 
% %构造状态矩阵
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

