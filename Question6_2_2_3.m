addpath 'C:\Users\八点共圆\Downloads';
load('Guitar.MAT');
len = length(realwave);
realwave_10 = resample(realwave, 10, 1);
period = zeros(len, 1);

for i = 1: 1: len
    for j = 0: 1: 9
        period(i) = period(i) + realwave_10(j * len + i);
    end
    period(i) = period(i) / 10;
end
period_10 = repmat(period, 10, 1);
find_wave2proc = resample(period_10, 1, 10);

fs = 8000;
y1 = fft(find_wave2proc(1: round(end / 10)));
L1 = length(y1);
f1 = fs * linspace(0, L1 - 1, L1) / L1;
P1 = abs(y1(1:floor(L1/2)+1)); % 单边幅度
f1_single = f1(1:floor(L1/2)+1); % 单边频率
subplot(3, 1, 1);
plot(f1_single, abs(P1));
xlabel('w');
ylabel('amplitude');
title('single period');

y2 = fft(find_wave2proc);
L2 = length(y2);
f2 = fs * linspace(0, L2 - 1, L2) / L2;
P2 = abs(y2(1:floor(L2/2)+1)); % 单边幅度
f2_single = f2(1:floor(L2/2)+1); % 单边频率
subplot(3, 1, 2);
plot(f2_single, abs(P2));
xlabel('w');
ylabel('amplitude');
title('10 periods');

find_wave2proc_100 = repmat(find_wave2proc, 100, 1);
y3 = fft(find_wave2proc_100);
L3 = length(y3);
f3 = fs * linspace(0, L3 - 1, L3) / L3;
P3 = abs(y3(1:floor(L3/2)+1)); % 单边幅度
f3_single = f3(1:floor(L3/2)+1); % 单边频率
subplot(3, 1, 3);
plot(f3_single, abs(P3));
xlabel('w');
ylabel('amplitude');
title('1000 periods');