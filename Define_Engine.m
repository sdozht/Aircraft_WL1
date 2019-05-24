function Engine = Define_Engine
%% ����ģ�����ݳ�������
%�������ر�Ϊ0.25����������800kg�ɵú�ƽ���������Ϊ1961.3N
Ratio_TW=0.25;
g = evalin('base','g');
Configuration = evalin('base','Configuration');
Tmax=Ratio_TW*g*Configuration.Mass;
SFCmax=0;

%%
%����ȱ�ٷ��������ݣ���˳������������������ģ��
Engine              = struct;
Engine.Ratio_TW     = Ratio_TW;
Engine.Tmax         = Tmax;
Engine.SFCmax       = SFCmax;
Engine.Thrset       = linspace(0,100,5);
Engine.Tset         = linspace(0,Tmax,5);
Engine.SFCset       = linspace(0,SFCmax,5);
Engine.Position     = [7.5,0,0]'; %�����ͷ[m]
Engine.Phi          = 0; %��װ��[rad]

end