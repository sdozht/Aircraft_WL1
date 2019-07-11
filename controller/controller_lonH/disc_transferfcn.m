sys=tf([tauw_r 0],[tauw_r 1])
dsys=c2d(sys,0.01,'tustin'); % 传函离散 
[num,den]=tfdata(dsys,'v') % 离散后提取分子分母