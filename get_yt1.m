function yt1 = get_yt1(phi, psi, theta, t1)
    Q = rotation_matrix(phi, psi, theta);
    t_1 = Q * t1;
    yt1 = t_1(2);
end