clear;

alpha = 0.2;
beta1 = 0.1;
beta2 = 0.1;
c=1;
nround = 1000000000;

ra = 0;

x0_two = [0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5; 0.5];
A_two = [1,1,0,0,0,0,0,0,0,0; 0,0,1,1,0,0,0,0,0,0; 0,0,0,0,1,1,0,0,0,0; 0,0,0,0,0,0,1,1,0,0; 0,0,0,0,0,0,0,0,1,1];
b_two = [1, 1, 1, 1, 1];
Aeq_two = [];
beq_two = [];
VLB_two = [0; 0; 0; 0; 0; 0; 0; 0; 0; 0];
VUB_two = [1; 1; 1; 1; 1; 1; 1; 1; 1; 1];

%x0_faw = [0.5; 0.5];
%VLB_faw = [0; 0];
%VUB_faw = [1; 1];

[x, reward] = fmincon(@(x) bit_two_reward_modify(x, alpha, beta1, beta2, c), x0_two, A_two, b_two, Aeq_two, beq_two, VLB_two, VUB_two);
%[x, reward] = fmincon(@(x) bit_two_faw_reward(x, alpha, beta1, beta2, c(k)), x0, A, b, Aeq, beq, VLB, VUB);
%x(3) = x(1);
%x(4) = x(2);
%x(5) = x(1);
%x(6) = x(2);
    
p1bar1 = x(1);
p2bar1 = x(2);
    
