clear;
step=100;

beta11 = 0.1;
beta12 = 0.1;
beta21 = 0.2;
beta22 = 0.1;
beta31 = 0.3;
beta32 = 0.1;
alpha = 0.2;
c = 0:1/step:1;


x0_two = [0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5];
A_two = [1,1,0,0,0,0,0,0,0,0; 0,0,1,1,0,0,0,0,0,0; 0,0,0,0,1,1,0,0,0,0; 0,0,0,0,0,0,1,1,0,0; 0,0,0,0,0,0,0,0,1,1];
b_two = [1, 1, 1, 1, 1];
Aeq_two = [];
beq_two = [];
VLB_two = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
VUB_two = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];

x0_faw = [0.5; 0.5];
A_faw = [];
b_faw = [];
Aeq_faw = [];
beq_faw = [];
VLB_faw = [0; 0];
VUB_faw = [1; 1];

for i=1:(step+1)
    disp(['At i=', num2str(i)'.'])
    [x, reward] = fmincon(@(x) bit_two_reward_modify(x, alpha, beta11, beta12, c(i)), x0_two, A_two, b_two, Aeq_two, beq_two, VLB_two, VUB_two);
    y1(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_two_faw_reward(x, alpha, beta11, beta12, c(i)), x0_faw, A_faw, b_faw, Aeq_faw, beq_faw, VLB_faw, VUB_faw);
    y1_faw(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_two_reward_modify(x, alpha, beta21, beta22, c(i)), x0_two, A_two, b_two, Aeq_two, beq_two, VLB_two, VUB_two);
    y2(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_two_faw_reward(x, alpha, beta21, beta22, c(i)), x0_faw, A_faw, b_faw, Aeq_faw, beq_faw, VLB_faw, VUB_faw);
    y2_faw(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_two_reward_modify(x, alpha, beta31, beta32, c(i)), x0_two, A_two, b_two, Aeq_two, beq_two, VLB_two, VUB_two);
    y3(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_two_faw_reward(x, alpha, beta31, beta32, c(i)), x0_faw, A_faw, b_faw, Aeq_faw, beq_faw, VLB_faw, VUB_faw);
    y3_faw(i) = 0-reward;
end
y1 = (y1-alpha)/alpha*100;
y2 = (y2-alpha)/alpha*100;
y3 = (y3-alpha)/alpha*100;
y1_faw = (y1_faw-alpha)/alpha*100;
y2_faw = (y2_faw-alpha)/alpha*100;
y3_faw = (y3_faw-alpha)/alpha*100;

%cloc=0:0.1:1;

%tworwdp1_1=load('mc_two_beta_1.000000e-01.txt','-ascii');
%tworwdp1_2=load('mc_two_beta_2.000000e-01.txt','-ascii');
%tworwdp1_3=load('mc_two_beta_3.000000e-01.txt','-ascii');


%tworwdp1_1 = [1.2683    1.3166    1.3824    1.4413    1.5997    1.8992    2.3484    2.9576    3.6932    4.5674    5.6265];


plot(c,y1,'b', c,y2,'g', c,y3,'r', c,y1_faw,'b--', c,y2_faw,'g--', c,y3_faw,'r--','LineWidth',2);


%hold on
%plot(cloc,tworwdp1_1,'x','MarkerEdgeColor','b','MarkerSize',10,'LineWidth',3);
%plot(cloc,tworwdp1_2,'x','MarkerEdgeColor','g','MarkerSize',10,'LineWidth',3);
%plot(cloc,tworwdp1_3,'x','MarkerEdgeColor','r','MarkerSize',10,'LineWidth',3);
%hold off

grid on;
ylabel('Expected Relative Extra Reward (%)');
xlabel('Coefficient c');
legend('PA-FAW: Case 1', 'PA-FAW: Case 2', 'PA-FAW: Case 3', 'FAW: Case 1', 'FAW: Case 2', 'FAW: Case 3', 'PA-FAW: Case 1 (Simulation)', 'PA-FAW: Case 2 (Simulation)', 'PA-FAW: Case 3 (Simulation)')
set(gca,'FontName', 'Times New Roman');
