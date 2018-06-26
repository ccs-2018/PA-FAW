%function f = bit_reward(x)
%    f = -x(1) - 2*x(2) + (1/2)*x(1)^2 + (1/2)*x(2)^2;


function r = bit_reward(x, a, b, c)
    r = (1-x(1))*a + b*x(1)*a/(b+x(1)*a) + x(1)*a*((1-x(2))*a/(1-x(2)*a) + ((c*(1-a-b)+b)/(1-x(2)*a))*(x(1)*a+x(2)*a-x(1)*x(2)*a^2)/(2*b-x(2)*a*b+x(1)*a+x(2)*a-x(1)*x(2)*a^2));
    r = -r;
    %r = ((1-t2)*a/(1-t2*a) + ((c*(1-a-b)+b)/(1-t2*a))*(t1*a+t2*a-t1*t2*a^2)/(2*b-t2*a*b+t1*a+t2*a-t1*t2*a^2));