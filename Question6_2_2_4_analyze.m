clear all, close all, clc;
addpath 'C:\Users\八点共圆\Downloads';
[audioData, sampleRate] = audioread('fmt.wav');
amplitude = audioData;
duration = length(audioData) / sampleRate; % 音频总时长（秒）
time = (0:length(audioData)-1) / sampleRate; % 每个采样点对应的时间
fs=sampleRate;
cut=[0,1.743,2.158,2.639,3.087,3.585,4.033,4.465,4.996,5.743,6.971,7.718,8.449,8.930,9.428,9.810,10.092,10.325,10.524,10.789,11.271,11.702,12.234,12.698,13.230,13.728,14.275,14.906,16.384];
fundamental_freqs=zeros(1,length(cut)-1);
for i=1:length(cut)-1
    start_time = cut(i);
    end_time = cut(i+1);
    % 将时间转换为采样点索引（索引从1开始）
    start_idx = round(start_time * fs) + 1; % +1避免0索引
    end_idx = round(end_time * fs);
    % 确保索引不越界
    start_idx = max(1, start_idx);
    end_idx = min(length(audioData), end_idx);
    % 提取当前时间段信号
    period = audioData(start_idx:end_idx);
    period_1000=repmat(period,1000,1);
    y=fft(period_1000);
    L = length(y);
    f = fs * linspace(0, L - 1, L) / L;
    P = abs(y(1:floor(L/2)+1)); % 单边幅度谱
    f_single = f(1:floor(L/2)+1); % 单边频率轴

    % 找到基波频率（排除直流分量）
    [~, max_idx] = max(P(2:end)); % 忽略 0 Hz
    fundamental_freq = f_single(max_idx + 1);
    fundamental_freqs(i) = fundamental_freq;
end
disp(fundamental_freqs)