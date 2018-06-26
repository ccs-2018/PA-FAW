clear;
beta = 0.005:0.005:0.5;
c = 0:0.01:1;
aplha = 0.2;

x0 = [0.5; 0.5];
A = [];
b = [];
Aeq = [];
beq = [];
VLB = [0; 0];
VUB = [1; 1];
for i = 1:101
    for j = 1:100
        disp(['At i=', num2str(i), ', j=', num2str(j), '.'])
        [x, reward] = fmincon(@(x) bit_faw_reward(x, aplha, beta(j), c(i)), x0, A, b, Aeq, beq, VLB, VUB);
        z(i, j) = 0 - reward;
        pool(i, j) = beta(j)+x(1)*aplha*(beta(j)+c(i)*(1-aplha-beta(j)))/(1-x(1)*aplha);
        pool_inno = beta(j)+x(1)*aplha;
        pool(i, j) = (pool(i, j)-pool_inno)/pool_inno*100;
    end
end

z = (z-aplha)/aplha*100;


imagesc(beta, c, z);
cb = colorbar;
cb.Label.String = 'Expected Relative Extra Reward (%)';
set(gca, 'YDir', 'normal')
xlabel('Size of Target Pool \beta');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);

pause;

imagesc(beta, c, pool);
cb = colorbar;
cb.Label.String = 'Expected Relative Extra Reward (%)';
set(gca, 'YDir', 'normal')
xlabel('Size of Target Pool \beta');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);