%> - Description: function to calculate modes characteristic
%% Input State A
%% Output  ������������ V�������� S����/���ʱ T2����������Ƶ�� Wn������� KS
function Mode=ModesCompute(StateA)

%%
[V,S] = eig(StateA);                                                       % VΪ������������S������
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
    
    if abs(Rpart(i))<1e-9                                                  % ����0����
        if Rpart(i)>=0
            Mode.T2(i)=Inf;
        else
            Mode.T2(i)=-Inf;
        end        
    else
        Mode.T2(i)=log(2)/Rpart(i);                                        % T2����0Ϊ����ʱ��С��0Ϊ���ʱ
    end
    
        Mode.Wn(i)=sqrt(Rpart(i)^2+Ipart(i)^2);                            % ��������Ƶ��
    if Mode.Wn(i)<1e-9
        Mode.Wn(i)=1e-9;                                                   % ����0����
    end
    
    Mode.KS(i)=-Rpart(i)/Mode.Wn(i);                                       % �����
    
end

%%
clear StateA V S SizeA ROW Rpart Ipart i
end