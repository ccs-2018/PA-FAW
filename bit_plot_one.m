clear;
beta1 = 0.1;
beta2 = 0.2;
beta3 = 0.3;
aplha = 0.2;
step = 100;
c = 0:1/step:1;


x0 = [0.5; 0.5];
A = [];
b = [];
Aeq = [];
beq = [];
VLB = [0; 0];
VUB = [1; 1];

x0_faw = [0.5; 0.5];
VLB_faw = [0; 0];
VUB_faw = [1; 1];

for i=1:step+1
    disp(['At i=', num2str(i)'.'])
    [x, reward] = fmincon(@(x) bit_reward(x, aplha, beta1, c(i)), x0, A, b, Aeq, beq, VLB, VUB);
    y1(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_faw_reward(x, aplha, beta1,c(i)), x0_faw, A, b, Aeq, beq, VLB_faw, VUB_faw);
    y1_faw(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_reward(x, aplha, beta2, c(i)), x0, A, b, Aeq, beq, VLB, VUB);
    y2(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_faw_reward(x, aplha, beta2, c(i)), x0_faw, A, b, Aeq, beq, VLB_faw, VUB_faw);
    y2_faw(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_reward(x, aplha, beta3, c(i)), x0, A, b, Aeq, beq, VLB, VUB);
    y3(i) = 0-reward;
    [x, reward] = fmincon(@(x) bit_faw_reward(x, aplha, beta3, c(i)), x0_faw, A, b, Aeq, beq, VLB_faw, VUB_faw);
    y3_faw(i) = 0-reward;
end
y1 = (y1-aplha)/aplha*100;
y2 = (y2-aplha)/aplha*100;
y3 = (y3-aplha)/aplha*100;
y1_faw = (y1_faw-aplha)/aplha*100;
y2_faw = (y2_faw-aplha)/aplha*100;
y3_faw = (y3_faw-aplha)/aplha*100;

cloc=0:0.1:1;
onerwdp1_1 = [0.5914    0.6192    0.6803    0.8389    1.0753    1.4413    1.9781    2.6794    3.5827    4.7038    6.1722];
onerwdp1_2 = [1.2751    1.3244    1.3773    1.4440    1.5941    1.8330    2.2129    2.7714    3.5144    4.4070    5.5036];
onerwdp1_3 = [2.0349    2.1224    2.1938    2.2885    2.3934    2.5096    2.6697    2.9432    3.3588    3.9461    4.7106];
plot(c,y1,'b', c,y2,'g', c,y3,'r', c,y1_faw,'b--', c,y2_faw,'g--', c,y3_faw,'r--','LineWidth',2);
hold on
plot(cloc,onerwdp1_1,'x','MarkerEdgeColor','b','MarkerSize',10,'LineWidth',3);
plot(cloc,onerwdp1_2,'x','MarkerEdgeColor','g','MarkerSize',10,'LineWidth',3);
plot(cloc,onerwdp1_3,'x','MarkerEdgeColor','r','MarkerSize',10,'LineWidth',3);

grid on;
ylabel('Expected Relative Extra Reward (%)');
xlabel('Coefficient c');
legend('PA-FAW: Case 1', 'PA-FAW: Case 2', 'PA-FAW: Case 3', 'FAW: Case 1', 'FAW: Case 2', 'FAW: Case 3', 'PA-FAW: Case 1 (Simulation)', 'PA-FAW: Case 2 (Simulation)', 'PA-FAW: Case 3 (Simulation)')
set(gca,'FontName', 'Times New Roman');
hold off