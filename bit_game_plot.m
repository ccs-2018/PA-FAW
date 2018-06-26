clear;
digits(64);
step = 100;
a1 = 0.2;
a2 = 0.5/step:0.5/step:0.5;
c = 0:1/step:1;

p1balancea2 = [];
p1balancec = [];
p2balancea2 = [];
p2balancec = [];
p1first = 1;
p2first = 1;

for i = 1:(step+1)
    for j = 1:step
        disp(['At i=', num2str(i), ', j=', num2str(j), '.'])
        x0 = [0; 0];
        A = [];
        b = [];
        Aeq = [];
        beq = [];
        VLB = [0; 0];
        VUBx = [a1; a1];
        VUBy = [a2(j); a2(j)];

        x = [0 0];
        y = [0 0];
        xold = x;
        yold = y;

        [x, p1_reward] = fmincon(@(x) bit_game_p1_reward(x, y, a1, a2(j), c(i)), x0, A, b, Aeq, beq, VLB, VUBx);
        [y, p2_reward] = fmincon(@(y) bit_game_p2_reward(x, y, a1, a2(j), c(i)), x0, A, b, Aeq, beq, VLB, VUBy);

        while xold(1) ~= x(1) && xold(2) ~= x(2) && yold(1) ~= y(1) && yold(2) ~= y(2)
            % function r = bit_game_p1_reward(x, y, a1, a2, c)
            [x, p1_reward] = fmincon(@(x) bit_game_p1_reward(x, y, a1, a2(j), c(i)), x0, A, b, Aeq, beq, VLB, VUBx);
            xold = x;
            [y, p2_reward] = fmincon(@(y) bit_game_p2_reward(x, y, a1, a2(j), c(i)), x0, A, b, Aeq, beq, VLB, VUBy);
            yold = y;
        end
        
        c1=c(i);
        c2=c(i)/2;
        
        p1c1 = a1-x(1);
        p1c2 = x(1)*(a1-x(2))/(1-x(2));
        p1c3 = y(1)*(a1-x(1))/(1-y(2));
        p1c4 = x(1)*y(1)*(a1-x(2))/(1-x(2))/(1-x(2)-y(2));
        p1c5 = y(1)*x(1)*(a1-x(2))/(1-y(2))/(1-x(2)-y(2));
        p1c6 = c1*y(1)*(1-a1-a2(j))/(1-y(2));
        p1c7 = c2*x(1)*y(1)*(1-a1-a2(j))/(1-x(2))/(1-x(2)-y(2));
        p1c8 = c2*y(1)*x(1)*(1-a1-a2(j))/(1-y(2))/(1-x(2)-y(2));

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
        
        p2c1 = a2(j)-y(1);
        p2c2 = y(1)*(a2(j)-y(2))/(1-y(2));
        p2c3 = x(1)*(a2(j)-y(1))/(1-x(2));
        p2c4 = y(1)*x(1)*(a2(j)-y(2))/(1-y(2))/(1-y(2)-x(2));
        p2c5 = x(1)*y(1)*(a2(j)-y(2))/(1-x(2))/(1-y(2)-x(2));
        p2c6 = c1*x(1)*(1-a1-a2(j))/(1-x(2));
        p2c7 = c2*y(1)*x(1)*(1-a2(j)-a1)/(1-y(2))/(1-y(2)-x(2));
        p2c8 = c2*x(1)*y(1)*(1-a2(j)-a1)/(1-x(2))/(1-y(2)-x(2));

        sp1c1 = p2c1*f1_1/(a2(j)+f1_1);
        sp1c2 = p2c2*f1_1/(a2(j)+f1_1);
        sp1c3 = p2c3*f1_12/(a2(j)+f1_12);
        sp1c4 = p2c4*f1_112/(a2(j)+f1_112);
        sp1c5 = p2c5*f1_122/(a2(j)+f1_122);
        sp1c6 = p2c6*f1_12/(a2(j)+f1_12);
        sp1c7 = p2c7*f1_112/(a2(j)+f1_112);
        sp1c8 = p2c8*f1_122/(a2(j)+f1_122);
        
        p1fp1 = a1/(a1+f2_1)*p1c1/(1-q_function(f2_1, f1_1, a1, a2(j)))+a1/(a1+f2_1)*p1c2/(1-q_function(f2_1, f1_12, a1, a2(j)))+a1/(a1+f2_12)*(p1c3+p1c6)/(1-q_function(f2_12, f1_1, a1, a2(j)))+a1/(a1+f2_112)*(p1c4+p1c7)/(1-q_function(f2_112, f1_122, a1, a2(j)))+a1/(a1+f2_122)*(p1c5+p1c8)/(1-q_function(f2_122, f1_112, a1, a2(j)));
        sp2fp1 = a2(j)/(a2(j)+f1_1)*sp2c1/(1-q_function(f2_1, f1_1, a1, a2(j)))+a2(j)/(a2(j)+f1_12)*sp2c2/(1-q_function(f2_1, f1_12, a1, a2(j)))+a2(j)/(a2(j)+f1_1)*(sp2c3+sp2c6)/(1-q_function(f2_12, f1_1, a1, a2(j)))+a2(j)/(a2(j)+f1_122)*(sp2c4+sp2c7)/(1-q_function(f2_112, f1_122, a1, a2(j)))+a2(j)/(a2(j)+f1_112)*(sp2c5+sp2c8)/(1-q_function(f2_122, f1_112, a1, a2(j)));
        
        p2fp2 = a2(j)/(a2(j)+f1_1)*p2c1/(1-q_function(f1_1, f2_1, a2(j), a1))+a2(j)/(a2(j)+f1_1)*p2c2/(1-q_function(f1_1, f2_12, a2(j), a1))+a2(j)/(a2(j)+f1_12)*(p2c3+p2c6)/(1-q_function(f1_12, f2_1, a2(j), a1))+a2(j)/(a2(j)+f1_112)*(p2c4+p2c7)/(1-q_function(f1_112, f2_122, a2(j), a1))+a2(j)/(a2(j)+f1_122)*(p2c5+p2c8)/(1-q_function(f1_122, f2_112, a2(j), a1));
        sp1fp2 = a1/(a1+f2_1)*sp1c1/(1-q_function(f1_1, f2_1, a2(j), a1))+a1/(a1+f2_12)*sp1c2/(1-q_function(f1_1, f2_12, a2(j), a1))+a1/(a1+f2_1)*(sp1c3+sp1c6)/(1-q_function(f1_12, f2_1, a2(j), a1))+a1/(a1+f2_122)*(sp1c4+sp1c7)/(1-q_function(f1_112, f2_122, a2(j), a1))+a1/(a1+f2_112)*(sp1c5+sp1c8)/(1-q_function(f1_122, f2_112, a2(j), a1));
        r_p1 = p1fp1+sp1fp2;
        r_p2 = p2fp2+sp2fp1;
        
        rp1(i, j) = (r_p1-a1)/(a1)*100;
        rp2(i, j) = (r_p2-a2(j))/(a2(j))*100;
        
        %if p1first==1 && rp1(i, j)<=0
        %    p1balancea2 = [p1balancea2, a2(j)];
        %    p1balancec = [p1balancec, c(i)];
        %    p1first = 0;
        %end
        if j>1 && rp1(i, j)<=0 && rp1(i, j-1)>0
            p1balancea2 = [p1balancea2, a2(j)];
            p1balancec = [p1balancec, c(i)];
        end
        
        %if p2first==1 && rp2(i, j)<=0
        %    p2balancea2 = [p2balancea2, a2(j)];
        %    p2balancec = [p2balancec, c(i)];
        %    p2first = 0;
        %end
        if j>1 && rp2(i, j)>=0 && rp2(i, j-1)<0
            p2balancea2 = [p2balancea2, a2(j)];
            p2balancec = [p2balancec, c(i)];
        end
        
        
        fp1_1(i, j) = x(1);
        fp1_2(i, j) = x(2);
        fp2_1(i, j) = y(1);
        fp2_2(i, j) = y(2);
    end
