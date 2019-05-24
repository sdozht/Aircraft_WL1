function Configuration = Define_Configuration 
%%Դ������ʦ��������,�����WL1data_from_Mr_Tang.docx�Ϳ���ppt
Configuration               = struct;
Configuration.Mass          = 800;
Configuration.Mass_empty    = 0.8*800;%����ȼ������ռ���������20%
Configuration.Inertia_G_B   = [1503.3,0,0;...
                               0,1718.9,0;...
                               0,0,3169.5]; %���ݷɻ�����ֲ��й�ʽ����õ��������Define_Configuration_old.m��Origindata_of_Modeling.docx
Configuration.c             = 1.048; %��b0,b1ͼ�ⷨ���
Configuration.b             = 12;
Configuration.S             = 12;
Configuration.ks            = 0.15; %��ƾ��ȶ�ԣ��Ϊ15%
Configuration.POS_AC        = [4.335,0,0]'; %�����ͷ
Configuration.POS_CGRef     = [Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';
Configuration.POS_CG        = [Configuration.POS_CGRef(1)+0*Configuration.c,0,0]';%Ϊ���ڵ������������ӿ�

end


