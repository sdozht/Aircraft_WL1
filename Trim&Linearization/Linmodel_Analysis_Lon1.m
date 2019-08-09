load('Linmod001.mat');
load('Trimpoint001.mat');

FontSize = 16;
FontName = 'Times New Roman';
LineWidth = 1.5;
r2d=180/pi;

%% 纵向 
G2=ss(Linmod.Lon_4b.A,Linmod.Lon_4b.B,Linmod.Lon_4b.C,Linmod.Lon_4b.D);
G2.StateName = {'V','alpha','q','theta'};
G2.InputName = {'De','Thr'};
G2.OutputName = {'q','alpha','theta','gamma','V','we'};
Gtmp=G2;

%% 特征根
damp(Gtmp)

%% 伯德图与稳定裕度
figure(1)
margin(-Gtmp(3,1))
grid on
%% 尼柯尔斯图
figure(2)
nichols(-Gtmp(3,1))
grid on

%% 初始扰动 1m/s 1° 1°/s 1°
x0=[1;1/r2d;1/r2d;1/r2d];
t(1,:)=linspace(0,1,100);
t(2,:)=linspace(0,120,100);

f=figure(3);
for i=1:2
y=initial(Gtmp,x0,t(i,:))
subplot(6,2,(i-1)+1)
plot(t(i,:),y(:,1)*r2d,'LineWidth',LineWidth)
ylabel('q/(\circ)\cdots^{-1}')
subplot(6,2,(i-1)+3)
plot(t(i,:),y(:,2)*r2d,'LineWidth',LineWidth)
ylabel('\alpha/(\circ)')
subplot(6,2,(i-1)+5)
plot(t(i,:),y(:,3)*r2d,'LineWidth',LineWidth)
ylabel('\theta/(\circ)')
subplot(6,2,(i-1)+7)
plot(t(i,:),y(:,4)*r2d,'LineWidth',LineWidth)
ylabel('\gamma/(\circ)')
subplot(6,2,(i-1)+9)
plot(t(i,:),y(:,4),'LineWidth',LineWidth)
ylabel('V/m\cdots^{-1}')
subplot(6,2,(i-1)+11)
plot(t(i,:),y(:,4),'LineWidth',LineWidth)
ylabel('we/m\cdots^{-1}')
xlabel('Time/s')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',FontSize,'fontname',FontName)

%% 操纵响应 1度升降舵偏角
t(1,:)=linspace(0,1,100);
t(2,:)=linspace(0,120,100);
opts = stepDataOptions('StepAmplitude',1/r2d);
Gtmp=G2(:,1);
f=figure(4);
for i=1:2
y=step(Gtmp,t(i,:),opts);
subplot(6,2,(i-1)+1)
plot(t(i,:),y(:,1)*r2d,'LineWidth',LineWidth)
ylabel('q[\circ/s]')
subplot(6,2,(i-1)+3)
plot(t(i,:),y(:,2)*r2d,'LineWidth',LineWidth)
ylabel('\alpha[\circ]')
subplot(6,2,(i-1)+5)
plot(t(i,:),y(:,3)*r2d,'LineWidth',LineWidth)
ylabel('\theta[\circ]')
subplot(6,2,(i-1)+7)
plot(t(i,:),y(:,4)*r2d,'LineWidth',LineWidth)
ylabel('\gamma[\circ]')
subplot(6,2,(i-1)+9)
plot(t(i,:),y(:,4),'LineWidth',LineWidth)
ylabel('V[m/s]')
subplot(6,2,(i-1)+11)
plot(t(i,:),y(:,4),'LineWidth',LineWidth)
ylabel('we[m/s]')
xlabel('Time[s]')
end
set(f.Children,'XGrid','on','YGrid','on','fontsize',FontSize,'fontname',FontName)













