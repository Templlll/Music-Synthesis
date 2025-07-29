function xt2 = get_xt2(phi, psi, theta, t2)
    Q = rotation_matrix(phi, psi, theta);
    t_2 = Q * t2;
    xt2 = t_2(1);
end