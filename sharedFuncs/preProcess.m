function [ecg1,ecg2,ecg3] = preProcess(ecg,fs,higher)

figure('name','spectrumUnfiltered')
[ECG,f] = plot_spectrumExercise2(ecg,fs,'stem');
print('Plots/Lab3/unfilteredFreq','-depsc')

%set freqs below 0.5 to 0 (symmetric)
ECG( f>-0.6 & f<0.6) = 0;

figure('name','notch at 0.5')
stem(f,abs(ECG))
grid on
print('Plots/Lab3/notch05Freq','-depsc')

%Shift back and bring to time domain
ecg1 = ifft(ifftshift(ECG));


%notch filter at 50 hz
ECG(f>49.5 & f<50.5) = 0;
ECG(f>-50.5 & f<-49.5) = 0;

figure('name','notch at 50 Hz')
stem(f,abs(ECG))
grid on
print('Plots/Lab3/notch50Freq','-depsc')

%Shift back and bring to time domain
ecg2 = ifft(ifftshift(ECG));


%everything not inside the interval -higher ; higher Hz  is set to 0
ECG( ~(-higher<f  & f<higher) ) = 0;

figure('name','bands passed')
stem(f,abs(ECG))
grid on
print('Plots/Lab3/bandPassFreq','-depsc')

%Shift back and bring to time domain
ecg3 = ifft(ifftshift(ECG));
end

