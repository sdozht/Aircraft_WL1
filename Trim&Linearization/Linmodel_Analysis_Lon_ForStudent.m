%% �����߻�ģ��Linmod�ṹ�������Ԥ���趨��ͼ���õ���һЩ����
FontSize = 16;
FontName = 'Times New Roman';
LineWidth = 1.5;
r2d=180/pi;

%% �����߻�ģ�ͣ�ѡ��Lon_4b��ʽ��״̬�ռ������з���
G1=ss(Linmod.Lon_4b.A,Linmod.Lon_4b.B,Linmod.Lon_4b.C,Linmod.Lon_4b.D);
G1.StateName = {'V','alpha','q','theta'};
G1.InputName = {'De','Thr'};
G1.OutputName = {'q','alpha','theta','gamma','V','we'};

Gtmp=G1;

%% ������������ȣ���������ȻƵ�ʣ�ʱ�䳣��
damp(Gtmp)

%% �㼫��ֲ�ͼ������ͼ���ȶ�ԣ��
Gtmp2=-Gtmp(3,1);
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

%% ��ʼ�Ŷ� 1m/s 1�� 1��/s 1��
clear t x0 y ax
x0=[1;1/r2d;1/r2d;1/r2d];
t=[linspace(0,1,60);linspace(0,120,60)];

y(:,:,1)=initial(Gtmp,x0,t(1,:));
y(:,:,2)=initial(Gtmp,x0,t(2,:));

figure('Name','��ʼ�Ŷ���Ӧ����')
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


%% ������Ӧ 1��������ƫ��
clear t y ax
t=[linspace(0,1,60);linspace(0,120,60)];
opts = stepDataOptions('StepAmplitude',1/r2d);
Gtmp3=Gtmp(:,1);

y(:,:,1)=step(Gtmp3,t(1,:),opts);
y(:,:,2)=step(Gtmp3,t(2,:),opts);

figure('Name','1��������ƫ�ǵĲ�����Ӧ����')
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


