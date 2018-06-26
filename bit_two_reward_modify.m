function r = bit_two_reward_modify(x, a, b1, b2, c)
	% x(1) in pool 1 before Case 4/5
	% x(2) in pool 2 before Case 4/5
	% x(3) in pool 1 before Case 4-4
	% x(4) in pool 2 before Case 4-4
	% x(5) in pool 1 before Case 5-4
	% x(6) in pool 2 before Case 5-4
    % x(7) in pool 1 before Case 4-4-4
	% x(8) in pool 2 before Case 4-4-4
    % x(9) in pool 1 before Case 5-4-4
	% x(10) in pool 2 before Case 5-4-4
	
    % x1, x3
    p1bar12c4 = (x(3)+x(1)*(1-x(3)*a-x(4)*a))/(2-x(3)*a-x(4)*a);
    % x2, x4
    p2bar12c4 = (x(4)+x(2)*(1-x(3)*a-x(4)*a))/(2-x(3)*a-x(4)*a);
    % x1, x5
    p1bar12c5 = (x(5)+x(1)*(1-x(5)*a-x(6)*a))/(2-x(5)*a-x(6)*a);
    % x2, x6
    p2bar12c5 = (x(6)+x(2)*(1-x(5)*a-x(6)*a))/(2-x(5)*a-x(6)*a);
    % x1, x3, x7
    p1bar123c4 = (x(7)+(x(1)+x(3))*(1-x(7)*a-x(8)*a))/(3-2*x(7)*a-2*x(8)*a);
    % x2, x4, x8
    p2bar123c4 = (x(8)+(x(2)+x(4))*(1-x(7)*a-x(8)*a))/(3-2*x(7)*a-2*x(8)*a);
    % x1, x5, x9
    p1bar123c5 = (x(9)+(x(1)+x(5))*(1-x(9)*a-x(10)*a))/(3-2*x(9)*a-2*x(10)*a);
    % x2, x6, x10
    p2bar123c5 = (x(10)+(x(2)+x(6))*(1-x(9)*a-x(10)*a))/(3-2*x(9)*a-2*x(10)*a);

%   r = a*(1-x(1)-x(2))+a*(1-x(3)-x(4))*( x(1)*a/(1-x(3)*a) + x(2)*a/(1-x(4)*a))+a*(1-x(5)-x(6))*( x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a))+a*x(1)*b1/(a*x(1)+b1)+a*x(2)*b2/(a*x(2)+b2)+(p1bar12*a*b1/(p1bar12*a+b1)+p2bar12*b2*a/(p2bar12*a+b2))*( x(1)*a/(1-x(3)*a) + x(2)*a/(1-x(4)*a))+(p1bar123*a*b1/(p1bar123*a+b1)+p2bar123*a*b2/(p2bar123*a+b2))*( x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a))+(1-a-b1-b2)*c*p1bar12*a/(p1bar12*a+b1)*x(1)*a/(1-x(3)*a)+(1-a-b1-b2)*c*p2bar12*a/(p2bar12*a+b2)*x(2)*a/(1-x(4)*a)+(1-a-b1-b2)*c/2*(p1bar123*a/(p1bar123*a+b1)+p2bar123*a/(p2bar123*a+b2))*( x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a));

    r1 = a*(1-x(1)-x(2));
    r2 = 0;
    r3 = b1*x(1)*a/(x(1)*a+b1)+b2*x(2)*a/(x(2)*a+b2);
    r41 = a*x(1)/(1-x(3)*a)*(1-x(3)-x(4))*a;
    r42 = a*x(1)/(1-x(3)*a)*(1-a-b1-b2)*c*p1bar12c4*a/(p1bar12c4*a+b1);
    r43 = a*x(1)/(1-x(3)*a)*(b1*p1bar12c4*a/(p1bar12c4*a+b1)+b2*p2bar12c4*a/(p2bar12c4*a+b2));
    r441 = a*x(1)/(1-x(3)*a)*x(4)*a/(1-x(7)*a-x(8)*a)*(1-x(7)-x(8))*a;
    r442 = a*x(1)/(1-x(3)*a)*x(4)*a/(1-x(7)*a-x(8)*a)*(1-a-b1-b2)*c/2*p1bar123c4*a/(p1bar123c4*a+b1);
    r443 = a*x(1)/(1-x(3)*a)*x(4)*a/(1-x(7)*a-x(8)*a)*(b1*p1bar123c4*a/(p1bar123c4*a+b1)+b2*p2bar123c4*a/(p2bar123c4*a+b2));
    r51 = a*x(2)/(1-x(6)*a)*(1-x(5)-x(6))*a;
    r52 = a*x(2)/(1-x(6)*a)*(1-a-b1-b2)*c*p2bar12c5*a/(p2bar12c5*a+b2);
    r53 = a*x(2)/(1-x(6)*a)*(b1*p1bar12c5*a/(p1bar12c5*a+b1)+b2*p2bar12c5*a/(p2bar12c5*a+b2));
    r541 = a*x(2)/(1-x(6)*a)*x(5)*a/(1-x(9)*a-x(10)*a)*(1-x(9)-x(10))*a;
    r542 = a*x(2)/(1-x(6)*a)*x(5)*a/(1-x(9)*a-x(10)*a)*(1-a-b1-b2)*c/2*p2bar123c5*a/(p2bar123c5*a+b2);
    r543 = a*x(2)/(1-x(6)*a)*x(5)*a/(1-x(9)*a-x(10)*a)*(b1*p1bar123c5*a/(p1bar123c5*a+b1)+b2*p2bar123c5*a/(p2bar123c5*a+b2));
    
    r = -(r1+r2+r3+r41+r42+r43+r441+r442+r443+r51+r52+r53+r541+r542+r543);