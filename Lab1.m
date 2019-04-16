clear all
clc
close all

dbstop if error;

%% Load Signals
%discrete rect function
x = [ones(10,1);zeros(40,1)];
M = length(x);
fs = 5;

%Sample the analog spectrum
[analogSample,fv] = analogSampled(fs,M);

%Ultrasound signal
ult_sig = load('ult_sig');
ult_sig = ult_sig.ult_sig;

%% Rect signals


figure(1)

%plot magnitude of spectrum of discrete rect signal
%And analog rect signal
[xSpect,xFv] = plot_spectrum(x,fs,M);
hold on 
plot(fv,abs(analogSample));
legend('Discrete','Sampled analog w/ alising')
print('Plots/Lab1/SampledSignals','-depsc')
figure('name', 'Spectrum')


%Plot the spectrum of discrete and analog signal
xSpect = xSpect(M/2+1:end)
plot(xFv,xSpect)
hold on
plot(fv,analogSample);
grid on
xlabel('Normalized Frequency (Nyquist normalized) (\times \pi rad/sample)')
ylabel('Magnitude (V)')
legend('Discrete','Sampled analog w/ alising')
print('Plots/Lab1/SpectrumSampledSignals','-depsc')
%%

%set length and sampling frequency of ultrasound signal
M = length(ult_sig);
fs = 20e6;

%plot the signal as a function of time
figure('name','ultTime')
plotTime(ult_sig,fs,M);
print('Plots/Lab1/ultTime','-depsc')

%plot the signals spectrum
figure('name','ultSpect')
FTUltSig = plot_spectrum(ult_sig,fs,M);
print('Plots/Lab1/ultSpect','-depsc')

%%
figure('name','ultEnv')
%calculate envelope and plot it on top of the signal
[envUltSig,analyticalUlt] = findEnv(FTUltSig);
plotEnv(envUltSig,analyticalUlt,fs,M);
print('Plots/Lab1/envelope','-depsc')









