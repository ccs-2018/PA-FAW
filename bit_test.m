clear;

alpha = 0.2;
beta11 = 0.1;
beta12 = 0.1;
c = 1;

x0_one = [0.5; 0.5];
A_one = [];
b_one = [];
Aeq_one = [];
beq_one = [];
VLB_one = [0; 0];
VUB_one = [1; 1];

x0_two = [0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5];
A_two = [1,1,0,0,0,0,0,0,0,0; 0,0,1,1,0,0,0,0,0,0; 0,0,0,0,1,1,0,0,0,0; 0,0,0,0,0,0,1,1,0,0; 0,0,0,0,0,0,0,0,1,1];
b_two = [1, 1, 1, 1, 1];
Aeq_two = [];
beq_two = [];
VLB_two = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
VUB_two = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];


[x1, reward1] = fmincon(@(x) bit_reward(x, alpha, beta11, c), x0_one, A_one, b_one, Aeq_one, beq_one, VLB_one, VUB_one);
y1 = 0-reward1;

[xfaw, rewardfaw] = fmincon(@(x) bit_faw_reward(x, alpha, beta11, c), x0_one, A_one, b_one, Aeq_one, beq_one, VLB_one, VUB_one);
yfaw = 0 - rewardfaw;

[x2, reward2] = fmincon(@(x) bit_two_reward_modify(x, alpha, beta11, beta12, c), x0_two, A_two, b_two, Aeq_two, beq_two, VLB_two, VUB_two);
y2 = 0-reward2;

%y1 = (y1-alpha)/alpha*100
x1

%yfaw = (yfaw-alpha)/alpha*100
xfaw

%y2 = (y2-alpha)/alpha*100
%x2