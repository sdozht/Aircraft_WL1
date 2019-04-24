function Configuration = Define_Configuration 
%%源于气动组提供数据,具体见tornadoResult.docx
Configuration               = struct;
Configuration.Mass          = 800;
Configuration.Mass_empty    = 0.7*800;%假设燃油重量占起飞重量的30%
Configuration.Inertia_G_B   = [1503.3,0,0;...
                               0,1718.9,0;...
                               0,0,3169.5]; %根据飞机设计手册中公式估算得到，具体见Define_Configuration001.m和Origindata_of_Modeling.docx
Configuration.c             = 1.0746;
Configuration.b             = 12;
Configuration.S             = 12.4387;
Configuration.ks            = 0.15; %设计静稳定裕度为15%
Configuration.POS_AC        = [3.759,0,0]'; %距离机头
Configuration.POS_CGRef     = [-Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';
Configuration.POS_R2G       = [0*Configuration.c,0,0]';
Configuration.POS_CG        = Configuration.POS_CGRef+Configuration.POS_R2G;%为后期调整重心留出接口

end


