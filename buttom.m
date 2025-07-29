function buttom(ax,a,feature)
    fs=8000;
    quarterNote=0.5;
    freq_5=523.25;
    freq_6=freq_5*2^(2/12);
    freq_2=freq_5*2^(-5/12);
    freq_1=freq_5*2^(-7/12);
    freq_6dot=freq_5*2^(-10/12);
    if feature==1
    generateNote = @(f,duration) ((sin(2*pi*f*(0:1/fs:duration))+sin(4*pi*f*(0:1/fs:duration))*0.2+sin(6*pi*f*(0:1/fs:duration))*0.3).*exp(a*(0:1/fs:duration)/duration));
    elseif feature==2
    generateNote = @(f,duration) ((sin(2*pi*f*(0:1/fs:duration))+sin(4*pi*f*(0:1/fs:duration))*0.2+sin(6*pi*f*(0:1/fs:duration))*0.3)*3.*((0:1/fs:duration)/duration).^0.5.*exp(a*(0:1/fs:duration)/duration));
    elseif feature==3
    generateNote = @(f,duration) ((sin(2*pi*f*(0:1/fs:duration))+sin(4*pi*f*(0:1/fs:duration))*1.46+sin(6*pi*f*(0:1/fs:duration))*0.96+sin(8*pi*f*(0:1/fs:duration))*1.1).*exp(a*(0:1/fs:duration)/duration));
    end
    
    note5_4 = generateNote(freq_5, quarterNote);
    note5_8 = generateNote(freq_5, quarterNote/2);
    note6_8 = generateNote(freq_6, quarterNote/2);
    note2_2 = generateNote(freq_2, quarterNote*2);
    note1_4 = generateNote(freq_1, quarterNote);
    note1_8 = generateNote(freq_1, quarterNote/2);
    note6dot_8 = generateNote(freq_6dot, quarterNote/2);

    to_display=[note5_4,note5_8,note6_8,note2_2,note1_4,note1_8,note6dot_8,note2_2];
    sound(to_display, fs);


    % 计算时间轴
    t = (0:length(to_display)-1)/fs; 
    axes(ax); % 切换绘图目标到 App 的坐标轴
    cla(ax);  % 清除原有图形
    % 绘制波形图
    plot(ax,t, to_display);
    xlabel(ax,'时间（秒）');
    ylabel(ax,'振幅');
    title(ax,'音频信号波形');
    grid(ax,'on');
end