addpath 'C:\Users\八点共圆\Downloads';
[audioData, sampleRate] = audioread('fmt.wav');
amplitude = audioData;
duration = length(audioData) / sampleRate; % 音频总时长（秒）
time = (0:length(audioData)-1) / sampleRate; % 每个采样点对应的时间
fs=sampleRate;
figure;

plot(time, amplitude);
xlabel('Time (s)');
ylabel('Amplitude');
title('Amplitude--Time');
grid on;

period1=audioData(1:round(length(audioData)*1.743/16.384));
subplot(2,1,1);
plot((1:round(length(audioData)*1.743/16.384)),period1);
xlabel('t');
ylabel('period1(t)');
title('period1-t');
period1_1000=repmat(period1,1000,1);
y1=fft(period1_1000);
L1 = length(y1);
f1 = fs * linspace(0, L1 - 1, L1) / L1;
P1 = abs(y1(1:floor(L1/2)+1)); % 单边幅度谱
f1_single = f1(1:floor(L1/2)+1); % 单边频率轴
subplot(2,1,2);
plot(f1_single,abs(P1));
xlabel('w');
ylabel('period1(w)');
title('period1-w');

% 找到基波频率（排除直流分量）
[~, max_idx] = max(P1(2:end)); % 忽略 0 Hz
fundamental_freq = f1_single(max_idx + 1)