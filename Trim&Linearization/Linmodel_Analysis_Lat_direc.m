%% �ẽ�� ��linmodflag2������ Ѳ������1
G3=ss(Linmod.Lat_4.A,Linmod.Lat_4.B,Linmod.Lat_4.C,Linmod.Lat_4.D);
G3.StateName = {'p','phi','vb','r'}';
G3.InputName = {'Da','Dr'};
G3.OutputName = {'p','phi','vb','r'};

Gtmp=G3;
%% ʱ����Ӧ
t=linspace(0,0.1,5000);
step(Gtmp,t)

%% ������
damp(Gtmp)

%% ����ͼ���ȶ�ԣ��
margin(-Gtmp(1,1))     
grid on
%% ��¶�˹ͼ
nichols(-Gtmp(1,1))
grid on

%% 1��ÿ���p��r�ĳ�ʼ�Ŷ�
clear t
x0=[1/57.3;0;0;1/57.3];
t(1,:)=linspace(0,5,100);
t(2,:)=linspace(0,50,100);

f=figure(1);
for i=1:2
y=initial(Gtmp,x0,t(i,:));
subplot(4,2,(i-1)+1)
plot(t(i,:),y(:,1)*57.3,'LineWidth',1.5)
ylabel('p[\circ/s]')
subplot(4,2,(i-1)+3)
plot(t(i,:),y(:,2)*57.3,'LineWidth',1.5)
ylabel('phi[\circ/s]')
subplot(4,2,(i-1)+5)
plot(t(i,:),y(:,3),'LineWidth',1.5)
ylabel('vb[m/s]')
subplot(4,2,(i-1)+7)
plot(t(i,:),y(:,4)*57.3,'LineWidth',1.5)
ylabel('r[\circ/s]')
xlabel('Time[s]')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',16)

%% 1m/s vb�ĳ�ʼ�Ŷ�
clear t
x0=[0;0;1;0];
t(1,:)=linspace(0,5,100);
t(2,:)=linspace(0,50,100);

f=figure(1);
for i=1:2
y=initial(Gtmp,x0,t(i,:));
subplot(4,2,(i-1)+1)
plot(t(i,:),y(:,1)*57.3,'LineWidth',1.5)
ylabel('p[\circ/s]')
subplot(4,2,(i-1)+3)
plot(t(i,:),y(:,2)*57.3,'LineWidth',1.5)
ylabel('phi[\circ/s]')
subplot(4,2,(i-1)+5)
plot(t(i,:),y(:,3),'LineWidth',1.5)
ylabel('vb[m/s]')
subplot(4,2,(i-1)+7)
plot(t(i,:),y(:,4)*57.3,'LineWidth',1.5)
ylabel('r[\circ/s]')
xlabel('Time[s]')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',16)


%% 1�ȸ���ƫ�ǵĲ�������Ӧ
t(1,:)=linspace(0,5,100);
t(2,:)=linspace(0,50,100);
opts = stepDataOptions('StepAmplitude',1/57.3);
Gtmp=G3(:,1);
f=figure(1);
for i=1:2
y=step(Gtmp,t(i,:),opts);
subplot(4,2,(i-1)+1)
plot(t(i,:),y(:,1)*57.3,'LineWidth',1.5)
ylabel('p[\circ/s]')
subplot(4,2,(i-1)+3)
plot(t(i,:),y(:,2)*57.3,'LineWidth',1.5)
ylabel('phi[\circ/s]')
subplot(4,2,(i-1)+5)
plot(t(i,:),y(:,3),'LineWidth',1.5)
ylabel('vb[m/s]')
subplot(4,2,(i-1)+7)
plot(t(i,:),y(:,4)*57.3,'LineWidth',1.5)
ylabel('r[\circ/s]')
xlabel('Time[s]')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',16)

%% 1�ȷ����ƫ�ǵĲ�������Ӧ
t(1,:)=linspace(0,5,100);
t(2,:)=linspace(0,50,100);
opts = stepDataOptions('StepAmplitude',1/57.3);
Gtmp=G3(:,2);
f=figure(1);
for i=1:2
y=step(Gtmp,t(i,:),opts);
subplot(4,2,(i-1)+1)
plot(t(i,:),y(:,1)*57.3,'LineWidth',1.5)
ylabel('p[\circ/s]')
subplot(4,2,(i-1)+3)
plot(t(i,:),y(:,2)*57.3,'LineWidth',1.5)
ylabel('phi[\circ/s]')
subplot(4,2,(i-1)+5)
plot(t(i,:),y(:,3),'LineWidth',1.5)
ylabel('vb[m/s]')
subplot(4,2,(i-1)+7)
plot(t(i,:),y(:,4)*57.3,'LineWidth',1.5)
ylabel('r[\circ/s]')
xlabel('Time[s]')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',16)





%% ֱ���������������������������������ģ�ͣ����������ɶ�ģ�͵���ƽ�߻�ģ�����Ա�
%% ������� ���ٶ�Ϊ50m/s���߶�Ϊ1000m�Ĺ�������ƽ
% % ��ƽ���ӭ��Ϊ0.067���ٶ�Ϊ50.3m/s������Ϊ116N���ܶ�Ϊ1.11kg/m3
% % CD*Ϊ-116/qs��CL*Ϊ-7.83e03/qs��
% g = 9.80665;
% alphax = 0.0957;
% Vx = 50.3;
% Tx = 116;
% 
% qs = 0.5*1.11*Vx^2*Configuration.S;
% m = Configuration.Mass;
% Iy = Configuration.Inertia_G_B(2,2);
% CDx = -116/qs;
% CLx = -7.83e03/qs;
% TDp = Engine.Tmax/100;
% Cmq = -25.8054; %����tornado����
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
% 




