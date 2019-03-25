function Configuration = Define_Configuration
lamda       = 12;
S           = 12;
b           = 12;
ratio_c1c0  = 0.45;
c0          = 2*b/lamda/(1+ratio_c1c0);
c1          = ratio_c1c0*c0;
c_bar_ref   = 1.048; %��b0,b1ͼ�ⷨ���
POS_AC      = [4.335,0,0]'; %�����ͷ
ks          = 0.15;
POS_CGRef   = [ks*c_bar_ref+POS_AC(1),0,0]';
POS_CG      = [POS_CGRef(1)+0*c_bar_ref,0,0]';



%% ת����������
% method 1
% phixp = 0.2*2/3;
% phiyp = 0.2/3;
% phizp = phiyp;
% WTO = 800;
% b = 12;
% lf = 7.8329; %2.6273*12/4.025
% %������������ݲ��ԣ�����������չ��4.025m������ʦ�����ĵ�����չ��12m����˶��������õ����ݳ���12/4.025
% 
% 
% Ixp = WTO*b^2*phixp/12;
% Iyp = WTO*lf^2*phiyp/12;
% Izp = WTO*(b^2+lf^2)*phizp/12;
% Inertia_G_B = diag([Ixp;Iyp;Izp]);

% method 2 (ò�Ƹ�����һ��)
WTO = 800;
b = 12;
lf = 7.8329;
Hmf = 1.0435; %0.35*12/4.025    

Ixp = WTO*(b^2/78+Hmf^2/33);
Iyp = WTO*(lf^2/29+Hmf^2/33);
Izp = WTO*(lf^2/29+b^2/78);
Inertia_G_B = diag([Ixp;Iyp;Izp]);

Configuration               = struct;
Configuration.Mass          = WTO;
Configuration.Mass_empty    = 0.8*WTO;
Configuration.Inertia_G_B   = Inertia_G_B;
Configuration.c             = c_bar_ref;
Configuration.b             = b;
Configuration.S             = S;
Configuration.POS_CGRef     = POS_CGRef;
Configuration.POS_CG        = POS_CG;
Configuration.POS_AC        = POS_AC;
end


