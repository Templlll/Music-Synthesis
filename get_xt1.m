function xt1 = get_xt1(phi, psi, theta, t1)
    Q = rotation_matrix(phi, psi, theta);
    t_1 = Q * t1;
    xt1 = t_1(1);
end