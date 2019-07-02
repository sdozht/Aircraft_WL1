function Configuration = Define_Configuration 
Configuration               = struct;
Configuration.Mass          = 800;                                          %kg
Configuration.Ixx           = 1285.448;                                     %kg*m^2 ͬ�����ɻ�Cessna-172�Ĺ�������
Configuration.Iyy           = 1825.176;                                     %kg*m^2 ͬ�����ɻ�Cessna-172�Ĺ�������
Configuration.Izz           = 2667.252;                                     %kg*m^2 ͬ�����ɻ�Cessna-172�Ĺ�������
Configuration.Ixz           = 0;                                            %kg*m^2 ͬ�����ɻ�Cessna-172�Ĺ�������
Configuration.Inertia_G_B   = [Configuration.Ixx,0,Configuration.Ixz;...
                               0,       Configuration.Iyy,       0;...
                               Configuration.Ixz,0,Configuration.Izz];
% Configuration.Inertia_G_B   = [1503.3,0,0;...
%                                0,1718.9,0;...
%                                0,0,3169.5];                               %���ݷɻ�����ֲ��й�ʽ����õ�,���̼���ĩ��¼1

Configuration.c             = 1.0746;                                       %m
Configuration.b             = 12;                                           %m
Configuration.S             = 12.4387;                                      %m^2
Configuration.ks            = 0.15;                                         %   ��ƾ��ȶ�ԣ��Ϊ15%
Configuration.POS_AC        = [4.2205,0,0]';                                %m  �����ͷ
Configuration.POS_CGRef     = ...
        [-Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';   %m
Configuration.POS_R2G       = [0*Configuration.c,0,0]';                     %m
Configuration.POS_CG        = ...
                            Configuration.POS_CGRef+Configuration.POS_R2G;  %m  Ϊ���ڵ������������ӿ�

end

%% ��¼1
%%% ת�������Ĺ������
% method 1
% phixp = 0.2*2/3;
% phiyp = 0.2/3;
% phizp = phiyp;
% WTO = 800;
% b = 12;
% lf = 7.8329;

% Ixp = WTO*b^2*phixp/12;
% Iyp = WTO*lf^2*phiyp/12;
% Izp = WTO*(b^2+lf^2)*phizp/12;
% Inertia_G_B = diag([Ixp;Iyp;Izp]);

% method 2 (ò�Ƹ�����һ��)
% WTO = 800;
% b = 12;
% lf = 7.8329;
% Hmf = 1.0435; %0.35*12/4.025    
% 
% Ixp = WTO*(b^2/78+Hmf^2/33);
% Iyp = WTO*(lf^2/29+Hmf^2/33);
% Izp = WTO*(lf^2/29+b^2/78);
% Inertia_G_B = diag([Ixp;Iyp;Izp]);
