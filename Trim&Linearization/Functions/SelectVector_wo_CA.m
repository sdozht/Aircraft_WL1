%%%%%%%%%%%%%%%% 用途
%
% 本函数用于得到线化模型的纵向、横航向不同形式，被Linearize_BeihangModel_without_CA调用
%
%%%%%%%%%%%%%%%% 日志
%
% 2017-11-30 - JUHAN - Initial Draft - V0.1
%
%%%%%%%%%%%%%%%% 输入输出
%
%   Inputs: opreport,线化sys(AllModel)
%   Output: LinedMod_wo_CA，包含各种形式的A,B,C,D阵                         (wo:without)
%
function LinedMod_wo_CA=SelectVector(AllModel,Opreport)
g         = evalin('base','g');
Actuators = evalin('base', 'Actuators');
% N*1 states，P*1 inputs，Q*1 outputs：A=N*N，B=N*P，C=Q*N，D=Q*P
% N States:[ u   v    w   p q  r  phi theta psi xNorth x_East Altitude]
%            1   2    3   4 5  6  7   8     9   10       11      12 
% P Inputs:[DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3 uw vw ww pw qw rw]
%           1     2     3   4      5     6   7   8     9     10    11    12    13    14 15 16 17 18 19     
%            
% Q Outputs:[p q r phi theta psi  Alpha_A_R_E_B Beta_A_R_E_B VEL_K_G_E_ABS nxG_B nyG_B nzG_B Gamma_K Chi_K Alpha_K_G_E_B Beta_K_G_E_B Xedot Yedot -Hdot  Xe Ye H  nzS_B nyS_B VEL_A_R_E_ABS]
%            1 2 3  4    5    6         7             8             9       10    11     12    13    14         15            16       17    18    19    20 21 22  23    24        25
% About nxG_B nyG_B nzG_B: They are from Load_Factor_G_B .It's at gravity point of body frame.(z axis already products -1 to get positive sign)
%                          nxG_B = axG_B/g+sin(theta)
%                          nyG_B = ayG_B/g-sin(phi)*cos(theta)
%                          nzG_B = -azG_B/g+cos(phi)*cos(theta)            (fly up is positive,when in level flght condition it's close to 1)
% About nxS_B nyS_B nzS_B: It's at sensor's position in body frame z axis
%                          load factor (z axis already products -1), assume sensor is located dx front of gravity point in body frame 
%                          ayS_B ≈ vdot + u*r - w*p + rdot*dx
%                          nyS_B = ayS_B/g-sin(phi)*cos(theta)
%                          azS_B ≈ wdot - u*q - qdot*dx
%                          nzS_B = -azS_B/g+cos(phi)*cos(theta)            (fly up is positive,when in level flght condition it's close to 1)  more details：Aircraft control ans simuliation;P309


N=12;P=19;Q=25;                                                            % Unchoose Chi_K, when linearization by pertubation,it can from 0 suddenly to 2*pi,linearization result of Chi_K will be weird
OrdS=[1 3 5 8 12 4 7 2 6 11 9 10];
%new state order: [u w q Theta H p Phi v r Ye Psi Xe]
%                  1 2 3    4  5 6  7  8 9 10  11 12

OrdI=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 16 18 15 17 19];
%new input order: [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  uwind wind qwind vwind pwind rwind]
%                  1     2     3   4      5     6   7   8     9     10    11    12    13     14    15   16    17    18    19
%                  rad                                  [0~1]                                [m/s]      [rad/s]                        
OrdO=[2 7 15 5 13 10 12 23 9 25 19 22 1 4 3 8 16 11 24 21 6 18 17 20 14];          
% new output order:[q Alpha_A_R_E_B Alpha_K_G_E_B theta gamma_K_G_E_0 nxG_B nzG_B nzS_B VEL_K_G_E_ABS VEL_A_R_E_ABS  -Hdot H  p   phi  r  Beta_A_R_E_B Beta_K_G_E_B  nyG_B nyS_B  Ye Psi Yedot Xedot Xe Chi_K]
%                   1      2             3          4         5        6    7     8           9             10        11  12 13    14 15       16           17        18    19    20 21   22    23   24  25
[A,B,C,D]=Orders(AllModel,OrdS,OrdI,OrdO,N,P,Q); 

TM_Inputunit =eye(19);
TM_Inputunit(8,8) = 1/100;                                                 % Transfer Unit of input Dth from [0~1] to %
TM_Inputunit(9,9) = 1/100;
TM_Inputunit(10,10) = 1/100;
TM_Inputunit(11,11) = 1/100;
TM_Inputunit(12,12) = 1/100;
TM_Inputunit(13,13) = 1/100;

B = B*TM_Inputunit;
D = D*TM_Inputunit;
%new input unit : [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  uwind wind qwind vwind pwind rwind]
%                  1     2     3   4      5     6   7   8     9     10    11    12    13     14    15   16    17    18    19
%                  [rad]                                [%]                                  [m/s]      [rad/s]    


%% Whole model PRY form
LinedMod_wo_CA.PRY.A=A(1:12,1:12);                                               % Pitch Roll and Yaw,PRY                                                     
LinedMod_wo_CA.PRY.B=B(1:12,1:19);
LinedMod_wo_CA.PRY.C=C(1:24,1:12);                                               % Unchoose Chi_K, when linearization by pertubation,it can from 0 suddenly to 2*pi,linearization result of Chi_K will be weird
LinedMod_wo_CA.PRY.D=D(1:24,1:19); 

%State: [u w q Theta H p Phi v r Ye Psi Xe]'    [SI Unit]
%        1 2 3    4  5 6  7  8 9 10  11 12

%Input: [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  uwind wind qwind vwind pwind rwind]
%        1     2     3   4      5     6   7   8     9     10    11    12    13     14    15   16    17    18    19
%        [rad]                                [%]                                  [m/s]      [rad/s] 

%Output:[q Alpha_A_R_E_B Alpha_K_G_E_B theta gamma_K_G_E_0 nxG_B nzG_B nzS_B VEL_K_G_E_ABS VEL_A_R_E_ABS  -Hdot H  p   phi  r  Beta_A_R_E_B Beta_K_G_E_B  nyG_B nyS_B  Ye Psi Yedot Xedot Xe]'
%        1      2             3          4         5        6    7     8           9             10        11  12 13   14  15       16           17        18    19    20 21   22    23   24

%% Longitude Pitch axis 俯仰P通道
%% P1 Form 
%State: [u w q theta H]'
%Input: [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]'
%        1     2     3   4      5     6   7   8     9     10    11    12    13
%        rad                                  %                             
%Output:[q Alpha_A_R_E_B Alpha_K_G_E_B theta gamma_K_G_E_0 nxG_B nzG_B nzS_B VEL_K_G_E_ABS VEL_A_R_E_ABS  -Hdot H]'
%        1      2             3          4         5        6    7     8           9             10        11  12 
LinedMod_wo_CA.P1.A=A(1:5,1:5);                                                
LinedMod_wo_CA.P1.B=B(1:5,1:13);
LinedMod_wo_CA.P1.C=C(1:12,1:5);
LinedMod_wo_CA.P1.D=D(1:12,1:13);

%% P2 Form 
%State： [u;w;q;theta]'
%Input: [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]'
%        1     2     3   4      5     6   7   8     9     10    11    12    13    
%        rad                                  %                                
%Output：[u;w;q;theta]'
LinedMod_wo_CA.P2.A=LinedMod_wo_CA.P1.A(1:4,1:4);                                                
LinedMod_wo_CA.P2.B=LinedMod_wo_CA.P1.B(1:4,1:13);
LinedMod_wo_CA.P2.C=eye(4);
LinedMod_wo_CA.P2.D=zeros(4,13);


%% P3 Form 
%State： [VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]'
%         1     2     3   4      5     6   7   8     9     10    11    12    13
%         rad                                  %                         
%Output：[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]

%get transform matrix
utrim=Opreport.States(10).x;
vtrim=Opreport.States(11).x;
wtrim=Opreport.States(12).x;
Vtrim=sqrt(utrim^2+vtrim^2+wtrim^2);
% delta[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]=T1*delta[u;w;q;theta]
T1=[   utrim/Vtrim                 wtrim/Vtrim       0 0;
     -wtrim/(Vtrim^2)            utrim/(Vtrim^2)     0 0;
            0                          0             1 0;
            0                          0             0 1];
LinedMod_wo_CA.P3.A=T1*LinedMod_wo_CA.P2.A/T1;                                                
LinedMod_wo_CA.P3.B=T1*LinedMod_wo_CA.P2.B;
LinedMod_wo_CA.P3.C=eye(4);
LinedMod_wo_CA.P3.D=zeros(4,13);

%% Pw Form
% Pw1
% State： delta[u;w;q;theta]
% Input: [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  uwind wind qwind]
%         1     2     3   4      5     6   7   8     9     10    11    12    13     14    15   16   
%         rad                                  %                                    [m/s]      [rad/s] 
% Output：delta[u;w;q;theta]
LinedMod_wo_CA.Pw1.A = LinedMod_wo_CA.PRY.A(1:4,1:4);                                                
LinedMod_wo_CA.Pw1.B = LinedMod_wo_CA.PRY.B(1:4,1:16);
LinedMod_wo_CA.Pw1.C = eye(4);
LinedMod_wo_CA.Pw1.D = zeros(4,16); 

% Pw2
% State：delta[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]
% Input: [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  uwind wind qwind]
%         1     2     3   4      5     6   7   8     9     10    11    12    13     14    15   16   
%         rad                                  %                                    [m/s]      [rad/s] 
% Output：delta[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]

LinedMod_wo_CA.Pw2.A=T1*LinedMod_wo_CA.Pw1.A/T1;                                                
LinedMod_wo_CA.Pw2.B=T1*LinedMod_wo_CA.Pw1.B;
LinedMod_wo_CA.Pw2.C=eye(4);
LinedMod_wo_CA.Pw2.D=zeros(4,16);

%% Pnz Form 
% temp form
%State： [u;w;q;theta]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]
%         1     2     3   4      5     6   7   8     9     10    11    12    13      
%         rad                                  %                              
%Output：[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzG_B;nzS_B]
L.A=A(1:4,1:4);                                                
L.B=B(1:4,1:13);
L.C=C([1,3,4,9,7,8],1:4);
L.D=D([1,3,4,9,7,8],1:13);

