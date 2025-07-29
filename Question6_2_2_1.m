addpath 'C:\Users\八点共圆\Downloads';
load('Guitar.MAT');
whos realwave wave2proc;
[fmt_signal, Fs] = audioread('fmt.wav'); 
sound(fmt_signal, 8000); 
len = length(realwave);
t = linspace(0, len / 8000, len)';
subplot(2, 1, 1);
plot(t, realwave);
title("realwave");

subplot(2, 1, 2);
plot(t, wave2proc);
title("wave2proc");