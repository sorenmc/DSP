function exercise2Bullet1()
fs = 1000;
T = 1;

%signal 1
f0 = 230;
signal1 = sampleExponentialExercise2(f0,fs,T);


%Signal 2
f0 = 700;
signal2 = sampleExponentialExercise2(f0,fs,T);


%signal 3
f0 = 1750;
signal3 = sampleExponentialExercise2(f0,fs,T);


%Plot the spectrum of the 3 signals
figure('name','signal1')
plot_spectrumExercise2(signal1,fs,'stem');
hold on
plot_spectrumExercise2(signal2,fs,'stem');
plot_spectrumExercise2(signal3,fs,'stem');
legend('230 Hz', '700 Hz', '1750 Hz')
print('Plots/Lab2/SinusoidSpect','-depsc')




end