N=4;P=13;Q=6;
OrdS=[1 2 3 4];
OrdI=[1 2 3 4 5 6 7 8 9 10 11 12 13];
OrdO=[4 2 1 3 5 6];

[Atemp,Btemp,Ctemp,Dtemp]=Orders(L,OrdS,OrdI,OrdO,N,P,Q);

% final form
%State： [VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta]
%Input： [DE; Dth]
%         rad %
%Output：[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzG_B;nzS_B]
LinedMod_wo_CA.Pnz.A=T1*Atemp/T1;                                                
LinedMod_wo_CA.Pnz.B=T1*Btemp;
LinedMod_wo_CA.Pnz.C=Ctemp/T1;
LinedMod_wo_CA.Pnz.C(1:4,1:4)=eye(4);
LinedMod_wo_CA.Pnz.D=Dtemp;
%% Pnzw Form
% temp form
%State： [u;w;q;theta]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  uwind wind qwind]
%         1     2     3   4      5     6   7   8     9     10    11    12    13     14    15   16   
%         rad                                  %                                    [m/s]      [rad/s] 
%Output：[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzG_B;nzS_B;VEL_A_R_E_ABS;Alpha_A_R_E_B]
Atemp=A(1:4,1:4);                                                
Btemp=B(1:4,1:16);
Ctemp=C([9,3,1,4,7,8,10,2],1:4);
Dtemp=D([9,3,1,4,7,8,10,2],1:16);

