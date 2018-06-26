function rwd = bit_get_reward_fun(aplha, beta, c)
    x0 = [0.5; 0.5];
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    VLB = [0; 0];
    VUB = [1; 1];
    [x, reward] = fmincon(@(x) bit_reward(x, aplha, beta, c), x0, A, b, Aeq, beq, VLB, VUB);
    rwd = 0 - reward;