function Engine = Define_Engine
%% 推力模型数据初步估计
%假设推重比为0.25，根据重量800kg可得海平面最大静推力为1961.3N
Ratio_TW=0.25;
g = evalin('base','g');
Configuration = evalin('base','Configuration');
Tmax=Ratio_TW*g*Configuration.Mass;
SFCmax=0;

%%
%由于缺少发动机数据，因此初步仿真采用线性推力模型
Engine              = struct;
Engine.Ratio_TW     = Ratio_TW;
Engine.Tmax         = Tmax;
Engine.SFCmax       = SFCmax;
Engine.Thrset       = linspace(0,100,5);
Engine.Tset         = linspace(0,Tmax,5);
Engine.SFCset       = linspace(0,SFCmax,5);
Engine.Position     = [7.5,0,0]'; %距离机头[m]
Engine.Phi          = 0; %安装角[rad]

end