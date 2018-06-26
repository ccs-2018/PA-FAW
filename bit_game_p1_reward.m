function r = bit_game_p1_reward(x, y, a1, a2, c)

%a1=0.2; % my power
%a2=0.2; % oppo power
%c=0;
%x=[0.01 0.01]; % my infil
%y=[0.01 0.01]; % oppo infil

c1=c;
c2=c/2;

p1c1 = a1-x(1);
p1c2 = x(1)*(a1-x(2))/(1-x(2));
p1c3 = y(1)*(a1-x(1))/(1-y(2));
p1c4 = x(1)*y(1)*(a1-x(2))/(1-x(2))/(1-x(2)-y(2));
p1c5 = y(1)*x(1)*(a1-x(2))/(1-y(2))/(1-x(2)-y(2));
p1c6 = c1*y(1)*(1-a1-a2)/(1-y(2));
p1c7 = c2*x(1)*y(1)*(1-a1-a2)/(1-x(2))/(1-x(2)-y(2));
p1c8 = c2*y(1)*x(1)*(1-a1-a2)/(1-y(2))/(1-x(2)-y(2));

f1_1 = x(1);
f1_12 = (x(1)+x(2)-x(1)*x(2))/(2-x(2));
f1_112 = (2*x(1)*(1-y(2)-x(2))+x(2))/(3-2*y(2)-2*x(2));
f1_122 = ((x(1)+x(2))*(1-y(2)-x(2))+x(2))/(3-2*y(2)-2*x(2));

f2_1 = y(1);
f2_12 = (y(1)+y(2)-y(1)*y(2))/(2-y(2));
f2_112 = (2*y(1)*(1-x(2)-y(2))+y(2))/(3-2*x(2)-2*y(2));
f2_122 = ((y(1)+y(2))*(1-x(2)-y(2))+y(2))/(3-2*x(2)-2*y(2));

sp2c1 = p1c1*f2_1/(a1+f2_1);
sp2c2 = p1c2*f2_1/(a1+f2_1);
sp2c3 = p1c3*f2_12/(a1+f2_12);
sp2c4 = p1c4*f2_112/(a1+f2_112);
sp2c5 = p1c5*f2_122/(a1+f2_122);
sp2c6 = p1c6*f2_12/(a1+f2_12);
sp2c7 = p1c7*f2_112/(a1+f2_112);
sp2c8 = p1c8*f2_122/(a1+f2_122);

%q = q_function(infil2, infil1, a1, a2)
p1fp1 = p1c1/(1-q_function(f2_1, f1_1, a1, a2))+p1c2/(1-q_function(f2_1, f1_12, a1, a2))+(p1c3+p1c6)/(1-q_function(f2_12, f1_1, a1, a2))+(p1c4+p1c7)/(1-q_function(f2_112, f1_122, a1, a2))+(p1c5+p1c8)/(1-q_function(f2_122, f1_112, a1, a2));
sp2fp1 = sp2c1/(1-q_function(f2_1, f1_1, a1, a2))+sp2c2/(1-q_function(f2_1, f1_12, a1, a2))+(sp2c3+sp2c6)/(1-q_function(f2_12, f1_1, a1, a2))+(sp2c4+sp2c7)/(1-q_function(f2_112, f1_122, a1, a2))+(sp2c5+sp2c8)/(1-q_function(f2_122, f1_112, a1, a2));
%p1fp1 = a1/(a1+f2_1)*p1c1/(1-q_function(f2_1, f1_1, a1, a2))+a1/(a1+f2_1)*p1c2/(1-q_function(f2_1, f1_12, a1, a2))+a1/(a1+f2_12)*(p1c3+p1c6)/(1-q_function(f2_12, f1_1, a1, a2))+a1/(a1+f2_112)*(p1c4+p1c7)/(1-q_function(f2_112, f1_122, a1, a2))+a1/(a1+f2_122)*(p1c5+p1c8)/(1-q_function(f2_122, f1_112, a1, a2));
%sp2fp1 = a2/(a2+f1_1)*sp2c1/(1-q_function(f2_1, f1_1, a1, a2))+a2/(a2+f1_12)*sp2c2/(1-q_function(f2_1, f1_12, a1, a2))+a2/(a2+f1_1)*(sp2c3+sp2c6)/(1-q_function(f2_12, f1_1, a1, a2))+a2/(a2+f1_122)*(sp2c4+sp2c7)/(1-q_function(f2_112, f1_122, a1, a2))+a2/(a2+f1_112)*(sp2c5+sp2c8)/(1-q_function(f2_122, f1_112, a1, a2));


