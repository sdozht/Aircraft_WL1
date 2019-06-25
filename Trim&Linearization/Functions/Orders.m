%Description: Reorder input state output vector
%It's a sub function of SelectVector
%% 对状态方程中变量次序进行调整
%% 输入：原状态方程 AllModel、新的状态量次序 OrdS、新的输入量次序 OrdI、新的输出量排列次序 OrdO、状态变量个数 N、输入量个数 P、输出量个数 Q
%% 输出：为调整次序后的矩阵 [A,B,C,D]
function [A,B,C,D]=Orders(AllModel,OrdS,OrdI,OrdO,N,P,Q)
A=zeros(N,N);
Temp=zeros(N,N);
for i=1:N
    Temp(i,:)=AllModel.A(OrdS(1,i),:);
end

for i=1:N
    A(:, i)=Temp(:,OrdS(1,i));
end

for i=1:N
    for j=1:N
        if abs(A(i,j))<=1e-8
            A(i,j)=0;
        end
    end
end

B=zeros(N,P);
Temp=zeros(N,P);
for i=1:N
    Temp(i,:)=AllModel.B(OrdS(1,i),:);
end

for i=1:P
    B(:,i)=Temp(:,OrdI(1,i));
end

for i=1:N
    for j=1:P
        if abs(B(i,j))<=1e-8
            B(i,j)=0;
        end
    end
end

C=zeros(Q,N);
Temp=zeros(Q,N);
for i=1:Q
    Temp(i,:)=AllModel.C(OrdO(1,i),:);
end

for i=1:N
    C(:, i)=Temp(:,OrdS(1,i)); 
end

for i=1:Q
    for j=1:N
        if abs(C(i,j))<=1e-8
            C(i,j)=0;
        end
    end
end

D=zeros(Q,P);
Temp=zeros(Q,P);
for i=1:Q
    Temp(i,:)=AllModel.D(OrdO(1,i),:);
end

for i=1:P
    D(:,i)=Temp(:,OrdI(1,i));
end

for i=1:Q
    for j=1:P
        if abs(D(i,j))<=1e-8
            D(i,j)=0;
        end
    end
end

%%
% clear AllModel OrdS OrdO N P Q Temp i j;

end