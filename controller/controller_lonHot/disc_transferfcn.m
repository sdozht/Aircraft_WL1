sys=tf([tauw_r 0],[tauw_r 1])
dsys=c2d(sys,0.01,'tustin'); % ������ɢ 
[num,den]=tfdata(dsys,'v') % ��ɢ����ȡ���ӷ�ĸ