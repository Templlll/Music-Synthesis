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

music_original=[note5_4,note5_8,note6_8,note2_2,note1_4,note1_8,note6dot_8,note2_2];
%升高八度
music_high = resample(music_original(:), 1, 2);  
% 降低八度
music_low = resample(music_original(:), 2, 1); 
% 升高半音（近似比例17:16）
music_semi = resample(music_original(:), 17, 16);

sound(music_semi,fs)