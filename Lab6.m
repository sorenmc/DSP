clear all
close all
clc

%% Bullet1

fs = 100*10^6;
f0 = 5*10^6;
T = 20*10^-6;
tDelay = 0.4*10^-6;
tPeriod = 1/f0;

dT = 1/fs;
%tVec = [0:dT:T+tDelay-dT]

%[fs] = samples/second
%[T] = seconds
%N = fs*T = 100*10^6 * 20*10^-6 = 2000 samples 
%delay = fs*T_delay = 100*10^6 * 0.4*10^-6 = 40 samples
nDelay = fs* tDelay;
sin2Periods = sampleSinusoidExercise2(f0,fs,2*tPeriod);

%randSig
N = round(fs*T);
randSig = randn(1,N);



randSig1 = conv(randSig,sin2Periods);
randSig2 = [zeros(1,nDelay),randSig1];

stem(randSig1)
hold on 
stem(randSig2)
xlabel('Samples [N]')
ylabel('Amplitude [V]')
xlim([1 , length(randSig2)])
grid on
legend('Signal', 'Delayed Signal')
print('Plots/Lab6/delayedSignal','-depsc')


[randCorr,lag] = myCrossCorrelate(randSig1,randSig2);

%cross correlation
figure()
plot(lag,randCorr)

xlabel('Lag [N]')
ylabel('Amplitude')
grid on
legend('Cross Correlation')
print('Plots/Lab6/crossCorr','-depsc')


delayInSeconds = returnDelay(randCorr,lag,fs);


%% Bullet 2,3

c = 1540; %speed of sound in human tissue [m/s]
plug_flow = load('plug_flow.mat');
pulseEchoSignals = plug_flow.data;
fs = 100*10^6;
Tprf = 200*10^-6;


vel = determineVel(pulseEchoSignals,Tprf,c,fs);

%% Bullet 4

%samples = fs*time window = 100*10^6 Hz * 2*10^-6 s = 200
window =  2*10^-6;
[velArray1,~] = velSegments(pulseEchoSignals,fs,window,Tprf,c);



%% Bullet 5
carotis = load('carotis.mat');
carotis = carotis.data;

[velArray2,seg] = velSegments(carotis,fs,window,Tprf,c);
    
figure()
plot(seg,velArray2)
xlabel('Segment [N]')
ylabel('Velocity [m/s]')
grid on
legend('Velocity')
print('Plots/Lab6/velocity','-depsc')
%v = determineVel(