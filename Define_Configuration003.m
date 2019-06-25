function Configuration = Define_Configuration 
%%Դ���������ṩ����,�����tornadoResult.docx
Configuration               = struct;
Configuration.Mass          = 800;
Configuration.Mass_Constr   = 0.7*800;%����ȼ������ռ���������30%
Configuration.Mass_Fuel     = 0.3*800;%����ȼ������ռ���������30%
Configuration.Inertia_G_B   = [1503.3,0,0;...
                               0,1718.9,0;...
                               0,0,3169.5]; %���ݷɻ�����ֲ��й�ʽ����õ��������Define_Configuration001.m��Origindata_of_Modeling.docx
Configuration.c             = 1.0746;
Configuration.b             = 12;
Configuration.S             = 12.4387;
Configuration.ks            = 0.15; %��ƾ��ȶ�ԣ��Ϊ15%
Configuration.POS_AC        = [4.2205,0,0]'; %�����ͷ
Configuration.POS_CGRef     = [-Configuration.ks*Configuration.c+Configuration.POS_AC(1),0,0]';
Configuration.POS_R2G       = [0*Configuration.c,0,0]';
Configuration.POS_CG        = Configuration.POS_CGRef+Configuration.POS_R2G;%Ϊ���ڵ������������ӿ�

c0                          = 1.3793;
c1                          = 0.6207;
b                           = Configuration.b;
Configuration.POS_Fuel      = [3.4903+1.3793-0.5*(2*c1+c0)*b/2/3/(c0+c1),0,0]'; %����ǰ�˵�λ��+����ҳ�-���λ���������λ�õ�һ��
Configuration.POS_Constr    =...
    Configuration.POS_CG-(Configuration.POS_Fuel-Configuration.POS_CG)*0.7;%xcg-(xfuel-xcg)*mfuel/mcons
end


