function hesAPiroteButton_3Pushed(ax)
    fs=8000;
    quarterNote=0.25;
    freq_1=392;
    freq_2=freq_1*2^(2/12);
    freq_3=freq_1*2^(4/12);
    freq_4=freq_1*2^(5/12);
    freq_7dot=freq_1*2^(-1/12);
    freq_6dot=freq_1*2^(-3/12);
    freq_3dot=freq_1*2^(-8/12);
    freq_5dot=freq_1*2^(-5/12);

    generateNote = @(f,duration) (sin(2*pi*f*(0:1/fs:duration))+sin(4*pi*f*(0:1/fs:duration))*0.2+sin(6*pi*f*(0:1/fs:duration))*0.3)*3.*((0:1/fs:duration)/duration).^0.5.*exp(-2*(0:1/fs:duration)/duration);
    generateSilence = @(duration) zeros(1, round(fs * duration)); 
    silence = generateSilence(quarterNote); 

    note1_4 = generateNote(freq_1, quarterNote);
    note1_8 = generateNote(freq_1, quarterNote/2);
    note2_8 = generateNote(freq_2, quarterNote/2);
    note2_4 = generateNote(freq_2, quarterNote);
    note3_8 = generateNote(freq_3, quarterNote/2);
    note3_4 = generateNote(freq_3, quarterNote);
    note4_4 = generateNote(freq_4, quarterNote);
    note6dot_4 = generateNote(freq_6dot, quarterNote);
    note6dot_8_pause = generateNote(freq_6dot, quarterNote*3/2);
    note6dot_4_pause = generateNote(freq_6dot, quarterNote*2);
    note7dot_4_pause = generateNote(freq_7dot, quarterNote*2);
    note6dot_8 = generateNote(freq_6dot, quarterNote/2);
    note7dot_4 = generateNote(freq_7dot, quarterNote);
    note7dot_8 = generateNote(freq_7dot, quarterNote/2);
    note3dot_8 = generateNote(freq_3dot, quarterNote/2);
    note5dot_8 = generateNote(freq_5dot, quarterNote/2);
    note5dot_4 = generateNote(freq_5dot, quarterNote);


    to_display=[note6dot_4,note6dot_8,note6dot_4,note6dot_8,note6dot_4,note6dot_8,note6dot_8,note3dot_8,note5dot_8,note6dot_4,note6dot_4,note6dot_8,note7dot_8,note1_4,note1_4,note1_8,note2_8,note7dot_4,note7dot_4,note6dot_8,note5dot_8,note5dot_8,note6dot_8_pause,note3dot_8,note5dot_8,note6dot_4,note6dot_4,note6dot_8,note7dot_8,note1_4,note1_4,note1_8,note2_8,note7dot_4,note7dot_4,note6dot_8,note5dot_8,note6dot_4_pause,note3dot_8,note5dot_8,note6dot_4,note6dot_4,note6dot_8,note1_8,note2_4,note2_4,note2_8,note3_8,note4_4,note4_4,note3_8,note2_8,note3_8,note6dot_8_pause,note6dot_8,note7dot_8,note1_4,note1_4,note2_4,note3_8,note6dot_8_pause,note6dot_8,note1_8,note7dot_4,note7dot_4,note1_8,note6dot_8,note7dot_4_pause];
    sound(to_display, fs);


    % 计算时间轴
    t = (0:length(to_display)-1)/fs; 
    plot(ax,t, to_display);
    xlabel(ax,'时间（秒）');
    ylabel(ax,'振幅');
    title(ax,'音频信号波形');
    grid(ax,'on');
end
