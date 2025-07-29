function yt2 = get_yt2(phi, psi, theta, t2)
    Q = rotation_matrix(phi, psi, theta);
    t_2 = Q * t2;
    yt2 = t_2(2);
end