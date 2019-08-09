[A,B,C,D]=linmod('ControllerDesign_STD');
G=ss(A,B,C,D);

figure(1)
rlocus(G)
grid on


%%
figure(2)
hold on
margin(G)
grid on