a = alpha;
% x1, x3
p1bar12c4 = (x(3)+x(1)*(1-x(3)*a-x(4)*a))/(2-x(3)*a-x(4)*a);
% x2, x4
p2bar12c4 = (x(4)+x(2)*(1-x(3)*a-x(4)*a))/(2-x(3)*a-x(4)*a);
% x1, x5
p1bar12c5 = (x(5)+x(1)*(1-x(5)*a-x(6)*a))/(2-x(5)*a-x(6)*a);
% x2, x6
p2bar12c5 = (x(6)+x(2)*(1-x(5)*a-x(6)*a))/(2-x(5)*a-x(6)*a);
% x1, x3, x7
p1bar123c4 = (x(7)+(x(1)+x(3))*(1-x(7)*a-x(8)*a))/(3-2*x(7)*a-2*x(8)*a);
% x2, x4, x8
p2bar123c4 = (x(8)+(x(2)+x(4))*(1-x(7)*a-x(8)*a))/(3-2*x(7)*a-2*x(8)*a);
% x1, x5, x9
p1bar123c5 = (x(9)+(x(1)+x(5))*(1-x(9)*a-x(10)*a))/(3-2*x(9)*a-2*x(10)*a);
% x2, x6, x10
p2bar123c5 = (x(10)+(x(2)+x(6))*(1-x(9)*a-x(10)*a))/(3-2*x(9)*a-2*x(10)*a);

    for i=1:nround
        block = rand();
        if block <= alpha-p1bar1*alpha-p2bar1*alpha
            ra = ra +1;
            continue;
        elseif alpha<block && block<=alpha+beta1
            ra = ra + p1bar1*alpha/(beta1+p1bar1*alpha);
            continue;
        elseif alpha+beta1<block && block<=alpha+beta1+beta2
            ra = ra + p2bar1*alpha/(beta2+p2bar1*alpha);
            continue;
        elseif alpha+beta1+beta2<block
            continue;

        elseif alpha-p1bar1*alpha-p2bar1*alpha<block && block<=alpha-p2bar1*alpha % infil p1
            nblock = rand();
            if nblock <= (alpha-x(3)*alpha-x(4)*alpha)/(1-x(3)*alpha) % innocent
                ra = ra +1;
                continue;
            elseif (alpha-x(3)*alpha)/(1-x(3)*alpha)<nblock && nblock<=(alpha-x(3)*alpha+beta1)/(1-x(3)*alpha) % p1
                ra = ra + p1bar12c4*alpha/(beta1+p1bar12c4*alpha);
                continue;
            elseif (alpha-x(3)*alpha+beta1)/(1-x(3)*alpha)<nblock && nblock<=(alpha-x(3)*alpha+beta1+beta2)/(1-x(3)*alpha) %p2
                ra = ra + p2bar12c4*alpha/(beta2+p2bar12c4*alpha);
                continue;
            elseif (alpha-x(3)*alpha+beta1+beta2)/(1-x(3)*alpha)<nblock % others
                crand = rand();
                if crand <= c
                    ra = ra + p1bar12c4*alpha/(beta1+p1bar12c4*alpha);
                    continue;
                end
                continue;

            elseif (alpha-x(3)*alpha-x(4)*alpha)/(1-x(3)*alpha)<nblock && nblock<=(alpha-x(3)*alpha)/(1-x(3)*alpha) % infil p2
                mblock = rand();
                if mblock <= (alpha-x(7)*alpha-x(8)*alpha)/(1-x(7)*alpha-x(8)*alpha) % innocent
                    ra = ra +1;
                    continue;
                elseif (alpha-x(7)*alpha-x(8)*alpha)/(1-x(7)*alpha-x(8)*alpha)<mblock && mblock<=(alpha-x(7)*alpha-x(8)*alpha+beta1)/(1-x(7)*alpha-x(8)*alpha) %p1
                    ra = ra + p1bar123c4*alpha/(beta1+p1bar123c4*alpha);
                    continue;
                elseif (alpha-x(7)*alpha-x(8)*alpha+beta1)/(1-x(7)*alpha-x(8)*alpha)<mblock && mblock<=(alpha-x(7)*alpha-x(8)*alpha+beta1+beta2)/(1-x(7)*alpha-x(8)*alpha) %p2
                    ra = ra + p2bar123c4*alpha/(beta2+p1bar123c4*alpha);
                    continue;
                elseif (alpha-x(7)*alpha-x(8)*alpha+beta1+beta2)/(1-x(7)*alpha-x(8)*alpha)<mblock % others
                    crand = rand();
                    if crand<=c/2
                        ra = ra + p1bar123c4*alpha/(beta1+p1bar123c4*alpha);
                        continue;
                    elseif c/2<crand && crand<=c
                        ra = ra + p2bar123c4*alpha/(beta2+p2bar123c4*alpha);
                        continue;
                    end
                    continue;
                end
            end
            continue;


        elseif alpha-p2bar1*alpha<block && block<=alpha % infil p2
            nblock = rand();
            if nblock <= (alpha-x(5)*alpha-x(6)*alpha)/(1-x(6)*alpha) % innocent
                ra = ra +1;
                continue;
            elseif (alpha-x(6)*alpha)/(1-x(6)*alpha)<nblock && nblock<=(alpha-x(6)*alpha+beta1)/(1-x(6)*alpha) % p1
                ra = ra + p1bar12c5*alpha/(beta1+p1bar12c5*alpha);
                continue;
            elseif (alpha-x(6)*alpha+beta1)/(1-x(6)*alpha)<nblock && nblock<=(alpha-x(6)*alpha+beta1+beta2)/(1-x(6)*alpha) %p2
                ra = ra + p2bar12c5*alpha/(beta2+p2bar12c5*alpha);
                continue;
            elseif (alpha-x(6)*alpha+beta1+beta2)/(1-x(6)*alpha)<nblock % others
                crand = rand();
                if crand <= c
                    ra = ra + p2bar12c5*alpha/(beta2+p2bar12c5*alpha);
                    continue;
                end
                continue;

            elseif (alpha-x(5)*alpha-x(6)*alpha)/(1-x(6)*alpha)<nblock && nblock<=(alpha-x(6)*alpha)/(1-x(6)*alpha) % infil p1
                mblock = rand();
                if mblock <= (alpha-x(9)*alpha-x(10)*alpha)/(1-x(9)*alpha-x(10)*alpha) % innocent
                    ra = ra +1;
                    continue;
                elseif (alpha-x(9)*alpha-x(10)*alpha)/(1-x(9)*alpha-x(10)*alpha)<mblock && mblock<=(alpha-x(9)*alpha-x(10)*alpha+beta1)/(1-x(9)*alpha-x(10)*alpha) %p1
                    ra = ra + p1bar123c5*alpha/(beta1+p1bar123c5*alpha);
                    continue;
                elseif (alpha-x(9)*alpha-x(10)*alpha+beta1)/(1-x(9)*alpha-x(10)*alpha)<mblock && mblock<=(alpha-x(9)*alpha-x(10)*alpha+beta1+beta2)/(1-x(9)*alpha-x(10)*alpha) %p2
                    ra = ra + p2bar123c5*alpha/(beta2+p1bar123c5*alpha);
                    continue;
                elseif (alpha-x(9)*alpha-x(10)*alpha+beta1+beta2)/(1-x(9)*alpha-x(10)*alpha)<mblock % others
                    crand = rand();
                    if crand<=c/2
                        ra = ra + p1bar123c5*alpha/(beta1+p1bar123c5*alpha);
                        continue;
                    elseif c/2<crand && crand<=c
                        ra = ra + p2bar123c5*alpha/(beta2+p2bar123c5*alpha);
                        continue;
                    end
                end
            end
        end
    end

raa = (ra/nround-alpha)/alpha*100

