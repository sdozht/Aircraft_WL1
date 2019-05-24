% This is a sub function of Trim_BeihangModel.m
function [r, varargout] = Horizontal(xs,fc)                                % xs unknown, fc known

x = zeros(1,12);
u = zeros(1,10);

V =  fc(1);                                                                % Level flight allow beta ,phi=0 
Alpha = xs(1)/100;
Beta = xs(2)/100;
p = 0;
q = 0;
r = 0;
Phi = 0;
Theta = xs(3)/100;
Psi = 0;

xe = 0;
ye = 0;
h = fc(2);

 x(1) = V*cos(Beta)*cos(Alpha);
 x(2) = V*sin(Beta);
 x(3) = V*cos(Beta)*sin(Alpha);
 
 x(4) = p;
 x(5) = q;
 x(6) = r;
 
 x(7) = Phi;
 x(8) = Theta;
 x(9) = Psi;
 
 x(10) = xe;
 x(11) = ye;
 x(12) = h;
 
 Xi = xs(4)/100;
 Eta = xs(5)/100;
 Zeta = xs(6)/100;
 Engine = xs(7); 

 
 u(1) = Xi;
 u(2) = Eta;
 u(3) = Zeta;
 u(4) = Engine;
 
 u(5) = 0;                                                                 % VEL_Wind_R_B:u ,set 0, the reason why put it to root level is that 'numerical pertubation' linearize algorithm only support root level.  
 u(6) = 0;                                                                 % VEL_Wind_R_B:v
 u(7) = 0;                                                                 % VEL_Wind_R_B:w
 u(8) = 0;                                                                 % ROT_Wind_B:p
 u(9) = 0;                                                                 % ROT_Wind_B:q
 u(10) = 0;                                                                % ROT_Wind_B:r
 
y = Trim_Model(0,x,u,'outputs');
xdot = Trim_Model(0,x,u,'derivs');

u_dot = xdot(1);
v_dot = xdot(2);
w_dot = xdot(3);
p_dot = xdot(4);
q_dot = xdot(5);
r_dot = xdot(6);
Phi_dot = xdot(7);
Theta_dot = xdot(8);
Psi_dot = xdot(9);
xe_dot = xdot(10);
ye_dot = xdot(11);
h_dot = xdot(12);

r = zeros(7,1);                                                            
r(1) = u_dot;                                                              % calculate to zero
r(2) = v_dot;
r(3) = w_dot;
r(4) = p_dot*100;
r(5) = q_dot*100;
r(6) = r_dot*100;
r(7) = h_dot;

if (nargout > 1)
    varargout{1} = x;                                                      % x_Trim=[u,v,w,p,q,r,phi,theta,psi,xe,ye,h]
                                                                           %         1 2 3 4 5 6  7    8    9  10 11 12    
    varargout{2} = u;                                                      % u_Trim=[Xi,Eta,Zeta,Engine,uwind,vwind,wwind,pwind,qwind,rwind]
    varargout{3} = xdot;   
    varargout{4} = y;     

end