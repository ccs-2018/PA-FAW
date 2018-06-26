function r = bit_faw_reward(x, a, b, c)
    r = (1-x(1))*a/(1-x(1)*a)+(b/(1-x(1)*a)+c*x(1)*a*(1-a-b)/(1-x(1)*a))*x(1)*a/(b+x(1)*a);
    r = -r;