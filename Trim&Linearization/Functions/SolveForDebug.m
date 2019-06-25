function [r, xs_trim,flag] = SolveYourself(CostHandle, x0, p, rconv, FLG_disp)

    np = length(x0);
    Lambda = 0.8;
    maxiter = 50;
    flag = 0;
    r = zeros(np,1);
    xs_trim = zeros(np,1);
    y = zeros(np,1);
    J = zeros(np,np);
    dy = zeros(np,1);
    iter = 1;
    
    x = x0';
    dx = 0.01;
    
    while (iter < maxiter)
        y = feval(CostHandle, x, p);
        if(FLG_disp)
            disp([num2str(iter),'-----',num2str(y')]);
        end
        if (all(abs(y) < rconv))
            r = y;
            flag = 1;
            xs_trim = x';
            break;
        end
       
        for act = 1:np
            xp = x;   
            xp(act) = xp(act) + dx;
            dy = feval(CostHandle, xp, p);
            J(:,act) = (dy - y)/dx;
        end
        if (rcond(J)<1000*eps)
            disp('=========================================');
            disp('Jacobi close to singular');
            disp(J);
            disp('=========================================');
        end
        
        x = x - Lambda*(J\y);
        iter = iter + 1;
    end
    
    
        
        