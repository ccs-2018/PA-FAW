clear;
digits(32);
step = 500;
a1 = 0.5/step:0.5/step:0.5;
a2 = 0.5/step:0.5/step:0.5;
c = 0.2:0.1:1;

for k=1:9
    jstart = 1;
    p1balancea1 = [];
    p1balancea2 = [];
    for i = 1:step % a2
        isfound = 0;
        for j = jstart:step % a1
            disp(['At k=', num2str(k), ', i=', num2str(i), ', j=', num2str(j), '.'])
            % c(k) a1(j) a2(i)
            x0 = [0; 0];
            A = [];
            b = [];
            Aeq = [];
            beq = [];
            VLB = [0; 0];
            VUBx = [a1(j); a1(j)];
            VUBy = [a2(i); a2(i)];

            x = [0 0];
            y = [0 0];
            xold = x;
            yold = y;

            [x, p1_reward] = fmincon(@(x) bit_game_p1_reward(x, y, a1(j), a2(i), c(k)), x0, A, b, Aeq, beq, VLB, VUBx);
            [y, p2_reward] = fmincon(@(y) bit_game_p2_reward(x, y, a1(j), a2(i), c(k)), x0, A, b, Aeq, beq, VLB, VUBy);

            while xold(1) ~= x(1) && xold(2) ~= x(2) && yold(1) ~= y(1) && yold(2) ~= y(2)
                [x, p1_reward] = fmincon(@(x) bit_game_p1_reward(x, y, a1(j), a2(i), c(k)), x0, A, b, Aeq, beq, VLB, VUBx);
                xold = x;
                [y, p2_reward] = fmincon(@(y) bit_game_p2_reward(x, y, a1(j), a2(i), c(k)), x0, A, b, Aeq, beq, VLB, VUBy);
                yold = y;
            end
            
            c1=c(k);
            c2=c(k)/2;
        
            p1c1 = a1(j)-x(1);
            p1c2 = x(1)*(a1(j)-x(2))/(1-x(2));
            p1c3 = y(1)*(a1(j)-x(1))/(1-y(2));
            p1c4 = x(1)*y(1)*(a1(j)-x(2))/(1-x(2))/(1-x(2)-y(2));
            p1c5 = y(1)*x(1)*(a1(j)-x(2))/(1-y(2))/(1-x(2)-y(2));
            p1c6 = c1*y(1)*(1-a1(j)-a2(i))/(1-y(2));
            p1c7 = c2*x(1)*y(1)*(1-a1(j)-a2(i))/(1-x(2))/(1-x(2)-y(2));
            p1c8 = c2*y(1)*x(1)*(1-a1(j)-a2(i))/(1-y(2))/(1-x(2)-y(2));

            f1_1 = x(1);
            f1_12 = (x(1)+x(2)-x(1)*x(2))/(2-x(2));
            f1_112 = (2*x(1)*(1-y(2)-x(2))+x(2))/(3-2*y(2)-2*x(2));
            f1_122 = ((x(1)+x(2))*(1-y(2)-x(2))+x(2))/(3-2*y(2)-2*x(2));

            f2_1 = y(1);
            f2_12 = (y(1)+y(2)-y(1)*y(2))/(2-y(2));
            f2_112 = (2*y(1)*(1-x(2)-y(2))+y(2))/(3-2*x(2)-2*y(2));
            f2_122 = ((y(1)+y(2))*(1-x(2)-y(2))+y(2))/(3-2*x(2)-2*y(2));

            sp2c1 = p1c1*f2_1/(a1(j)+f2_1);
            sp2c2 = p1c2*f2_1/(a1(j)+f2_1);
            sp2c3 = p1c3*f2_12/(a1(j)+f2_12);
            sp2c4 = p1c4*f2_112/(a1(j)+f2_112);
            sp2c5 = p1c5*f2_122/(a1(j)+f2_122);
            sp2c6 = p1c6*f2_12/(a1(j)+f2_12);
            sp2c7 = p1c7*f2_112/(a1(j)+f2_112);
            sp2c8 = p1c8*f2_122/(a1(j)+f2_122);

            p2c1 = a2(i)-y(1);
            p2c2 = y(1)*(a2(i)-y(2))/(1-y(2));
            p2c3 = x(1)*(a2(i)-y(1))/(1-x(2));
            p2c4 = y(1)*x(1)*(a2(i)-y(2))/(1-y(2))/(1-y(2)-x(2));
            p2c5 = x(1)*y(1)*(a2(i)-y(2))/(1-x(2))/(1-y(2)-x(2));
            p2c6 = c1*x(1)*(1-a1(j)-a2(i))/(1-x(2));
            p2c7 = c2*y(1)*x(1)*(1-a2(i)-a1(j))/(1-y(2))/(1-y(2)-x(2));
            p2c8 = c2*x(1)*y(1)*(1-a2(i)-a1(j))/(1-x(2))/(1-y(2)-x(2));

            sp1c1 = p2c1*f1_1/(a2(i)+f1_1);
            sp1c2 = p2c2*f1_1/(a2(i)+f1_1);
            sp1c3 = p2c3*f1_12/(a2(i)+f1_12);
            sp1c4 = p2c4*f1_112/(a2(i)+f1_112);
            sp1c5 = p2c5*f1_122/(a2(i)+f1_122);
            sp1c6 = p2c6*f1_12/(a2(i)+f1_12);
            sp1c7 = p2c7*f1_112/(a2(i)+f1_112);
            sp1c8 = p2c8*f1_122/(a2(i)+f1_122);

            p1fp1 = a1(j)/(a1(j)+f2_1)*p1c1/(1-q_function(f2_1, f1_1, a1(j), a2(i)))+a1(j)/(a1(j)+f2_1)*p1c2/(1-q_function(f2_1, f1_12, a1(j), a2(i)))+a1(j)/(a1(j)+f2_12)*(p1c3+p1c6)/(1-q_function(f2_12, f1_1, a1(j), a2(i)))+a1(j)/(a1(j)+f2_112)*(p1c4+p1c7)/(1-q_function(f2_112, f1_122, a1(j), a2(i)))+a1(j)/(a1(j)+f2_122)*(p1c5+p1c8)/(1-q_function(f2_122, f1_112, a1(j), a2(i)));
            sp2fp1 = a2(i)/(a2(i)+f1_1)*sp2c1/(1-q_function(f2_1, f1_1, a1(j), a2(i)))+a2(i)/(a2(i)+f1_12)*sp2c2/(1-q_function(f2_1, f1_12, a1(j), a2(i)))+a2(i)/(a2(i)+f1_1)*(sp2c3+sp2c6)/(1-q_function(f2_12, f1_1, a1(j), a2(i)))+a2(i)/(a2(i)+f1_122)*(sp2c4+sp2c7)/(1-q_function(f2_112, f1_122, a1(j), a2(i)))+a2(i)/(a2(i)+f1_112)*(sp2c5+sp2c8)/(1-q_function(f2_122, f1_112, a1(j), a2(i)));

            p2fp2 = a2(i)/(a2(i)+f1_1)*p2c1/(1-q_function(f1_1, f2_1, a2(i), a1(j)))+a2(i)/(a2(i)+f1_1)*p2c2/(1-q_function(f1_1, f2_12, a2(i), a1(j)))+a2(i)/(a2(i)+f1_12)*(p2c3+p2c6)/(1-q_function(f1_12, f2_1, a2(i), a1(j)))+a2(i)/(a2(i)+f1_112)*(p2c4+p2c7)/(1-q_function(f1_112, f2_122, a2(i), a1(j)))+a2(i)/(a2(i)+f1_122)*(p2c5+p2c8)/(1-q_function(f1_122, f2_112, a2(i), a1(j)));
            sp1fp2 = a1(j)/(a1(j)+f2_1)*sp1c1/(1-q_function(f1_1, f2_1, a2(i), a1(j)))+a1(j)/(a1(j)+f2_12)*sp1c2/(1-q_function(f1_1, f2_12, a2(i), a1(j)))+a1(j)/(a1(j)+f2_1)*(sp1c3+sp1c6)/(1-q_function(f1_12, f2_1, a2(i), a1(j)))+a1(j)/(a1(j)+f2_122)*(sp1c4+sp1c7)/(1-q_function(f1_112, f2_122, a2(i), a1(j)))+a1(j)/(a1(j)+f2_112)*(sp1c5+sp1c8)/(1-q_function(f1_122, f2_112, a2(i), a1(j)));
            r_p1 = p1fp1+sp1fp2;
            r_p2 = p2fp2+sp2fp1;

            rp1(i, j) = (r_p1-a1(j))/(a1(j))*100;
            rp2(i, j) = (r_p2-a2(i))/(a2(i))*100;
            
            if j==jstart && rp1(i, j)>=0
                p1balancea1 = [p1balancea1 a1(j)];
                p1balancea2 = [p1balancea2 a2(i)];
                jstart = j;
                isfound = 1;
                break;
            elseif j>1 && rp1(i, j)>=0 && rp1(i, j-1)<0
                p1balancea1 = [p1balancea1 a1(j)];
                p1balancea2 = [p1balancea2 a2(i)];
                jstart = j;
                isfound = 1;
                break;
            end
            
            %{
            if j==jstart && rp2(i, j)<=0
                p1balancea1 = [p1balancea1 a1(j)];
                p1balancea2 = [p1balancea2 a2(i)];
                jstart = j;
                isfound = 1;
                break;
            elseif j>1 && rp2(i, j)<=0 && rp2(i, j-1)>0
                p1balancea1 = [p1balancea1 a1(j)];
                p1balancea2 = [p1balancea2 a2(i)];
                jstart = j;
                isfound = 1;
                break;
            end
            %}
            
            
        end
        if isfound == 0;
            break;
        end
    end
    a1name = sprintf('game_p1wdc%da1.txt',c(k));
    a2name = sprintf('game_p1wdc%da2.txt',c(k));
    save(a1name, 'p1balancea1','-ASCII');
    save(a2name, 'p1balancea2','-ASCII');
    plot(p1balancea1,p1balancea2,'LineWidth',2);
    hold on
end


grid on;
ylabel('\alpha_2');
xlabel('\alpha_1');
legend('c=1', 'c=0.9', 'c=0.8', 'c=0.7', 'c=0.6', 'c=0.5', 'c=0.4', 'c=0.3', 'c=0.2')
axis([0 0.5 0 0.5]);
set(gca,'FontName', 'Times New Roman');
hold off

%legend('c=0.1', 'c=0.2', 'c=0.3', 'c=0.4', 'c=0.5', 'c=0.6', 'c=0.7', 'c=0.8', 'c=0.9', 'c=1')
%set(gca,'FontName', 'Times New Roman');