end

imagesc(a2, c, rp1);
hold on
plot(p1balancea2,p1balancec,'k','LineWidth',2);
cb = colorbar;
cb.Label.String = 'Pure RER of Pool_1 (%)';
set(gca, 'YDir', 'normal')
xlabel('\alpha^{[2]}');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);
hold off

imagesc(a2, c, rp2);
hold on
plot(p2balancea2,p2balancec,'k','LineWidth',2);
cb = colorbar;
cb.Label.String = 'Pure RER of Pool_2 (%)';
set(gca, 'YDir', 'normal')
xlabel('\alpha^{[2]}');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);
hold off

imagesc(a2, c, fp1_1);
cb = colorbar;
cb.Label.String = 'Pool_1''s infiltration mining f^{[1]}_1';
set(gca, 'YDir', 'normal')
xlabel('\alpha^{[2]}');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);

imagesc(a2, c, fp2_1);
cb = colorbar;
cb.Label.String = 'Pool_2''s infiltration mining f^{[2]}_1';
set(gca, 'YDir', 'normal')
xlabel('\alpha^{[2]}');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);

imagesc(a2, c, fp1_2);
cb = colorbar;
cb.Label.String = 'Pool_1''s infiltration mining f^{[1]}_2';
set(gca, 'YDir', 'normal')
xlabel('\alpha^{[2]}');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);

imagesc(a2, c, fp2_2);
cb = colorbar;
cb.Label.String = 'Pool_2''s infiltration mining f^{[2]}_2';
set(gca, 'YDir', 'normal')
xlabel('\alpha^{[2]}');
ylabel('Coefficient c');
set(gca,'FontName', 'Times New Roman');
axis([0 0.5 0 1]);
