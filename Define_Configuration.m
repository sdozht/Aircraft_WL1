function Configuration = Define_Configuration 
%%Դ���������ṩ����,�����tornadoResult.docx
Configuration               = struct;
Configuration.Mass          = 800;
Configuration.Mass_empty    = 0.7*800;%����ȼ������ռ���������30%
Configuration.Inertia_G_B   = [1503.3,0,0;...
                               0,1718.9,0;...
                               0,0,3169.5]; %���ݷɻ�����ֲ��й�ʽ����õ��������Define_Configuration001.m��Origindata_of_Modeling.docx
Configuration.c             = 1.0746;
Configuration.b             = 12;
Configuration.S             = 12.4387;
Configuration.ks            = 0.15; %��ƾ��ȶ�ԣ��Ϊ15%
Configuration.POS_AC        = [3.759,0,0]'; %�����ͷ
Configuration.POS_CGRef     = [-Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';
Configuration.POS_R2G       = [0*Configuration.c,0,0]';
Configuration.POS_CG        = Configuration.POS_CGRef+Configuration.POS_R2G;%Ϊ���ڵ������������ӿ�

end


