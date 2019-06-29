%% When model include reference models don't use "block by block analytic"linearization algorythm.choose "numerical perturbation" instead.
opt = linearizeOptions('LinearizationAlgorithm','numericalpert',...
    'SampleTime',0);
model = "Trim_Model2";

sys = linearize(model,opreport,opt);

%states order: phi theta psi ub vb wb p  q  r xe ye ze 
%             [1   2     3   4  5  6  7  8  9 10 11 12]
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
N=12;P=4;Q=17;                                                            % Unchoose Chi_K, when linearization by pertubation,it can from 0 suddenly to 2*pi,linearization result of Chi_K will be weird
OrdS=[4 6 8 2 12 10 7 1 5 9 3 11];
%new state order: [ub wb q theta ze xe p Phi vb r  psi ye]
%                  1  2  3 4     5  6  7 8   9  10 11  12
OrdI=[2 3 1 4];
%new input order: [DE   Dth     DA     DR]
%                  1    2       3      4
%                 -1~1  0~1     -1~1   -1~1
OrdO=[23 35 8 34 32 3 6 1 4 22 7 24 36 2 5 9 33];          
% new output order:[q  Alpha theta Gamma VEL_K_R_ABS  we ze ue xe p  phi r  
%                   1  2     3     4     5            6  7  8  9  10 11  12
%                   Beta ve ye psi Chi]
%                   13   14 15 16  17
[A,B,C,D]=Orders(sys,OrdS,OrdI,OrdO,N,P,Q);

TM_Inputunit=[1/Actuators.Pseudo.DEDef_Max  0      0  0;
              0                             1/100  0  0;
              0                             0      1/Actuators.Pseudo.DADef_Max  0;      
              0                             0      0  1/Actuators.Pseudo.DRDef_Max];

B = B*TM_Inputunit;
D = D*TM_Inputunit;



%% customize system matrixes
%% all states
%state order: delta[ub:wb:q:theta:ze:xe:p:Phi:vb:r:psi:ye]
%input order: delta[DE:Dth:DA:DR]
%output order:delta[q:Alpha:theta:Gamma:VEL_K_R_ABS:we:ze:ue:xe:p:phi:r:Beta:ve:ye:psi:Chi]

Linmod.all.A = A;
Linmod.all.B = B;
Linmod.all.C = C;
Linmod.all.D = D;

%% Longitudinal motion states, 6 order
%state order: delta[ub:wb:q:theta:ze:xe]
%input order: delta[DE:Dth]
%output order:delta[q:Alpha:theta:Gamma:VEL_K_R_ABS:we:ze:ue:xe]


Linmod.Lon_all.A = A(1:6,1:6);
Linmod.Lon_all.B = B(1:6,1:2);
Linmod.Lon_all.C = C(1:9,1:6);
Linmod.Lon_all.D = zeros(9,2);



%% Longitudinal motion states, 4 order
%state order: delta[ub:wb:q:theta]
%input order: delta[DE:Dth]
%output order:delta[ub:wb:q:theta]

Linmod.Lon_4a.A = Linmod.Lon_all.A(1:4,1:4);
Linmod.Lon_4a.B = Linmod.Lon_all.B(1:4,1:2);
Linmod.Lon_4a.C = Linmod.Lon_all.C(1:6,1:4);
Linmod.Lon_4a.D = zeros(6,2);


%state order: delta[V:alpha:q:theta]
%input order: delta[DE:Dth]
%output order:delta[V:alpha:q:theta]

%delta[V:alpha:q:theta] = T1*delta[ub:wb:q:theta]
Ltrim = struct;
Ltrim.u = opreport.States(7).x;
Ltrim.w = opreport.States(9).x;
Ltrim.V = opreport.Outputs(10).y;

T1 = [Ltrim.u/Ltrim.V       Ltrim.w/Ltrim.V         0   0;
    -Ltrim.w/(Ltrim.V^2)    Ltrim.u/(Ltrim.V)^2     0   0;
    0                       0                       1   0;
    0                       0                       0   1];

Linmod.Lon_4b.A = T1*Linmod.Lon_4a.A/T1;
Linmod.Lon_4b.B = T1*Linmod.Lon_4a.B;
Linmod.Lon_4b.C = Linmod.Lon_4a.C/T1;
Linmod.Lon_4b.D = Linmod.Lon_4a.D;