% final form
%State： [VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  uwind wind qwind]
%         1     2     3   4      5     6   7   8     9     10    11    12    13     14    15   16   
%         rad                                  %                                    [m/s]      [rad/s] 
%Output：[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzG_B;nzS_B;VEL_A_R_E_ABS;Alpha_A_R_E_B]
LinedMod_wo_CA.Pnzw.A=T1*Atemp/T1;                                                
LinedMod_wo_CA.Pnzw.B=T1*Btemp;
LinedMod_wo_CA.Pnzw.C=Ctemp/T1;
LinedMod_wo_CA.Pnzw.C(1:4,1:4)=eye(4);                                     % Don't comment this at first time, should check are other terms small first. then make sure other terms can be set to zeros. 
LinedMod_wo_CA.Pnzw.D=Dtemp;

%% P4 Form 
%State： [1/Vtrim*VEL_K_G_E_ABS;Gamma_K_G_E_0;Alpha_K_G_E_B;q]'
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]'
%        1     2     3   4      5     6   7   8     9     10    11    12    13
%        rad                                  % 
%Output：[1/Vtrim*VEL_K_G_E_ABS;Gamma_K_G_E_0;Alpha_K_G_E_B;q]'

%get transform matrix
% delta[Vstar;gamma;alpha_K;q]=T2*delta[V_K_ABS;alpha_K;q;theta]
T2=[1/Vtrim 0  0 0;
    0       -1 0 1;
    0       1  0 0;
    0       0  1 0];
