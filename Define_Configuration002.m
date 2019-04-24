function Configuration = Define_Configuration 
%%源于唐老师给的数据,具体见WL1data_from_Mr_Tang.docx和课堂ppt
Configuration               = struct;
Configuration.Mass          = 800;
Configuration.Mass_empty    = 0.8*800;%假设燃油重量占起飞重量的20%
Configuration.Inertia_G_B   = [1503.3,0,0;...
                               0,1718.9,0;...
                               0,0,3169.5]; %根据飞机设计手册中公式估算得到，具体见Define_Configuration_old.m和Origindata_of_Modeling.docx
Configuration.c             = 1.048; %由b0,b1图解法获得
Configuration.b             = 12;
Configuration.S             = 12;
Configuration.ks            = 0.15; %设计静稳定裕度为15%
Configuration.POS_AC        = [4.335,0,0]'; %距离机头
Configuration.POS_CGRef     = [Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';
Configuration.POS_CG        = [Configuration.POS_CGRef(1)+0*Configuration.c,0,0]';%为后期调整重心留出接口

end


