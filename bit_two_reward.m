function r = bit_two_reward(x, a, b1, b2, c)
	% x(1) in pool 1 before Case 4
	% x(2) in pool 2 before Case 4
	% x(3) in pool 1 before Case 4-4
	% x(4) in pool 2 before Case 4-4
	% x(5) in pool 1 before Case 4-4-4
	% x(6) in pool 2 before Case 4-4-4
	p1bar12 = (x(3)+x(1)*(1-x(3)*a-x(4)*a))/(2-x(3)*a-x(4)*a);
	p2bar12 = (x(4)+x(2)*(1-x(3)*a-x(4)*a))/(2-x(3)*a-x(4)*a);
	p1bar123 = (x(5)+(x(1)+x(3))*(1-x(5)*a-x(6)*a))/(3-2*x(5)*a-2*x(6)*a);
	p2bar123 = (x(6)+(x(2)+x(4))*(1-x(5)*a-x(6)*a))/(3-2*x(5)*a-2*x(6)*a);

%   r = a*(1-x(1)-x(2))+a*(1-x(3)-x(4))*( x(1)*a/(1-x(3)*a) + x(2)*a/(1-x(4)*a))+a*(1-x(5)-x(6))*( x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a))+a*x(1)*b1/(a*x(1)+b1)+a*x(2)*b2/(a*x(2)+b2)+(p1bar12*a*b1/(p1bar12*a+b1)+p2bar12*b2*a/(p2bar12*a+b2))*( x(1)*a/(1-x(3)*a) + x(2)*a/(1-x(4)*a))+(p1bar123*a*b1/(p1bar123*a+b1)+p2bar123*a*b2/(p2bar123*a+b2))*( x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a))+(1-a-b1-b2)*c*p1bar12*a/(p1bar12*a+b1)*x(1)*a/(1-x(3)*a)+(1-a-b1-b2)*c*p2bar12*a/(p2bar12*a+b2)*x(2)*a/(1-x(4)*a)+(1-a-b1-b2)*c/2*(p1bar123*a/(p1bar123*a+b1)+p2bar123*a/(p2bar123*a+b2))*( x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a));

    r1 = a*(1-x(1)-x(2));
    r2 = a*(1-x(3)-x(4))*(x(1)*a/(1-x(3)*a) + x(2)*a/(1-x(4)*a));
    r3 = a*(1-x(5)-x(6))*(x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a));
    r4 = b1*x(1)*a/(x(1)*a+b1)+b2*x(2)*a/(x(2)*a+b2);
    r5 = (p1bar12*a*b1/(p1bar12*a+b1)+p2bar12*a*b2/(p2bar12*a+b2))*(x(1)*a/(1-x(3)*a) + x(2)*a/(1-x(4)*a));
    r6 = (p1bar123*a*b1/(p1bar123*a+b1)+p2bar123*a*b2/(p2bar123*a+b2))*(x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a));
    r7 = (1-a-b1-b2)*c*p1bar12*a/(p1bar12*a+b1)*x(1)*a/(1-x(3)*a);
    r8 = (1-a-b1-b2)*c*p2bar12*a/(p2bar12*a+b2)*x(2)*a/(1-x(4)*a);
    r9 = (1-a-b1-b2)*c/2*(p1bar123*a/(p1bar123*a+b1)+p2bar123*a/(p2bar123*a+b2))*( x(1)*a*x(4)*a/(1-x(3)*a)/(1-x(5)*a-x(6)*a) + x(2)*a*x(3)*a/(1-x(4)*a)/(1-x(5)*a-x(6)*a));
    r = -(r1+r2+r3+r4+r5+r6+r7+r8+r9);