LinedMod_wo_CA.P4.A=T2*LinedMod_wo_CA.P3.A/T2;                                                
LinedMod_wo_CA.P4.B=T2*LinedMod_wo_CA.P3.B;
LinedMod_wo_CA.P4.C=eye(4);
LinedMod_wo_CA.P4.D=zeros(4,13);

%% Lateral-directional   Roll&Yaw axis
%% RY1 Form
%Initial Order
%State：  [p;phi;v;r;Ye]
%Input：  [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]
%          1     2     3   4      5     6   7   8     9     10    11    12    13      
%          rad                                  %   
%Output： [p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B ;Ye;Psi;Yedot]
LinedMod_wo_CA.RY1.A=A( 6:10,6:10);                                              
LinedMod_wo_CA.RY1.B=B( 6:10,1:13);
LinedMod_wo_CA.RY1.C=C(13:22,6:10);
LinedMod_wo_CA.RY1.D=D(13:22,1:13);

%State： [v;p;r;phi;Ye]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]
%         1     2     3   4      5     6   7   8     9     10    11    12    13      
%         rad                                  %  
%Output：[p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B;Ye;Psi;Yedot]
N=5;P=13;Q=10;
OrdS=[3 1 4 2 5];
OrdI=[1 2 3 4 5 6 7 8 9 10 11 12 13];
OrdO=[1 2 3 4 5 6 7 8 9 10];
[Atemp,Btemp,Ctemp,Dtemp]=Orders(LinedMod_wo_CA.RY1,OrdS,OrdI,OrdO,N,P,Q);
LinedMod_wo_CA.RY1.A=Atemp;                                              
LinedMod_wo_CA.RY1.B=Btemp;
LinedMod_wo_CA.RY1.C=Ctemp;
LinedMod_wo_CA.RY1.D=Dtemp;
%% RY2 Form
%Initial Order
%State： [p;r;phi;v;Ye]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]
%         1     2     3   4      5     6   7   8     9     10    11    12    13      
%         rad                                  % 
%Output：[p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B;Ye;Psi;Yedot]
OrdS=[2 3 4 1 5];
OrdI=[1 2 3 4 5 6 7 8 9 10 11 12 13];
OrdO=[1 2 3 4 5 6 7 8 9 10];

%State： [p;r;phi;v]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]
%         1     2     3   4      5     6   7   8     9     10    11    12    13      
%         rad                                  % 
%Output：[p;r;phi;v]
[Atemp,Btemp,~,~]=Orders(LinedMod_wo_CA.RY1,OrdS,OrdI,OrdO,N,P,Q);
LinedMod_wo_CA.RY2.A=Atemp(1:4,1:4);                                              
LinedMod_wo_CA.RY2.B=Btemp(1:4,1:13);
LinedMod_wo_CA.RY2.C=eye(4);
LinedMod_wo_CA.RY2.D=zeros(4,13);

%% RY3 Form 
%State： [p;r;phi;nyG_B]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]
%         1     2     3   4      5     6   7   8     9     10    11    12    13      
%         [rad]                               [%]
%Output：[p;r;phi;nyG_B]

