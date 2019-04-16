function exercise2Bullet4()
velo1 = load('velo1');
velo1 = velo1.velo1;
velo2 = load('velo2');
velo2 = velo2.velo2;
c = 1540;
f0 = 3e6;
fs = 5000;

figure('name','vel1')
[spectrum1,freq1] = plot_spectrumExercise2(velo1,fs,'plot');
print('Plots/Lab2/vel1','-depsc')

figure('name','vel2')
[spectrum2,freq2] = plot_spectrumExercise2(velo2,fs,'plot');
print('Plots/Lab2/vel2','-depsc')


%determine mean frequency present in the signal
f1 = sum(freq1.*abs(spectrum1))/sum(abs(spectrum1))
f2 = sum(freq2.*abs(spectrum2))/sum(abs(spectrum2))

%determine velocity
v1 = f1/(2*f0)*c
v2 = f2/(2*f0)*c



end