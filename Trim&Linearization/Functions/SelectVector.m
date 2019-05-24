%%%%%%%%%%%%%Sub function of Linearize_BeihangModel.m 
%
%  Project: BWB DP3
%
%  Beihang Flight Simulation Model
%
%  (c) 2017 Institute of Airwothiness Technology Research Center
%           Prof. Dr. Shuguang ZHANG
%
%   Draft Author:   JU Han
%   Draft Date:     2017-04-14
%
%   Checked by:
%   Checked on:
%
%   Released by:
%   Released on:
%
%%%%%%%%%%%%%%%%Change Log
% 
% 2017-04-14 - JU Han - Initial Draft - V0.1
% 2017-08-13 - JU Han - Linearization model add output: velocity respect to air mass - V0.2
%
%%%%%%%%%%%%%%%%Syntax
%
%   Inputs: ALLModel Opreport
%   Output: LinedMod
%   Description: From linearization results, choose different channels state equation
%                Reorder input,state,output vector and construct
%                proper linearization matrixes for controller design
function LinedMod=SelectVector(AllModel,Opreport)
g         = evalin('base','g');
Actuators = evalin('base', 'Actuators');
% N*1 states£¬P*1 inputs£¬Q*1 outputs£ºA=N*N£¬B=N*P£¬C=Q*N£¬D=Q*P
% N States:[ u   v    w   p q  r  phi theta psi xNorth x_East Altitude]
%            1   2    3   4 5  6  7   8     9   10       11      12 
% P Inputs:[Xi  Eta Zeta Engine uw vw ww pw qw rw]  aileron elevator rudder engine VEL_Wind_R_B ROT_Wind_B 
%           1   2    3   4      5  6  7  8  9  10
% Q Outputs:[p q r phi theta psi  Alpha_A_R_E_B Beta_A_R_E_B VEL_K_G_E_ABS nxG_B nyG_B nzG_B Gamma_K Chi_K Alpha_K_G_E_B Beta_K_G_E_B Xedot Yedot -Hdot  Xe Ye H  nzS_B nyS_B VEL_A_R_E_ABS]
%            1 2 3  4    5    6         7             8             9       10    11     12    13    14         15            16       17    18    19    20 21 22  23    24        25
% About nxG_B nyG_B nzG_B: They are from Load_Factor_G_B .It's at gravity point of body frame.(z axis already products -1 to get positive sign)
%                          nxG_B = axG_B/g+sin(theta)
%                          nyG_B = ayG_B/g-sin(phi)*cos(theta)
%                          nzG_B = -azG_B/g+cos(phi)*cos(theta)            (fly up is positive,when in level flght condition it's close to 1)
% About nxS_B nyS_B nzS_B: It's at sensor's position in body frame z axis
%                          load factor (z axis already products -1), assume sensor is located dx front of gravity point in body frame 
%                          ayS_B ¡Ö vdot + u*r - w*p + rdot*dx
%                          nyS_B = ayS_B/g-sin(phi)*cos(theta)
%                          azS_B ¡Ö wdot - u*q - qdot*dx
%                          nzS_B = -azS_B/g+cos(phi)*cos(theta)            (fly up is positive,when in level flght condition it's close to 1)  more details£ºAircraft control ans simuliation;P309


N=12;P=10;Q=25;                                                            % Unchoose Chi_K, when linearization by pertubation,it can from 0 suddenly to 2*pi,linearization result of Chi_K will be weird
OrdS=[1 3 5 8 12 4 7 2 6 11 9 10];
%new state order: [u w q Theta H p Phi v r Ye Psi Xe]
%                  1 2 3    4  5 6  7  8 9 10  11 12
OrdI=[2 4 5 7 9 1 3 6 8 10];
%new input order: [DE    Dth  uwind wind qwind  DA     DR vwind pwind rwind]
%                  1     2      3     4    5    6      7    8     9     10
%                 -1~1  0~1                    -1~1   -1~1
OrdO=[2 7 15 5 13 10 12 23 9 25 19 22 1 4 3 8 16 11 24 21 6 18 17 20 14];          
% new output order:[q Alpha_A_R_E_B Alpha_K_G_E_B theta gamma_K_G_E_0 nxG_B nzG_B nzS_B VEL_K_G_E_ABS VEL_A_R_E_ABS  -Hdot H  p   phi  r  Beta_A_R_E_B Beta_K_G_E_B  nyG_B nyS_B  Ye Psi Yedot Xedot Xe Chi_K]
%                   1      2             3          4         5        6    7     8           9             10        11  12 13    14 15       16           17        18    19    20 21   22    23   24  25
[A,B,C,D]=Orders(AllModel,OrdS,OrdI,OrdO,N,P,Q);                                                          
TM_Inputunit=[1/Actuators.Pseudo.DE.Def_Max 0      0  0 0 0                             0                             0 0 0;     % Transfer Unit of input DE  from [-1~1] to rad
              0                             1/100  0  0 0 0                             0                             0 0 0;     % Transfer Unit of input Dth from [0~1]  to %
              0                             0      1  0 0 0                             0                             0 0 0;     % uw               
              0                             0      0  1 0 0                             0                             0 0 0;     % ww
              0                             0      0  0 1 0                             0                             0 0 0;     % qw
              0                             0      0  0 0 1/Actuators.Pseudo.DA.Def_Max 0                             0 0 0;     % DA
              0                             0      0  0 0 0                             1/Actuators.Pseudo.DR.Def_Max 0 0 0;     % DR
              0                             0      0  0 0 0                             0                             1 0 0;     % vw
              0                             0      0  0 0 0                             0                             0 1 0;     % pw
              0                             0      0  0 0 0                             0                             0 0 1];    % rw
B = B*TM_Inputunit;
D = D*TM_Inputunit;
%new input unit : [DE    Dth  uw  ww  qw     DA   DR  vw pw rw]
%                  1     2    3   4   5      6    7   8  9  10
%                 rad    %    m/s m/s rad/s  rad  rad


%% Whole model PRY form
LinedMod.PRY.A=A(1:12,1:12);                                               % Pitch Roll and Yaw,PRY                                                     
LinedMod.PRY.B=B(1:12,1:10);
LinedMod.PRY.C=C(1:24,1:12);                                               % Unchoose Chi_K, when linearization by pertubation,it can from 0 suddenly to 2*pi,linearization result of Chi_K will be weird
LinedMod.PRY.D=D(1:24,1:10); 

%State: [u w q Theta H p Phi v r Ye Psi Xe]'    [SI Unit]
%        1 2 3    4  5 6  7  8 9 10  11 12

%Input: [DE    Dth  uw  ww  qw     DA   DR  vw pw rw]'
%        1     2    3   4   5      6    7   8  9  10
%       rad    %    m/s m/s rad/s  rad  rad

%Output:[q Alpha_A_R_E_B Alpha_K_G_E_B theta gamma_K_G_E_0 nxG_B nzG_B nzS_B VEL_K_G_E_ABS VEL_A_R_E_ABS  -Hdot H  p   phi  r  Beta_A_R_E_B Beta_K_G_E_B  nyG_B nyS_B  Ye Psi Yedot Xedot Xe]'
%        1      2             3          4         5        6    7     8           9             10        11  12 13   14  15       16           17        18    19    20 21   22    23   24

%% Longitude Pitch axis ¸©ÑöPÍ¨µÀ
%% P1 Form 
%State: [u w q theta H]'
%Input: [DE  Dth]'
%        rad  %
%Output:[q Alpha_A_R_E_B Alpha_K_G_E_B theta gamma_K_G_E_0 nxG_B nzG_B nzS_B VEL_K_G_E_ABS VEL_A_R_E_ABS  -Hdot H]'
%        1      2             3          4         5        6    7     8           9             10        11  12 
LinedMod.P1.A=A(1:5,1:5);                                                
LinedMod.P1.B=B(1:5,1:2);
LinedMod.P1.C=C(1:12,1:5);
LinedMod.P1.D=D(1:12,1:2);

%% P2 Form 
%State£º [u;w;q;theta]'
%Input£º [DE;Dth]'
%Output£º[u;w;q;theta]'
LinedMod.P2.A=LinedMod.P1.A(1:4,1:4);                                                
LinedMod.P2.B=LinedMod.P1.B(1:4,1:2);
LinedMod.P2.C=eye(4);
LinedMod.P2.D=[0 0;0 0;0 0;0 0];


%% P3 Form 
%State£º [VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]
%Input£º [DE;Dth]
%Output£º[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]

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
LinedMod.P3.A=T1*LinedMod.P2.A/T1;                                                
LinedMod.P3.B=T1*LinedMod.P2.B;
LinedMod.P3.C=eye(4);
LinedMod.P3.D=[0 0;0 0;0 0;0 0];

%% Pw Form
% Pw1
% State£º delta[u;w;q;theta]
% Input£º delta[DE;Dth;uw;ww;qw]
% Output£ºdelta[u;w;q;theta]
LinedMod.Pw1.A = LinedMod.PRY.A(1:4,1:4);                                                
LinedMod.Pw1.B = LinedMod.PRY.B(1:4,1:5);
LinedMod.Pw1.C = eye(4);
LinedMod.Pw1.D = zeros(4,5); 

% Pw2
% State£ºdelta[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]
% Input£ºdelta[DE;Dth;uw;ww;qw]
% Output£ºdelta[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;theta]

LinedMod.Pw2.A=T1*LinedMod.Pw1.A/T1;                                                
LinedMod.Pw2.B=T1*LinedMod.Pw1.B;
LinedMod.Pw2.C=eye(4);
LinedMod.Pw2.D=zeros(4,5);

%% Pnz Form 
% temp form
%State£º [u;w;q;theta]
%Input£º [DE; Dth]
%             rad %
%Output£º[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzG_B;nzS_B]
L.A=A(1:4,1:4);                                                
L.B=B(1:4,1:2);
L.C=C([1,3,4,9,7,8],1:4);
L.D=D([1,3,4,9,7,8],1:2);

N=4;P=2;Q=6;
OrdS=[1 2 3 4];
OrdI=[1 2];
OrdO=[4 2 1 3 5 6];

[Atemp,Btemp,Ctemp,Dtemp]=Orders(L,OrdS,OrdI,OrdO,N,P,Q);

% final form
%State£º [VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta]
%Input£º [DE; Dth]
%         rad %
%Output£º[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzB;nzS]
LinedMod.Pnz.A=T1*Atemp/T1;                                                
LinedMod.Pnz.B=T1*Btemp;
LinedMod.Pnz.C=Ctemp/T1;
LinedMod.Pnz.C(1:4,1:4)=eye(4);
LinedMod.Pnz.D=Dtemp;
%% Pnzw Form
% temp form
%State£º [u;w;q;theta]
%Input£º [DE; Dth;uw;ww;qw]
%         rad  %  m/s   rad/s
%Output£º[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzG_B;nzS_B;VEL_A_R_E_ABS;Alpha_A_R_E_B]
Atemp=A(1:4,1:4);                                                
Btemp=B(1:4,1:5);
Ctemp=C([9,3,1,4,7,8,10,2],1:4);
Dtemp=D([9,3,1,4,7,8,10,2],1:5);

% final form
%State£º [VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta]
%Input£º [DE; Dth;uw;ww;qw]
%         rad %   m/s   rad/s
%Output£º[VEL_K_G_E_ABS;Alpha_K_G_E_B;q;Theta;nzG_B;nzS_B;VEL_A_R_E_ABS;Alpha_A_R_E_B]
LinedMod.Pnzw.A=T1*Atemp/T1;                                                
LinedMod.Pnzw.B=T1*Btemp;
LinedMod.Pnzw.C=Ctemp/T1;
LinedMod.Pnzw.C(1:4,1:4)=eye(4);                                           % Don't comment this at first time, should check are other terms small first. then make sure other terms can be set to zeros. 
LinedMod.Pnzw.D=Dtemp;

%% P4 Form 
%State£º [1/Vtrim*VEL_K_G_E_ABS;Gamma_K_G_E_0;Alpha_K_G_E_B;q]
%Input£º [DE;Dth]
%Output£º[1/Vtrim*VEL_K_G_E_ABS;Gamma_K_G_E_0;Alpha_K_G_E_B;q]

%get transform matrix
% delta[Vstar;gamma;alpha_K;q]=T2*delta[V_K_ABS;alpha_K;q;theta]
T2=[1/Vtrim 0  0 0;
    0       -1 0 1;
    0       1  0 0;
    0       0  1 0];
LinedMod.P4.A=T2*LinedMod.P3.A/T2;                                                
LinedMod.P4.B=T2*LinedMod.P3.B;
LinedMod.P4.C=eye(4);
LinedMod.P4.D=[0 0;0 0;0 0;0 0];

%% Lateral-directional   Roll&Yaw axis
%% RY1 Form
%Initial Order
%State£º  [p;phi;v;r;Ye]
%Input£º  [DA;DR]
%Output£º [p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B ;Ye;Psi;Yedot]
LinedMod.RY1.A=A( 6:10,6:10);                                              
LinedMod.RY1.B=B( 6:10,6: 7);
LinedMod.RY1.C=C(13:22,6:10);
LinedMod.RY1.D=D(13:22,6: 7);

%State£º [v;p;r;phi;Ye]
%Input£º [DA;DR]
%Output£º[p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B;Ye;Psi;Yedot]
N=5;P=2;Q=10;
OrdS=[3 1 4 2 5];
OrdI=[1 2];
OrdO=[1 2 3 4 5 6 7 8 9 10];
[Atemp,Btemp,Ctemp,Dtemp]=Orders(LinedMod.RY1,OrdS,OrdI,OrdO,N,P,Q);
LinedMod.RY1.A=Atemp;                                              
LinedMod.RY1.B=Btemp;
LinedMod.RY1.C=Ctemp;
LinedMod.RY1.D=Dtemp;
%% RY2 Form
%Initial Order
%State£º [p;r;phi;v;Ye]
%Input£º [DA;DR]
%Output£º[p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B;Ye;Psi;Yedot]
OrdS=[2 3 4 1 5];
OrdI=[1 2];
OrdO=[1 2 3 4 5 6 7 8 9 10];

%State£ºdelta[p;r;phi;v]
%Input£ºdelta[DA;DR]
%Output£ºdelta[p;r;phi;v]
[Atemp,Btemp,~,~]=Orders(LinedMod.RY1,OrdS,OrdI,OrdO,N,P,Q);
LinedMod.RY2.A=Atemp(1:4,1:4);                                              
LinedMod.RY2.B=Btemp(1:4,1:2);
LinedMod.RY2.C=eye(4);
LinedMod.RY2.D=[0 0;0 0;0 0;0 0];

%% RY3 Form 
%State£º delta[p;r;phi;nyG_B]
%Input£º delta[DA;DR]
%Output£ºdelta[p;r;phi;nyG_B]

%get transform matrix
% delta[p;r;phi;ny]=T3*delta[p;r;phi;v]
T3=[1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    Atemp(4,1)/g Atemp(4,2)/g Atemp(4,3)/g Atemp(4,4)/g];                                  % ny = ay/g = vdot/g = betadot*Vstar/g
LinedMod.RY3.A=T3*LinedMod.RY2.A/T3;                                                
LinedMod.RY3.B=T3*LinedMod.RY2.B;
LinedMod.RY3.C=eye(4);
LinedMod.RY3.D=[0 0;0 0;0 0;0 0];

%% RY4 Form 
%State£ºdelta[p;r;phi;Beta_K_G_E_B]
%Input£ºdelta[DA;DR]
%Output£ºdelta[p;r;phi;Beta_K_G_E_B]

% get transform matrix
% delta[p;r;phi;Beta_K_G_E_B]=T4*delta[p;r;phi;v]
betatrim=Opreport.Outputs(10).y;                                           % Beta_K_G_E_B trim
T4=[1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1/Vtrim/cos(betatrim)];
LinedMod.RY4.A=T4*LinedMod.RY2.A/T4;                                                
LinedMod.RY4.B=T4*LinedMod.RY2.B;
LinedMod.RY4.C=eye(4);
LinedMod.RY4.D=[0 0;0 0;0 0;0 0];
%% RYnyw Form
% temp form 1
%State£º [p;phi;v;r]
%Input£º [DA; DR;vw;pw;rw]
%         rad  %  m/s  rad/s
%Output£º[p;phi;r;Beta_A_R_E_B;Beta_K_G_E_B;nyG_B;nyS_B]
L.A=A(6:9,6:9);                                                
L.B=B(6:9,6:10);
L.C=C(13:19,6:9);
L.D=D(13:19,6:10);

% temp form 2
%State£º [v;p;r:phi]
%Input£º [DA; DR;vw;pw;rw]
%         rad  %  m/s  rad/s
%Output£º[Beta_K_G_E_B;p;r;phi;nyG_B;nyS_B;Beta_A_R_E_B;]
N=4;P=5;Q=7;
OrdS=[3 1 4 2];
OrdI=[1 2 3 4 5];
OrdO=[5 1 3 2 6 7 4];
[Atemp,Btemp,Ctemp,Dtemp]=Orders(L,OrdS,OrdI,OrdO,N,P,Q);

% delta[Beta_K_G_E_B;p;r;phi]=T5*delta[v:p;r;phi]
betatrim=Opreport.Outputs(10).y;                                           % Beta_K_G_E_B trim
T5=[1/Vtrim/cos(betatrim) 0 0 0;
    0                     1 0 0;
    0                     0 1 0;
    0                     0 0 1];

% final form 
%State£º [Beta_K_G_E_B;p;r:phi]
%Input£º [DA; DR;vw;pw;rw]
%         rad  %  m/s  rad/s
%Output£º[Beta_K_G_E_B;p;r;phi;nyG_B;nyS_B;Beta_A_R_E_B;]
LinedMod.RYnyw.A=T5*Atemp/T5;                                                
LinedMod.RYnyw.B=T5*Btemp;
LinedMod.RYnyw.C=Ctemp/T5;
LinedMod.RYnyw.C(1:4,1:4)=eye(4);                                          % Don't comment this at first time, should check are other terms small first. then make sure other terms can be set to zeros. 
LinedMod.RYnyw.D=Dtemp;

% clear AllModel Temp A B C D N P Q OrdO OrdS T1 T2 ans  TM_Inputunit betatrim;
end