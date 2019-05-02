%% When model include reference models don't use "block by block analytic"linearization algorythm.choose "numerical perturbation" instead.
opt = linearizeOptions('LinearizationAlgorithm','numericalpert',...
    'SampleTime',0);
model = 'Trim_Model';

sys = linearize(model,opreport,opt);

%states order: xe ye ze phi theta psi ub vb wb p  q  r
%             [1  2  3  4   5     6   7  8  9  10 11 12]
%input order:  Xi Eta Throttle Zeta
%             [1  2   3        4]
%output order: ue ve we xe ye ze phi theta psi M_BE(1:9) ub vb wb p  q  r
%             [1  2  3  4  5  6  7   8     9   10:18     19 20 21 22 23 24 
%              pdot qdot rdot ubdot vbdot wbdot Fuel_available VEL_K_R_ABS
%              25   26   27   28    29    30    31             32    
%              Chi Gamma Alpha Beta
%              33  34    35    36]
%


%% 
N=12;P=4;Q=25;                                                            % Unchoose Chi_K, when linearization by pertubation,it can from 0 suddenly to 2*pi,linearization result of Chi_K will be weird
OrdS=[7 9 11 5 3 10 4 8 12 6 2 1];
%new state order: [ub wb q theta ze p Phi vb r psi ye xe]
%                  1  2  3 4     5  6 7   8  9 10  11 12
OrdI=[2 3 1 4];
%new input order: [DE   Dth     DA     DR]
%                  1    2       3      4
%                 -1~1  0~1     -1~1   -1~1
OrdO=[1:9,19:30,32,34,35,36];          
% new output order:[ue ve we xe ye ze phi theta psi ub vb wb p  q  r  pdot qdot rdot ubdot vbdot wbdot VEL_K_R_ABS Gamma Alpha Beta]
%                   1  2  3  4  5  6  7   8     9   10 11 12 13 14 15 16   17   18   19    20    21    22          23    24    25

[A,B,C,D]=Orders(sys,OrdS,OrdI,OrdO,N,P,Q);

TM_Inputunit=[1/Actuators.Pseudo.DEDef_Max  0      0  0;
              0                             1/100  0  0;
              0                             0      1/Actuators.Pseudo.DADef_Max  0;      
              0                             0      0  1/Actuators.Pseudo.DRDef_Max];

B = B*TM_Inputunit;
D = D*TM_Inputunit;



%% customize system matrixes
%% all states
Linmod.all.A = A;
Linmod.all.B = B;
Linmod.all.C = C;
Linmod.all.D = D;


%% Longitudinal motion states, 4 order
Linmod.Lon_4.A = A(1:4,1:4);
Linmod.Lon_4.B = B(1:4,1:2);
Linmod.Lon_4.C = eye(4);
Linmod.Lon_4.D = zeros(4,2);

%% Longitudinal motion states, 5 order
Linmod.Lon_5.A = A(1:5,1:5);
Linmod.Lon_5.B = B(1:5,1:2);
Linmod.Lon_5.C = eye(5);
Linmod.Lon_5.D = zeros(5,2);

%% lateral-directional motion states, 4 order
Linmod.Lat_4.A = A(6:9,6:9);
Linmod.Lat_4.B = B(6:9,3:4);
Linmod.Lat_4.C = eye(4);
Linmod.Lat_4.D = zeros(4,2);


%% lateral-directional motion states, 6 order
Linmod.Lat_6.A = A(6:11,6:11);
Linmod.Lat_6.B = B(6:11,3:4);
Linmod.Lat_6.C = eye(6);
Linmod.Lat_6.D = zeros(6,2);

%%
datapath = [Root_Folder,'/Trim&Linearization/ResultData'];
save([datapath,'/Linmod2'],'Linmod');