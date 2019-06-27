function AeroDerivatives = Define_AeroDerivatives
%% 气动组提供的数据，原数据见tornadoResult.docx
%%
% 角度单位都为rad
% 由于原数据侧力，侧滑角，副翼偏角定义的正方向与常规定义相反，所以对部分原数据的符号进行更改
AeroDerivatives             = struct;
AeroDerivatives.CLAlpha     = 6.0094;
AeroDerivatives.CLBeta      = 1.0202e-06;                                   %侧滑角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CLq         = 14.9528;
AeroDerivatives.CLDe        = 0.8867;
AeroDerivatives.CLDf        = 2.0336;
AeroDerivatives.CLDr        =-3.5351e-06;
AeroDerivatives.CLDa        =2.6815e-06;                                    %副翼偏角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CL0         =0.2099*0+0.1609;
%CL0按照平衡重力的要求推算
% a = 2.8*pi/180;
% CL0=m*g/qS-AeroDerivatives.CLAlpha*a
AeroDerivatives.CLmax         =1.62;

AeroDerivatives.CDAlpha     =0.10031;
AeroDerivatives.CDBeta      =8.0356e-06;                                    %侧滑角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CDq         =0.29546;
AeroDerivatives.CDDe        =0.020779;
AeroDerivatives.CDDf        =0.031301;
AeroDerivatives.CDDr        =1.437e-05;
AeroDerivatives.CDDa        =-1.3547e-05;                                   %副翼偏角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CD0         =0.0287;
%CD0按照升阻比为15推算
% a = 2.8*pi/180;
% CL = AeroDerivatives.CL0+AeroDerivatives.CLAlpha*a
% CD = AeroDerivatives.CD0+AeroDerivatives.CDAlpha*a
% CL/15-CD


AeroDerivatives.CYAlpha     =-8.85452e-14;                                  %侧力方向定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CYBeta      =-0.25081;                                      %侧力方向和侧滑角定义方向都不同，所以与所提供数据符号相同
AeroDerivatives.CYp         =-0.048446;                                     %侧力方向定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CYr         =0.15438;                                       %侧力方向定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CYDe        =-9.0523e-14;                                   %侧力方向定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CYDf        =-9.8247e-14;                                   %侧力方向定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CYDr        =0.33334;                                       %侧力方向定义方向不同，所以与所提供数据符号相反
AeroDerivatives.CYDa        =0.0029468;                                     %侧力方向和副翼偏角定义方向都不同，所以与所提供数据符号相同

AeroDerivatives.ClAlpha     =-4.2668e-14;
AeroDerivatives.ClBeta      =-0.055654;                                     %侧滑角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.Clp         =-0.5935;
AeroDerivatives.Clr         =0.03414;
AeroDerivatives.ClDe        =2.2063e-14;
AeroDerivatives.ClDf        =5.7367e-14;
AeroDerivatives.ClDr        =0.072844;
AeroDerivatives.ClDa        =-0.29533;                                      %副翼偏角定义方向不同，所以与所提供数据符号相反

% 在参考点（翼根前端点）取矩
% AeroDerivatives.CmAlpha     =-4.0835;
% AeroDerivatives.CmBeta      =5.2248e-06;
% AeroDerivatives.Cmq         =-25.8054;
% AeroDerivatives.CmDe        =-2.7271;
% AeroDerivatives.CmDf        =-0.35441;
% AeroDerivatives.CmDr        =1.4573e-05;
% AeroDerivatives.CmDa        =1.0717e-06;

% 折算到重心后
AeroDerivatives.CmAlpha     =-0.9014;
AeroDerivatives.CmBeta      =-5.2248e-06;                                   %侧滑角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.Cmq         =-17.8879;
AeroDerivatives.CmDe        =-2.2576;
AeroDerivatives.CmDf        =0.7224;
AeroDerivatives.CmDr        =1.4573e-05;
AeroDerivatives.CmDa        =-1.0717e-06;                                    %副翼偏角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.Cm0         =0.1;
% -(-AeroDerivatives.CmDf/AeroDerivatives.CLDf+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLDf
% -(-AeroDerivatives.CmDe/AeroDerivatives.CLDe+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLDe
% -(-AeroDerivatives.CmAlpha/AeroDerivatives.CLAlpha+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLAlpha
% -(-AeroDerivatives.Cmq/AeroDerivatives.CLq+(3.4903-4.0593)/Configuration.c)*AeroDerivatives.CLq



AeroDerivatives.CnAlpha     =4.5786e-14;
AeroDerivatives.CnBeta      =0.071639;                                      %侧滑角定义方向不同，所以与所提供数据符号相反
AeroDerivatives.Cnp         =-0.00051695;
AeroDerivatives.Cnr         =-0.044268;
AeroDerivatives.CnDe        =4.2143e-14;
AeroDerivatives.CnDf        =2.6444e-14;
AeroDerivatives.CnDr        =-0.10037;
AeroDerivatives.CnDa        =-0.0089298;                                     %副翼偏角定义方向不同，所以与所提供数据符号相反


%% 更新升力系数随迎角和侧滑角变化的数据
aa=xlsread('CLalphabeta.xlsx');
AeroDerivatives.CLab.alphaset = [3,8,12];
AeroDerivatives.CLab.betaset = aa(:,1)*180/pi;
AeroDerivatives.CLab.CLset = aa(:,2:4);

%% 估计阻力系数随迎角变化的数据
aset = -3:20;
CLset = 0.10494*(aset+2);
A = 0.0556; %根据最大升阻比为15，CD0为0.02估算得出
CDset = 0.02+A*CLset.^2;%按照常见公式给出阻力的表达
CDset(1:4) = [0.0376,0.03,0.0256,0.0224];%估计负迎角特性


AeroDerivatives.CDa.alphaset = aset;
AeroDerivatives.CDa.CDset = CDset;




%% 估计过程
% aset = -3:20;
% CLset = 0.10494*(aset+2);
% % CLset(18:24) = [1.659,1.7,1.7,1.65,1.59,1.52,1.46]; %估计失速特性
% % figure(2)
% % plot(aset,CLset)
% % CDset = 0.10031*aset;%由于0.10031是飞机阻力在迎角为2.8度时的线化气动导数，当迎角变化范围大此导数不适用
% % A = (0.10031*2.8*pi/180-0.02)/(0.10494*(2.8+2))^2;
% A = 0.0556;
% CDset = 0.02+A*CLset.^2;%按照常见公式给出阻力的表达，其中通过使2.8度时两阻力系数相等来确定出A
% CDset(1:4) = [0.0376,0.03,0.0256,0.0224];%估计负迎角特性
% % CDset(18:24) = [0.1730,0.1807,0.1825,0.1845,0.1865,0.1895,0.1925];%估计失速特性
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
% %% 估计失速特性
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