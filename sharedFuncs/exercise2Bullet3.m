function exercise2Bullet3(signal)

h = [0.5,0,0,0,0,0,0,0,0,0,-0.5]
signal = signal(1:20)

%Uses the convolution theorem (conv in time = mult in frequency)
filtered = freqConv(h,signal);

figure('name', 'Filtered')

plot(real(filtered(1:20)))
hold on
grid on
signal =conv(h,signal);
plot(signal(1:20));
xlabel('Samples, [N]')
ylabel('Amplitude, [V]')

legend('mult','conv');
print('Plots/Lab2/convTheorem','-depsc')


figure('name','filteredSpect')

fs = 1000;
plot_spectrumExercise2(filtered(1:20),fs,'stem');
print('Plots/Lab2/convTheoremSpect','-depsc')

end

