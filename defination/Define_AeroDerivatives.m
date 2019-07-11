function AeroDerivatives = Define_AeroDerivatives
%% �������ṩ�����ݣ�ԭ���ݼ�tornadoResult.docx
%%
% �Ƕȵ�λ��Ϊrad
% ����ԭ���ݲ������໬�ǣ�����ƫ�Ƕ�����������볣�涨���෴�����ԶԲ���ԭ���ݵķ��Ž��и���
AeroDerivatives             = struct;
AeroDerivatives.CLAlpha     = 6.0094;
AeroDerivatives.CLBeta      = 1.0202e-06;                                   %�໬�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CLq         = 14.9528;
AeroDerivatives.CLDe        = 0.8867;
AeroDerivatives.CLDf        = 2.0336;
AeroDerivatives.CLDr        =-3.5351e-06;
AeroDerivatives.CLDa        =2.6815e-06;                                    %����ƫ�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CL0         =0.2099*0+0.1609;
%CL0����ƽ��������Ҫ������
% a = 2.8*pi/180;
% CL0=m*g/qS-AeroDerivatives.CLAlpha*a
AeroDerivatives.CLmax         =1.62;

AeroDerivatives.CDAlpha     =0.10031;
AeroDerivatives.CDBeta      =8.0356e-06;                                    %�໬�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CDq         =0.29546;
AeroDerivatives.CDDe        =0.020779;
AeroDerivatives.CDDf        =0.031301;
AeroDerivatives.CDDr        =1.437e-05;
AeroDerivatives.CDDa        =-1.3547e-05;                                   %����ƫ�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CD0         =0.0287;
%CD0���������Ϊ15����
% a = 2.8*pi/180;
% CL = AeroDerivatives.CL0+AeroDerivatives.CLAlpha*a
% CD = AeroDerivatives.CD0+AeroDerivatives.CDAlpha*a
% CL/15-CD


AeroDerivatives.CYAlpha     =-8.85452e-14;                                  %���������巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CYBeta      =-0.25081;                                      %��������Ͳ໬�Ƕ��巽�򶼲�ͬ�����������ṩ���ݷ�����ͬ
AeroDerivatives.CYp         =-0.048446;                                     %���������巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CYr         =0.15438;                                       %���������巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CYDe        =-9.0523e-14;                                   %���������巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CYDf        =-9.8247e-14;                                   %���������巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CYDr        =0.33334;                                       %���������巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.CYDa        =0.0029468;                                     %��������͸���ƫ�Ƕ��巽�򶼲�ͬ�����������ṩ���ݷ�����ͬ

AeroDerivatives.ClAlpha     =-4.2668e-14;
AeroDerivatives.ClBeta      =-0.055654;                                     %�໬�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.Clp         =-0.5935;
AeroDerivatives.Clr         =0.03414;
AeroDerivatives.ClDe        =2.2063e-14;
AeroDerivatives.ClDf        =5.7367e-14;
AeroDerivatives.ClDr        =0.072844;
AeroDerivatives.ClDa        =-0.29533;                                      %����ƫ�Ƕ��巽��ͬ�����������ṩ���ݷ����෴

% �ڲο��㣨����ǰ�˵㣩ȡ��
% AeroDerivatives.CmAlpha     =-4.0835;
% AeroDerivatives.CmBeta      =5.2248e-06;
% AeroDerivatives.Cmq         =-25.8054;
% AeroDerivatives.CmDe        =-2.7271;
% AeroDerivatives.CmDf        =-0.35441;
% AeroDerivatives.CmDr        =1.4573e-05;
% AeroDerivatives.CmDa        =1.0717e-06;

