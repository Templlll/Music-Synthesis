clear;
clc;
L=15*3^0.5;
c=1;
xa=-6.20526*0.5;
ya=-6.20526*3^0.5*0.5;
za=2.75000;
xb=-6.20526*0.5;
yb=6.20526*3^0.5*0.5;
zb=2.750;
xc=6.20526;
yc=0;
zc=2.750;
l1=15;
l2=10;

theta1_list=[];
theta2_list=[];
theta3_list=[];
for phi=0:pi/30:2*pi
    a=0.2*cos(phi);
    b=0.2*sin(phi);
    syms  xt_1 yt_1 zt_1 xt_2 yt_2 zt_2 xt_3 yt_3 zt_3
    eq1=a*xt_1+b*yt_1+c*zt_1-18*c==0;
    eq2=a*xt_2+b*yt_2+c*zt_2-18*c==0;
    eq3=a*xt_3+b*yt_3+c*zt_3-18*c==0;
    eq4=(xt_2-xt_1)^2+(yt_2-yt_1)^2+(zt_2-zt_1)^2-L^2==0;
    eq5=(xt_3-xt_2)^2+(yt_3-yt_2)^2+(zt_3-zt_2)^2-L^2==0;
    eq6=(xt_1-xt_3)^2+(yt_1-yt_3)^2+(zt_1-zt_3)^2-L^2==0;
    eq7=yt_1-xt_1*3^0.5==0;
    eq8=yt_2+xt_2*3^0.5==0;
    eq9=yt_3==0;
    eqns=[eq1,eq2,eq3,eq4,eq5,eq6,eq7,eq8,eq9];
    sol=solve(eqns,[xt_1 yt_1 zt_1 xt_2 yt_2 zt_2 xt_3 yt_3 zt_3]);
    if isempty(sol.xt_1)
        error('无解');
    else
        % 遍历所有解，筛选符合条件的实数解
        valid_solutions = [];
        for k = 1:length(sol.xt_1)
            % 检查是否为实数解
            if all(imag([sol.xt_1(k), sol.yt_1(k), sol.zt_1(k), ...
                        sol.xt_2(k), sol.yt_2(k), sol.zt_2(k), ...
                        sol.xt_3(k), sol.yt_3(k), sol.zt_3(k)]) == 0)

                % 提取坐标
                xt1 = real(double(sol.xt_1(k)));
                yt1 = real(double(sol.yt_1(k)));
                zt1 = real(double(sol.zt_1(k)));
                xt2 = real(double(sol.xt_2(k)));
                yt2 = real(double(sol.yt_2(k)));
                zt2 = real(double(sol.zt_2(k)));
                xt3 = real(double(sol.xt_3(k)));
                yt3 = real(double(sol.yt_3(k)));
                zt3 = real(double(sol.zt_3(k)));

                % 条件1: T1与A在BC同侧 (叉积判断)
                vec_BC = [xc - xb, yc - yb];
                vec_BA = [xa - xb, ya - yb];
                cross_A = vec_BC(1)*vec_BA(2) - vec_BC(2)*vec_BA(1);
                vec_BT1 = [xt1 - xb, yt1 - yb];
                cross_T1 = vec_BC(1)*vec_BT1(2) - vec_BC(2)*vec_BT1(1);
                cond1 = sign(cross_A) == sign(cross_T1);

                % 条件2: T2与B在AC同侧
                vec_AC = [xc - xa, yc - ya];
                vec_AB = [xb - xa, yb - ya];
                cross_B = vec_AC(1)*vec_AB(2) - vec_AC(2)*vec_AB(1);
                vec_AT2 = [xt2 - xa, yt2 - ya];
                cross_T2 = vec_AC(1)*vec_AT2(2) - vec_AC(2)*vec_AT2(1);
                cond2 = sign(cross_B) == sign(cross_T2);

                % 条件3: T3与C在AB同侧 (x坐标比较)
                cond3 = (xt3 > xa) == (xc > xa); % AB线为垂直于x轴的直线

                if cond1 && cond2 && cond3
                    valid_solutions = [valid_solutions; k];
                end
            end
        end

        if isempty(valid_solutions)
            error('无符合条件的解');
        else
            % 取第一个符合条件的解
            idx = valid_solutions(1);
            xt_1 = real(double(sol.xt_1(idx)));
            yt_1 = real(double(sol.yt_1(idx)));
            zt_1 = real(double(sol.zt_1(idx)));
            xt_2 = real(double(sol.xt_2(idx)));
            yt_2 = real(double(sol.yt_2(idx)));
            zt_2 = real(double(sol.zt_2(idx)));
            xt_3 = real(double(sol.xt_3(idx)));
            yt_3 = real(double(sol.yt_3(idx)));
            zt_3 = real(double(sol.zt_3(idx)));

            % 输出结果
            fprintf('符合条件的解：\n');
            fprintf('T1: (%.5f, %.5f, %.5f)\n', xt_1, yt_1, zt_1);
            fprintf('T2: (%.5f, %.5f, %.5f)\n', xt_2, yt_2, zt_2);
            fprintf('T3: (%.5f, %.5f, %.5f)\n', xt_3, yt_3, zt_3);
        end
    end
    syms  xd yd zd
    eq1=(xd-xa)^2+(yd-ya)^2+(zd-za)^2-l1^2==0;
    eq2=(xd-xt_1)^2+(yd-yt_1)^2+(zd-zt_1)^2-l2^2==0;
    eq3=yd-xd*3^0.5==0;
    eqns=[eq1,eq2,eq3];
    sol=solve(eqns,[xd,yd,zd]);
    if ~isempty(sol.xd) & ~isempty(sol.yd) & ~isempty(sol.zd)
        % 转换数值解并过滤复数
        xd_val = double(sol.xd);
        yd_val = double(sol.yd);
        zd_val = double(sol.zd);
        real_mask =(imag(xd_val)==0) & (imag(yd_val)==0) & (imag(zd_val)==0);
        radius_condition =(xd_val.^2 + yd_val.^2 > 12^2);
        valid = real_mask & radius_condition;
        if any(valid)
            xd = real(double(xd_val(valid)));
            yd = real(double(yd_val(valid)));
            zd = real(double(zd_val(valid)));
            xd = xd(1);
            yd = yd(1);
            zd = zd(1);
        end
    end
    fprintf('D坐标: (%.3f, %.3f, %.3f)\n', xd, yd, zd);

    syms  xe ye ze
    eq1=(xe-xb)^2+(ye-yb)^2+(ze-zb)^2-l1^2==0;
    eq2=(xe-xt_2)^2+(ye-yt_2)^2+(ze-zt_2)^2-l2^2==0;
    eq3=ye+xe*3^0.5==0;
    eqns=[eq1,eq2,eq3];
    sol=solve(eqns,[xe,ye,ze]);
    if ~isempty(sol.xe) & ~isempty(sol.ye) & ~isempty(sol.ze)
        % 转换数值解并过滤复数
        xe_val = double(sol.xe);
        ye_val = double(sol.ye);
        ze_val = double(sol.ze);
        real_mask =(imag(xe_val)==0) & (imag(ye_val)==0) & (imag(ze_val)==0);
        radius_condition =(xe_val.^2 + ye_val.^2 > 12^2);
        valid = real_mask & radius_condition;
        if any(valid)
            xe = real(double(xe_val(valid)));
            ye = real(double(ye_val(valid)));
            ze = real(double(ze_val(valid)));
            xe = xe(1);
            ye = ye(1);
            ze = ze(1);
            fprintf('E坐标: (%.3f, %.3f, %.3f)\n', xe, ye, ze);
        end
    end

    syms  xf yf zf
    eq1=(xf-xc)^2+(yf-yc)^2+(zf-zc)^2-l1^2==0;
    eq2=(xf-xt_3)^2+(yf-yt_3)^2+(zf-zt_3)^2-l2^2==0;
    eq3=yf==0;
    eqns=[eq1,eq2,eq3];
    sol=solve(eqns,[xf,yf,zf]);
    if ~isempty(sol.xf) & ~isempty(sol.yf) & ~isempty(sol.zf)
        % 转换数值解并过滤复数
        xf_val = double(sol.xf);
        yf_val = double(sol.yf);
        zf_val = double(sol.zf);
        real_mask =(imag(xf_val)==0) & (imag(yf_val)==0) & (imag(zf_val)==0);
        radius_condition =(xf_val.^2 + yf_val.^2 > 12^2);
        valid = real_mask & radius_condition;
        if any(valid)
            xf = real(double(xf_val(valid)));
            yf = real(double(yf_val(valid)));
            zf = real(double(zf_val(valid)));
            xf = xf(1);
            yf = yf(1);
            zf = zf(1);
            fprintf('F坐标: (%.3f, %.3f, %.3f)\n\n', xf, yf, zf);
        end
    end

    theta1=atan2(zd-za,((xd-xa)^2+(yd-ya)^2)^0.5);
    theta2=atan2(ze-zb,((xe-xb)^2+(ye-yb)^2)^0.5);
    theta3=atan2(zf-zc,((xf-xc)^2+(yf-yc)^2)^0.5);
            theta1_list(end+1) = theta1;
            theta2_list(end+1) = theta2;
            theta3_list(end+1) = theta3;
  



end
disp(theta1_list);
disp(theta2_list);
disp(theta3_list);
save('spider_theta_data.mat', 'theta1_list', 'theta2_list','theta3_list');