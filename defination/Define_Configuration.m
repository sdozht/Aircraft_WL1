function Configuration = Define_Configuration 
Configuration               = struct;
Configuration.Mass          = 800;                                          %kg
Configuration.Ixx           = 1285.448;                                     %kg*m^2 同量级飞机Cessna-172的惯量数据
Configuration.Iyy           = 1825.176;                                     %kg*m^2 同量级飞机Cessna-172的惯量数据
Configuration.Izz           = 2667.252;                                     %kg*m^2 同量级飞机Cessna-172的惯量数据
Configuration.Ixz           = 0;                                            %kg*m^2 同量级飞机Cessna-172的惯量数据
Configuration.Inertia_G_B   = [Configuration.Ixx,0,Configuration.Ixz;...
                               0,       Configuration.Iyy,       0;...
                               Configuration.Ixz,0,Configuration.Izz];
% Configuration.Inertia_G_B   = [1503.3,0,0;...
%                                0,1718.9,0;...
%                                0,0,3169.5];                               %根据飞机设计手册中公式估算得到,过程见文末附录1

Configuration.c             = 1.0746;                                       %m
Configuration.b             = 12;                                           %m
Configuration.S             = 12.4387;                                      %m^2
Configuration.ks            = 0.15;                                         %   设计静稳定裕度为15%
Configuration.POS_AC        = [4.2205,0,0]';                                %m  距离机头
Configuration.POS_CGRef     = ...
        [-Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';   %m
Configuration.POS_R2G       = [0*Configuration.c,0,0]';                     %m
Configuration.POS_CG        = ...
                            Configuration.POS_CGRef+Configuration.POS_R2G;  %m  为后期调整重心留出接口

end

%% 附录1
%%% 转动惯量的估算过程
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

% method 2 (貌似更合理一点)
% WTO = 800;
% b = 12;
% lf = 7.8329;
% Hmf = 1.0435; %0.35*12/4.025    
% 
% Ixp = WTO*(b^2/78+Hmf^2/33);
% Iyp = WTO*(lf^2/29+Hmf^2/33);
% Izp = WTO*(lf^2/29+b^2/78);
% Inertia_G_B = diag([Ixp;Iyp;Izp]);