%% Longitudinal motion states, 5 order
%state order: delta[ub:wb:q:theta:ze]
%input order: delta[DE:Dth]
%output order:delta[ub:wb:q:theta:ze]

Linmod.Lon_5a.A = A(1:5,1:5);
Linmod.Lon_5a.B = B(1:5,1:2);
Linmod.Lon_5a.C = eye(5);
Linmod.Lon_5a.D = zeros(5,2);

%state order: delta[[V:alpha:q:theta:ze]
%input order: delta[DE:Dth]
%output order:delta[[V:alpha:q:theta:ze]

%delta[V:alpha:q:theta] = T1*delta[ub:wb:q:theta]
T1 = [Ltrim.u/Ltrim.V       Ltrim.w/Ltrim.V         0   0   0;
    -Ltrim.w/(Ltrim.V^2)    Ltrim.u/(Ltrim.V)^2     0   0   0;
    0                       0                       1   0   0;
    0                       0                       0   1   0;
    0                       0                       0   0   1];

Linmod.Lon_5b.A = T1*Linmod.Lon_5a.A/T1;
Linmod.Lon_5b.B = T1*Linmod.Lon_5a.B;
Linmod.Lon_5b.C = Linmod.Lon_5a.C/T1;
Linmod.Lon_5b.D = Linmod.Lon_5a.D;

%% lateral-directional motion states, 6 order
%state order: delta[p:phi:vb:r:psi:ye]
%input order: delta[DA:DR]
%output order:delta[p:phi:r:Beta:ve:ye:psi:Chi]


Linmod.Lat_all.A = A(7:12,7:12);
Linmod.Lat_all.B = B(7:12,3:4);
Linmod.Lat_all.C = C(10:17,7:12);
Linmod.Lat_all.D = zeros(8,2);

%% lateral-directional motion states, 4 order
%state order: delta[p:phi:vb:r]
%input order: delta[DA:DR]
%output order:delta[p:phi:vb:r]

Linmod.Lat_4a.A = Linmod.Lat_all.A(1:4,1:4);
Linmod.Lat_4a.B = Linmod.Lat_all.B(1:4,:);
Linmod.Lat_4a.C = eye(4);
Linmod.Lat_4a.D = zeros(4,2);


%state order: delta[beta:p:r:phi]
%input order: delta[DA:DR]
%output order:delta[beta:p:r:phi]

%delta[beta:p:r:phi] = T2*delta[p:phi:vb:r]
Ltrim.beta = opreport.Outputs(14).y;

T2 =    [0 0 1/(Ltrim.V*cos(Ltrim.beta))    0;
         1 0 0                              0;
         0 0 0                              1;
         0 1 0                              0];
Linmod.Lat_4b.A = T2*Linmod.Lat_4a.A/T2;
Linmod.Lat_4b.B = T2*Linmod.Lat_4a.B;
Linmod.Lat_4b.C = Linmod.Lat_4a.C/T2;
Linmod.Lat_4b.D = Linmod.Lat_4a.D;


%% lateral-directional motion states, 5 order
%state order: delta[p:phi:vb:r:psi]
%input order: delta[DA:DR]
%output order:delta[p:phi:r:Beta:ve:psi]

Linmod.Lat_5a.A = Linmod.Lat_all.A(1:5,1:5);
Linmod.Lat_5a.B = Linmod.Lat_all.B(1:5,:);
Linmod.Lat_5a.C = Linmod.Lat_all.C([1:5,7],1:5);
Linmod.Lat_5a.D = zeros(6,2);


%state order: delta[beta:p:r:phi:psi]
%input order: delta[DA:DR]
%output order:delta[p:phi:r:Beta:ve:psi]

%delta[beta:p:r:phi:psi] = T2*delta[p:phi:vb:r:psi]

T2 =    [0 0 1/(Ltrim.V*cos(Ltrim.beta))    0   0;
         1 0 0                              0   0;
         0 0 0                              1   0;
         0 1 0                              0   0;
         0 0 0                              0   1];
Linmod.Lat_5b.A = T2*Linmod.Lat_5a.A/T2;
Linmod.Lat_5b.B = T2*Linmod.Lat_5a.B;
Linmod.Lat_5b.C = Linmod.Lat_5a.C/T2;
Linmod.Lat_5b.D = Linmod.Lat_5a.D;

%%
datapath = [Root_Folder,'/Trim&Linearization/ResultData'];
save([datapath,'/Linmod7'],'Linmod');