function Configuration = Define_Configuration 
%%源于气动组提供数据,具体见tornadoResult.docx
Configuration               = struct;
Configuration.Mass          = 800;
Configuration.Mass_Constr   = 0.7*800;%假设燃油重量占起飞重量的30%
Configuration.Mass_Fuel     = 0.3*800;%假设燃油重量占起飞重量的30%
Configuration.Inertia_G_B   = [1503.3,0,0;...
                               0,1718.9,0;...
                               0,0,3169.5]; %根据飞机设计手册中公式估算得到，具体见Define_Configuration001.m和Origindata_of_Modeling.docx
Configuration.c             = 1.0746;
Configuration.b             = 12;
Configuration.S             = 12.4387;
Configuration.ks            = 0.15; %设计静稳定裕度为15%
Configuration.POS_AC        = [4.2205,0,0]'; %距离机头
Configuration.POS_CGRef     = [-Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';
Configuration.POS_R2G       = [0*Configuration.c,0,0]';
Configuration.POS_CG        = Configuration.POS_CGRef+Configuration.POS_R2G;%为后期调整重心留出接口

c0                          = 1.3793;
c1                          = 0.6207;
b                           = Configuration.b;
Configuration.POS_Fuel      = [3.4903+1.3793-0.5*(2*c1+c0)*b/2/3/(c0+c1),0,0]'; %机翼前端点位置+翼根弦长-梯形机翼几何重心位置的一半
Configuration.POS_Constr    =...
    Configuration.POS_CG-(Configuration.POS_Fuel-Configuration.POS_CG)*0.7;%xcg-(xfuel-xcg)*mfuel/mcons
end


