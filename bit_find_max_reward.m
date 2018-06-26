clear;
alpha = 0.2;
beta1 = 0.1;
beta2 = 0.3;
c = 0.5;

x0 = [0.5; 0.5; 0.5; 0.5; 0.5; 0.5];
A = [1,1,0,0,0,0; 0,0,1,1,0,0; 0,0,0,0,1,1];
b = [1, 1, 1];
Aeq = [];
beq = [];
VLB = [0; 0; 0; 0; 0; 0];
VUB = [1; 1; 1; 1; 1; 1];
[x, reward] = fmincon(@(x) bit_two_reward(x, alpha, beta1, beta2, c), x0, A, b, Aeq, beq, VLB, VUB);

x
reward