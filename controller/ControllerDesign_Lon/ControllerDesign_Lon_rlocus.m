[A,B,C,D]=linmod('ControllerDesign_Lon');
G=ss(A,B,C,D);

figure(1)
rlocus(G)
grid on
