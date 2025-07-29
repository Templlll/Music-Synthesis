fs=8000;
quarterNote=0.5;
freq_5=523.25;
freq_6=freq_5*2^(2/12);
freq_2=freq_5*2^(-5/12);
freq_1=freq_5*2^(-7/12);
freq_6dot=freq_5*2^(-10/12);

generateNote = @(f,duration) sin(2*pi*f*(0:1/fs:duration)).*exp(-5*(0:1/fs:duration)/duration);

note5_4 = generateNote(freq_5, quarterNote);
note5_8 = generateNote(freq_5, quarterNote/2);
note6_8 = generateNote(freq_6, quarterNote/2);
note2_2 = generateNote(freq_2, quarterNote*2);
note1_4 = generateNote(freq_1, quarterNote);
note1_8 = generateNote(freq_1, quarterNote/2);
note6dot_8 = generateNote(freq_6dot, quarterNote/2);

to_display=[note5_4,note5_8,note6_8,note2_2,note1_4,note1_8,note6dot_8,note2_2];
sound(to_display, fs*2);


% 计算时间轴
t = (0:length(to_display)-1)/fs; 

% 绘制波形图
figure;
plot(t, to_display);
xlabel('时间（秒）');
ylabel('振幅');
title('音频信号波形');
grid on;

% 自动调整横轴范围（0到总时长）
xlim([0, t(end)]); 

% 纵轴固定显示范围（-1到1）
ylim([-1.1, 1.1]);