function phi_solution = solve_phi(psi, theta)
    % 输入：psi（弧度）、theta（弧度）
    % 输出：满足条件的phi（弧度）

    % 定义三个点的坐标（列向量）
    t1 = [-7.5; -12.99; -2.364];
    t2 = [-7.5;  12.99; -2.364];
    t3 = [15;      0;   -2.364];

    % 定义非线性方程组
    fun = @(phi) [
        % eq1: yt_1 - xt_1*sqrt(3) = 0
        get_yt1(phi, psi, theta, t1) - get_xt1(phi, psi, theta, t1)*sqrt(3);
        
        % eq2: yt_2 + xt_2*sqrt(3) = 0
        get_yt2(phi, psi, theta, t2) + get_xt2(phi, psi, theta, t2)*sqrt(3);
        
        % eq3: yt_3 = 0
        get_yt3(phi, psi, theta, t3)
    ];

    % 初始猜测（可根据需要调整）
    phi0 = pi/2;
    
    % 求解非线性方程组
    options = optimoptions('fsolve', 'Display', 'off', 'TolFun', 1e-8);
    phi_solution = fsolve(fun, phi0, options);
    
    % 验证解的合理性
    if max(abs(fun(phi_solution))) < 1e-6
        disp(['解 phi = ', num2str(phi_solution), ' 弧度']);
    else
        error('未找到有效解');
    end
end
