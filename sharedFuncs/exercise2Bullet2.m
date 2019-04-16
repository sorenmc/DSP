function signal = exercise2Bullet2()

fs = 1000;

%If the sum of a number of signals is a periodic signal,
%The new signals period will be the inverse of the least common multiplicum
%Of the involved sinusoids periods 
%1/100 1/150 1/300

%For the frequencies the greatest common denominator is the resulting
%frequency. for these signals that will be 50 Hz. The period is thus
%1/50 = 0.02 s

f0 = 100;
f1 = 150;
f2 = 300;
T = 1/50;

signal1 = sampleSinusoidExercise2(f0,fs,T);
signal2 = sampleSinusoidExercise2(f1,fs,T);
signal3 = sampleSinusoidExercise2(f2,fs,T);

signal = signal1 + 0.2*signal2 - 0.5*signal3 + 1.2;

figure('name','Spectrum Sinusoid')
plot_spectrumExercise2(signal,fs,'stem');

print('Plots/Lab2/3signalsSpect','-depsc')



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%Moving average filter %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = 10;


%%%%% plot spectrum of moving average
figure('name','movingAverageSpect')
filterUse = movingAverageFilter(M); 
filterUse = [0,filterUse,0];
plot_spectrumExercise2(filterUse,fs,'stem');
print('Plots/Lab2/movingAverageSpect','-depsc')



%%%%%%Filter the signal and plot spectrum
filterSignal = conv(filterUse,signal);
figure('name','movingAverage')
plot_spectrumExercise2(filterSignal,fs,'stem');
print('Plots/Lab2/movingAverageFiltered','-depsc')

%sample 4 periods. 
T = 1/50 * 4;
signal1 = sampleSinusoidExercise2(f0,fs,T);
signal2 = sampleSinusoidExercise2(f1,fs,T);
signal3 = sampleSinusoidExercise2(f2,fs,T);
signal = signal1 + 0.2*signal2 - 0.5*signal3 + 1.2;


filterSignal = conv(filterUse,signal);

figure('name','movingAverage3rdPeriod')
[~,f] = plot_spectrumExercise2(filterSignal(41:60),fs,'stem');
hold on
[~,f] = plot_spectrumExercise2(filterSignal(1:20),fs,'stem');
legend('Moving average 3rd period', 'Moving average 1st period')

print('Plots/Lab2/MovingAveragePeriod1vs3','-depsc')

end