p2c1 = a2-y(1);
p2c2 = y(1)*(a2-y(2))/(1-y(2));
p2c3 = x(1)*(a2-y(1))/(1-x(2));
p2c4 = y(1)*x(1)*(a2-y(2))/(1-y(2))/(1-y(2)-x(2));
p2c5 = x(1)*y(1)*(a2-y(2))/(1-x(2))/(1-y(2)-x(2));
p2c6 = c1*x(1)*(1-a1-a2)/(1-x(2));
p2c7 = c2*y(1)*x(1)*(1-a2-a1)/(1-y(2))/(1-y(2)-x(2));
p2c8 = c2*x(1)*y(1)*(1-a2-a1)/(1-x(2))/(1-y(2)-x(2));

sp1c1 = p2c1*f1_1/(a2+f1_1);
sp1c2 = p2c2*f1_1/(a2+f1_1);
sp1c3 = p2c3*f1_12/(a2+f1_12);
sp1c4 = p2c4*f1_112/(a2+f1_112);
sp1c5 = p2c5*f1_122/(a2+f1_122);
sp1c6 = p2c6*f1_12/(a2+f1_12);
sp1c7 = p2c7*f1_112/(a2+f1_112);
sp1c8 = p2c8*f1_122/(a2+f1_122);


p2fp2 = p2c1/(1-q_function(f1_1, f2_1, a2, a1))+p2c2/(1-q_function(f1_1, f2_12, a2, a1))+(p2c3+p2c6)/(1-q_function(f1_12, f2_1, a2, a1))+(p2c4+p2c7)/(1-q_function(f1_112, f2_122, a2, a1))+(p2c5+p2c8)/(1-q_function(f1_122, f2_112, a2, a1));
sp1fp2 = sp1c1/(1-q_function(f1_1, f2_1, a2, a1))+sp1c2/(1-q_function(f1_1, f2_12, a2, a1))+(sp1c3+sp1c6)/(1-q_function(f1_12, f2_1, a2, a1))+(sp1c4+sp1c7)/(1-q_function(f1_112, f2_122, a2, a1))+(sp1c5+sp1c8)/(1-q_function(f1_122, f2_112, a2, a1));

%p2fp2 = a2/(a2+f1_1)*p2c1/(1-q_function(f1_1, f2_1, a2, a1))+a2/(a2+f1_1)*p2c2/(1-q_function(f1_1, f2_12, a2, a1))+a2/(a2+f1_12)*(p2c3+p2c6)/(1-q_function(f1_12, f2_1, a2, a1))+a2/(a2+f1_112)*(p2c4+p2c7)/(1-q_function(f1_112, f2_122, a2, a1))+a2/(a2+f1_122)*(p2c5+p2c8)/(1-q_function(f1_122, f2_112, a2, a1));
%sp1fp2 = a1/(a1+f2_1)*sp1c1/(1-q_function(f1_1, f2_1, a2, a1))+a1/(a1+f2_12)*sp1c2/(1-q_function(f1_1, f2_12, a2, a1))+a1/(a1+f2_1)*(sp1c3+sp1c6)/(1-q_function(f1_12, f2_1, a2, a1))+a1/(a1+f2_122)*(sp1c4+sp1c7)/(1-q_function(f1_112, f2_122, a2, a1))+a1/(a1+f2_112)*(sp1c5+sp1c8)/(1-q_function(f1_122, f2_112, a2, a1));


rp1 = p1fp1+sp1fp2;
rp2 = p2fp2+sp2fp1;

r = -rp1;