%get transform matrix
% delta[p;r;phi;ny]=T3*delta[p;r;phi;v]
T3=[1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    Atemp(4,1)/g Atemp(4,2)/g Atemp(4,3)/g Atemp(4,4)/g];                                  % ny = ay/g = vdot/g = betadot*Vstar/g
LinedMod_wo_CA.RY3.A=T3*LinedMod_wo_CA.RY2.A/T3;                                                
LinedMod_wo_CA.RY3.B=T3*LinedMod_wo_CA.RY2.B;
LinedMod_wo_CA.RY3.C=eye(4);
LinedMod_wo_CA.RY3.D=zeros(4,13);

%% RY4 Form 
%State： [p;r;phi;Beta_K_G_E_B]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3]
%         1     2     3   4      5     6   7   8     9     10    11    12    13      
%         rad                                  %
%Output：[p;r;phi;Beta_K_G_E_B]

% get transform matrix
% delta[p;r;phi;Beta_K_G_E_B]=T4*delta[p;r;phi;v]
betatrim=Opreport.Outputs(10).y;                                           % Beta_K_G_E_B trim
T4=[1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1/Vtrim/cos(betatrim)];
LinedMod_wo_CA.RY4.A=T4*LinedMod_wo_CA.RY2.A/T4;                                                
LinedMod_wo_CA.RY4.B=T4*LinedMod_wo_CA.RY2.B;
LinedMod_wo_CA.RY4.C=eye(4);
LinedMod_wo_CA.RY4.D=zeros(4,13);
%% RYnyw Form
% temp form 1
%State： [p;phi;v;r]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  vwind pwind rwind]
%         1     2     3   4      5     6   7   8     9     10    11    12    13     14    15    16
%         [rad]                                [%]                                  [m/s] [rad/s] 
%Output：[p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B]
L.A=A(6:9,6:9);                                                
L.B=B(6:9,[1:13,17:19]);
L.C=C(13:19,6:9);
L.D=D(13:19,[1:13,17:19]);

% temp form 2
%State： [v;p;r:phi]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  vwind pwind rwind]
%         1     2     3   4      5     6   7   8     9     10    11    12    13     14    15    16
%         [rad]                                [%]                                  [m/s] [rad/s] 
%Output：[Beta_K_G_E_B;p;r;phi;nyG_B;nyS_B;Beta_A_R_E_B;]
N=4;P=16;Q=7;
OrdS=[3 1 4 2];
OrdI=1:16;
OrdO=[5 1 3 2 6 7 4];
[Atemp,Btemp,Ctemp,Dtemp]=Orders(L,OrdS,OrdI,OrdO,N,P,Q);

% delta[Beta_K_G_E_B;p;r;phi]=T5*delta[v:p;r;phi]
betatrim=Opreport.Outputs(10).y;                                           % Beta_K_G_E_B trim
T5=[1/Vtrim/cos(betatrim) 0 0 0;
    0                     1 0 0;
    0                     0 1 0;
    0                     0 0 1];

% final form 
%State： [Beta_K_G_E_B;p;r:phi]
%Input： [DAELO DAELI DBF DAERI  DAERO DRL DRR ENGL3 ENGL2 ENGL1 ENGR1 ENGR2 ENGR3  vwind pwind rwind]
%         1     2     3   4      5     6   7   8     9     10    11    12    13     14    15    16
%         [rad]                                [%]                                  [m/s] [rad/s] 
%Output：[Beta_K_G_E_B;p;r;phi;nyG_B;nyS_B;Beta_A_R_E_B;]
LinedMod_wo_CA.RYnyw.A=T5*Atemp/T5;                                                
LinedMod_wo_CA.RYnyw.B=T5*Btemp;
LinedMod_wo_CA.RYnyw.C=Ctemp/T5;
LinedMod_wo_CA.RYnyw.C(1:4,1:4)=eye(4);                                          % Don't comment this at first time, should check are other terms small first. then make sure other terms can be set to zeros. 
LinedMod_wo_CA.RYnyw.D=Dtemp;

% clear AllModel Temp A B C D N P Q OrdO OrdS T1 T2 ans  TM_Inputunit betatrim;
end