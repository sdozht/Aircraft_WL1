%% �����߻�ģ��Linmod�ṹ�������Ԥ���趨��ͼ���õ���һЩ����
load('Linmod001.mat');
load('Trimpoint001.mat');

FontSize = 16;
FontName = 'Times New Roman';
LineWidth = 1.5;
r2d=180/pi;

%% �ẽ���߻�ģ�ͣ�ѡ��Lat_4b��ʽ��״̬�ռ������з���
G2=ss(Linmod.Lat_4b.A,Linmod.Lat_4b.B,Linmod.Lat_4b.C,Linmod.Lat_4b.D);
G2.StateName = {'beta','p','r','phi'};
G2.InputName = {'Da','Dr'};
G2.OutputName = {'beta','p','r','phi'};

Gtmp=G2;

%% ������������ȣ���������ȻƵ�ʣ�ʱ�䳣��
damp(Gtmp)

%% �㼫��ֲ�ͼ������ͼ���ȶ�ԣ��
Gtmp2=-Gtmp(1,1);
figure(1)
subplot(1,2,1)
margin(Gtmp2)
grid on
subplot(1,2,2)
pzmap(Gtmp2)
grid on
%% ��¶�˹ͼ
figure(2)
nichols(Gtmp2)
grid on

%% ��ʼ�Ŷ� 1�� 1��/s 1��/s 1��
clear t x0
x0=[1/r2d;1/r2d;1/r2d;1/r2d];
t=[linspace(0,2,60);linspace(0,10,60);linspace(0,1000,60)];

clear y
y(:,:,1)=initial(Gtmp,x0,t(1,:));
y(:,:,2)=initial(Gtmp,x0,t(2,:));
y(:,:,3)=initial(Gtmp,x0,t(3,:));

figure(3)
for j=1:3
    for i=1:4
        ax(j,i)=subplot(4,3,j+(i-1)*3);
        plot(t(j,:),y(:,i,j)*180/pi,'LineWidth',LineWidth);
    end
end
ylabelset=["\beta/(\circ)";"p/(\circ)\cdots^{-1}";"r/(\circ)\cdots^{-1}";"\phi/(\circ)"];
for i=1:4
ylabel(ax(1,i),ylabelset(i));
end
for j=1:3
xlabel(ax(j,4),'Time/s');
end
titleset = ["short-time size","mid-time size","long-time size"];
for j=1:3
title(ax(j,1),titleset(j));
end
set(ax,'fontname',FontName,'fontsize',FontSize,'YGrid','on','XGrid','on')

%% ������Ӧ 1�ȸ���ƫ��
clear t y ax
t=[linspace(0,2,60);linspace(0,100,60);linspace(0,500,60)];
opts = stepDataOptions('StepAmplitude',1/r2d);
Gtmp3=Gtmp(:,1);

y(:,:,1)=step(Gtmp3,t(1,:),opts);
y(:,:,2)=step(Gtmp3,t(2,:),opts);
y(:,:,3)=step(Gtmp3,t(3,:),opts);

figure(4)
for j=1:3
    for i=1:4
        ax(j,i)=subplot(4,3,j+(i-1)*3);
        plot(t(j,:),y(:,i,j)*180/pi,'LineWidth',LineWidth);
    end
end
ylabelset=["\beta/(\circ)";"p/(\circ)\cdots^{-1}";"r/(\circ)\cdots^{-1}";"\phi/(\circ)"];
for i=1:4
ylabel(ax(1,i),ylabelset(i));
end
for j=1:3
xlabel(ax(j,4),'Time/s');
end
titleset = ["short-time size","mid-time size","long-time size"];
for j=1:3
title(ax(j,1),titleset(j));
end
set(ax,'fontname',FontName,'fontsize',FontSize,'YGrid','on','XGrid','on')


%% ������Ӧ 1�ȷ����ƫ��
clear t y ax
t=[linspace(0,2,60);linspace(0,100,60);linspace(0,500,60)];
opts = stepDataOptions('StepAmplitude',1/r2d);
Gtmp3=Gtmp(:,2);

y(:,:,1)=step(Gtmp3,t(1,:),opts);
y(:,:,2)=step(Gtmp3,t(2,:),opts);
y(:,:,3)=step(Gtmp3,t(3,:),opts);

figure(5)
for j=1:3
    for i=1:4
        ax(j,i)=subplot(4,3,j+(i-1)*3);
        plot(t(j,:),y(:,i,j)*180/pi,'LineWidth',LineWidth);
    end
end
ylabelset=["\beta/(\circ)";"p/(\circ)\cdots^{-1}";"r/(\circ)\cdots^{-1}";"\phi/(\circ)"];
for i=1:4
ylabel(ax(1,i),ylabelset(i));
end
for j=1:3
xlabel(ax(j,4),'Time/s');
end
titleset = ["short-time size","mid-time size","long-time size"];
for j=1:3
title(ax(j,1),titleset(j));
end
set(ax,'fontname',FontName,'fontsize',FontSize,'YGrid','on','XGrid','on')


