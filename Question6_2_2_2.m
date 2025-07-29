addpath 'C:\Users\八点共圆\Downloads';
load('Guitar.MAT');
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

t = linspace(0, len / 8000, len)';
subplot(4, 1, 1);
plot(t, realwave);
title("realwave");

subplot(4, 1, 2);
plot(t, wave2proc);
title("wave2proc");

subplot(4, 1, 3);
plot(t, find_wave2proc);
title("find__wave2proc");

subplot(4, 1, 4);
plot(t, wave2proc-find_wave2proc);
title("wave2proc-find__wave2proc");