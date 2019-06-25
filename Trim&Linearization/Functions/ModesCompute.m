%> - Description: function to calculate modes characteristic
%% Input State A
%% Output  特征向量矩阵 V、特征根 S、倍/半幅时 T2、无阻尼振荡频率 Wn、阻尼比 KS
function Mode=ModesCompute(StateA)

%%
[V,S] = eig(StateA);                                                       % V为特征向量矩阵，S特征根
Mode.V=V;
SizeA=size(S);
ROW=SizeA(1,1);
Rpart=zeros(1,ROW);
Ipart=zeros(1,ROW);
Mode.S=zeros(1,ROW);
Mode.T2=zeros(1,ROW);
Mode.Wn=zeros(1,ROW);
Mode.KS=zeros(1,ROW);
for i=1:ROW
    Mode.S(i)=S(i,i);
    Rpart(i)=real(S(i,i));
    Ipart(i)=imag(S(i,i));
    
    if abs(Rpart(i))<1e-9                                                  % 避免0除。
        if Rpart(i)>=0
            Mode.T2(i)=Inf;
        else
            Mode.T2(i)=-Inf;
        end        
    else
        Mode.T2(i)=log(2)/Rpart(i);                                        % T2大于0为倍幅时，小于0为半幅时
    end
    
        Mode.Wn(i)=sqrt(Rpart(i)^2+Ipart(i)^2);                            % 无阻尼振荡频率
    if Mode.Wn(i)<1e-9
        Mode.Wn(i)=1e-9;                                                   % 避免0除。
    end
    
    Mode.KS(i)=-Rpart(i)/Mode.Wn(i);                                       % 阻尼比
    
end

%%
clear StateA V S SizeA ROW Rpart Ipart i
end