% ���㵽���ĺ�
AeroDerivatives.CmAlpha     =-0.9014;
AeroDerivatives.CmBeta      =-5.2248e-06;                                   %�໬�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.Cmq         =-17.8879;
AeroDerivatives.CmDe        =-2.2576;
AeroDerivatives.CmDf        =0.7224;
AeroDerivatives.CmDr        =1.4573e-05;
AeroDerivatives.CmDa        =-1.0717e-06;                                    %����ƫ�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.Cm0         =0.1;
% -(-AeroDerivatives.CmDf/AeroDerivatives.CLDf+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLDf
% -(-AeroDerivatives.CmDe/AeroDerivatives.CLDe+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLDe
% -(-AeroDerivatives.CmAlpha/AeroDerivatives.CLAlpha+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLAlpha
% -(-AeroDerivatives.Cmq/AeroDerivatives.CLq+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLq



AeroDerivatives.CnAlpha     =4.5786e-14;
AeroDerivatives.CnBeta      =0.071639;                                      %�໬�Ƕ��巽��ͬ�����������ṩ���ݷ����෴
AeroDerivatives.Cnp         =-0.00051695;
AeroDerivatives.Cnr         =-0.044268;
AeroDerivatives.CnDe        =4.2143e-14;
AeroDerivatives.CnDf        =2.6444e-14;
AeroDerivatives.CnDr        =-0.10037;
AeroDerivatives.CnDa        =-0.0089298;                                     %����ƫ�Ƕ��巽��ͬ�����������ṩ���ݷ����෴


%% ��������ϵ����ӭ�ǺͲ໬�Ǳ仯������
aa=xlsread('CLalphabeta.xlsx');
AeroDerivatives.CLab.alphaset = [3,8,12];
AeroDerivatives.CLab.betaset = aa(:,1)*180/pi;
AeroDerivatives.CLab.CLset = aa(:,2:4);

%% ��������ϵ����ӭ�Ǳ仯������
aset = -3:20;
CLset = 0.10494*(aset+2);
A = 0.0556; %������������Ϊ15��CD0Ϊ0.02����ó�
CDset = 0.02+A*CLset.^2;%���ճ�����ʽ���������ı���
CDset(1:4) = [0.0376,0.03,0.0256,0.0224];%���Ƹ�ӭ������


AeroDerivatives.CDa.alphaset = aset;
AeroDerivatives.CDa.CDset = CDset;




%% ���ƹ���
% aset = -3:20;
% CLset = 0.10494*(aset+2);
% % CLset(18:24) = [1.659,1.7,1.7,1.65,1.59,1.52,1.46]; %����ʧ������
% % figure(2)
% % plot(aset,CLset)
% % CDset = 0.10031*aset;%����0.10031�Ƿɻ�������ӭ��Ϊ2.8��ʱ���߻�������������ӭ�Ǳ仯��Χ��˵���������
% % A = (0.10031*2.8*pi/180-0.02)/(0.10494*(2.8+2))^2;
% A = 0.0556;
% CDset = 0.02+A*CLset.^2;%���ճ�����ʽ���������ı������ͨ��ʹ2.8��ʱ������ϵ�������ȷ����A
% CDset(1:4) = [0.0376,0.03,0.0256,0.0224];%���Ƹ�ӭ������
% % CDset(18:24) = [0.1730,0.1807,0.1825,0.1845,0.1865,0.1895,0.1925];%����ʧ������
% 
% 
% figure(1)
% subplot(311)
% plot(aset,CLset,'LineWidth',1.5)
% hold on
% plot(aset,CDset,'LineWidth',1.5)
% legend('CL','CD')
% 
% grid on
% subplot(312)
% plot(aset,CLset./CDset,'LineWidth',1.5)
% grid on
% 
% xlabel('\alpha')
% subplot(313)
% plot(CDset,CLset,'LineWidth',1.5)
% grid on
% xlabel('CD')
% ylabel('CL')
% 
% %% ����ʧ������
% CLset(15:21) = [1.659,1.7,1.7,1.65,1.59,1.52,1.46];
% figure(2)
% plot(aset,CLset)
% 
% %%
% CDset(1:4) = [0.0376,0.03,0.0256,0.0224];
% % CDset(18:24) = [0.1730,0.1807,0.1825,0.1845,0.1865,0.1895,0.1925];
% figure(2)
% plot(aset,CDset)
% 
% 
% 
% 



end