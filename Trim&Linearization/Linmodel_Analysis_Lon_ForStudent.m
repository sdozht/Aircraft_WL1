%% 导入线化模型Linmod结构体变量，预先设定绘图会用到的一些常量
FontSize = 16;
FontName = 'Times New Roman';
LineWidth = 1.5;
r2d=180/pi;

%% 纵向线化模型，选择Lon_4b形式的状态空间矩阵进行分析
G1=ss(Linmod.Lon_4b.A,Linmod.Lon_4b.B,Linmod.Lon_4b.C,Linmod.Lon_4b.D);
G1.StateName = {'V','alpha','q','theta'};
G1.InputName = {'De','Thr'};
G1.OutputName = {'q','alpha','theta','gamma','V','we'};

Gtmp=G1;

%% 特征根，阻尼比，无阻尼自然频率，时间常数
damp(Gtmp)

%% 零极点分布图，伯德图与稳定裕度
Gtmp2=-Gtmp(3,1);
figure(1)
subplot(1,2,1)
margin(Gtmp2)
grid on
subplot(1,2,2)
pzmap(Gtmp2)
grid on
%% 尼柯尔斯图
figure(2)
nichols(Gtmp2)
grid on

%% 初始扰动 1m/s 1° 1°/s 1°
clear t x0 y ax
x0=[1;1/r2d;1/r2d;1/r2d];
t=[linspace(0,1,60);linspace(0,120,60)];

y(:,:,1)=initial(Gtmp,x0,t(1,:));
y(:,:,2)=initial(Gtmp,x0,t(2,:));

figure('Name','初始扰动响应曲线')
for j=1:2
    for i=1:6
        ax(j,i)=subplot(6,2,j+(i-1)*2);
        plot(t(j,:),y(:,i,j)*r2d,'LineWidth',LineWidth);
    end
end
ylabelset=["q/(\circ)\cdots^{-1}";"\alpha/(\circ)";"\theta/(\circ)";"\gamma/(\circ)";"V/m\cdots^{-1}";"we/m\cdots^{-1}"];
for i=1:6
ylabel(ax(1,i),ylabelset(i));
end
for j=1:2
xlabel(ax(j,6),'Time/s');
end
titleset = ["short-time size","long-time size"];
for j=1:2
title(ax(j,1),titleset(j));
end
set(ax,'YGrid','on','XGrid','on','fontname',FontName,'fontsize',FontSize)


%% 操纵响应 1度升降舵偏角
clear t y ax
t=[linspace(0,1,60);linspace(0,120,60)];
opts = stepDataOptions('StepAmplitude',1/r2d);
Gtmp3=Gtmp(:,1);

y(:,:,1)=step(Gtmp3,t(1,:),opts);
y(:,:,2)=step(Gtmp3,t(2,:),opts);

figure('Name','1度升降舵偏角的操纵响应曲线')
for j=1:2
    for i=1:6
        ax(j,i)=subplot(6,2,j+(i-1)*2);
        plot(t(j,:),y(:,i,j)*r2d,'LineWidth',LineWidth);
    end
end
ylabelset=["q/(\circ)\cdots^{-1}";"\alpha/(\circ)";"\theta/(\circ)";"\gamma/(\circ)";"V/m\cdots^{-1}";"we/m\cdots^{-1}"];
for i=1:6
ylabel(ax(1,i),ylabelset(i));
end
for j=1:2
xlabel(ax(j,6),'Time/s');
end
titleset = ["short-time size","long-time size"];
for j=1:2
title(ax(j,1),titleset(j));
end
set(ax,'YGrid','on','XGrid','on','fontname',FontName,'fontsize',FontSize)


