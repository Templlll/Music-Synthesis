function yt3 = get_yt3(phi, psi, theta, t3)
    Q = rotation_matrix(phi, psi, theta);
    t_3 = Q * t3;
    yt3 = t_3(2);
end
