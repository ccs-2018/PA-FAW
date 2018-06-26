clear;
step = 100;
beta = 0.5/step:0.5/step:0.5;
c = 0:1/step:1;
aplha = 0.2;

x0 = [0.5; 0.5];
A = [];
b = [];
Aeq = [];
beq = [];
VLB = [0; 0];
VUB = [1; 1];
for i = 1:(step+1)
    for j = 1:step
        disp(['At i=', num2str(i), ', j=', num2str(j), '.'])
        [x, reward] = fmincon(@(x) bit_faw_reward(x, aplha, beta(j), c(i)), x0, A, b, Aeq, beq, VLB, VUB);
        tau1(i, j) = x(1);
        tau2(i, j) = x(2);
    end
end


imagesc(beta, c, tau1);
cb = colorbar;
cb.Label.String = 'Infiltration Mining Power \tau_1';
set(gca, 'YDir', 'normal')
xlabel('Size of Target Pool \beta');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);

pause;

imagesc(beta, c, tau2);
cb = colorbar;
cb.Label.String = 'Infiltration Mining Power \tau_2';
set(gca, 'YDir', 'normal')
xlabel('Size of Target Pool \beta');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);
