close all
clear all
clc

%Loads signal and plot it
ecg = load('ecg.mat');
ecg = ecg.ecg;

%signal is amplified by 500
ecg = ecg./500;
fs = 500;

figure('name','unfiltered')
plotTime(ecg(200:658),fs);
print('Plots/Lab3/unfilteredTime','-depsc')

%% pre process the signal and plot each filter step


%notch filter, bands pass filter from 0.5 to 100 Hz
high = 47;
[ecg1,ecg2,ecg3] = preProcess(ecg,fs,high); %also plots spectrum

%plot ecg1
figure('name','notch filtered at -0.5;0.5')
plotTime(ecg1(200:658),fs);
print('Plots/Lab3/05NotchTime','-depsc')

%plot ecg2
figure('name','notch filtered at -50 and 50 Hz')
plotTime(ecg2(200:658),fs);
print('Plots/Lab3/50NotchTime','-depsc')

%plot ecg3
figure('name','bandpassed from -high:high')
plotTime(ecg3(200:658),fs);
print('Plots/Lab3/bandPasstime','-depsc')

%% Auto correlation part
figure('name','autocorrelated')
[corr,lack] = xcorr(ecg3,ecg3);

plot(lack,corr);
xlabel('Lack, [N]')
ylabel('Correlation')
grid on
print('Plots/Lab3/autoCorrelation','-depsc')

%Only get the positive lack part of the autocorrelation
%This way there is only one peak to look for
corr = corr(lack>=0);

%only finds peak that is the second highest
minPeak = corr(1)/2 -corr(1)/10
[~,peakIndex] = findpeaks(corr,'MinPeakHeight',minPeak); 

%sampling frequency is 500 Hz
%peakIndex is the number of samples for one period.
%heart period = N/fs
%heart period is 458/500
%Heart BPM is thus 500/458 * 60 seconds/min
BPM1 = max(fs/peakIndex)*60;


%for unfiltered signal it's the same
[corr,lack] = xcorr(ecg,ecg);



figure('name', 'auto2')
plot(lack,corr);
xlabel('Lack, [N]')
ylabel('Correlation')
grid on
print('Plots/Lab3/autoCorrelation2','-depsc')

corr = corr(lack>=0); 
minPeak = corr(1)/2 -corr(1)/10
[~,peakIndex] = findpeaks(corr,'MinPeakHeight',minPeak); 

BPM2 = max(fs/peakIndex)*60;





%relic - implemented a notch filter this way.

%z = tf('z');
%notch = ((z-exp(j*pi*50/250))*(z-exp(-j*pi*50/250)))/((z-0.98*exp(j*pi*50/250))*(z-0.98*exp(-j*pi*50/250)));
%ecg = filter(notch.Numerator{1,1},notch.Denominator{1,1},ecg);