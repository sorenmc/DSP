
clear all
close all
clc


%% Bullet 1
white = load('signals_white.mat');
whiteNoise = white.noise;
whiteRecorded = white.recorded;
whiteSpeech = white.speech;
fs = white.fs;

% soundsc(whiteNoise,fs)
% pause(5)
% soundsc(whiteRecorded,fs)
% pause(5)
% soundsc(whiteSpeech,fs)

%% Bullet 2
dT = 1/fs;
T = length(whiteNoise)/fs;
timeVector = [0:dT:T-dT];

[x,lag] = xcorr(whiteNoise,whiteRecorded);

plot(lag,x)
grid on
xlabel('Lag,[N]')
ylabel('Amplitude')
print('Plots/Lab7/2auto','-depsc')

[~,ind] = max(x);
delaySamples = lag(ind);
delayTime = delaySamples/fs;


%t = l/V
l = 2; %2 m
v = 340.3; %m/s
theoreticalTime = l/v; 




%% Bullet 3

% x1 = g1+conv(x2,h) 
% g1 = x1-conv(x2,w=h)
% w = h
% g1 = g1+conv(x2,h)-conv(x2,h)
%g1 = g1


%% Bullet 5






%% Bullet 4



%% Bullet 5

figure()


b = 0.5:0.05:0.8;
legendInfo = cell(length(b),1);
powerVec = zeros(length(b),1);
count = 1;
count1 = 1;
for beta = b
y = findY(whiteRecorded,whiteNoise,beta,abs(delaySamples));

powerVec(count) = sum(abs(y).^2)/(2*length(y)+1);


plot(timeVector,y)
hold on


legendInfo{count1} = ['beta = ' num2str(beta)];
count = count+1;
count1 = count1 +1;

end
grid on
legend(legendInfo);
xlabel('Time,[s]')
ylabel('Amplitude')
print('Plots/Lab7/5betaEst','-depsc')

figure()
plot(b,powerVec)
grid on
xlabel('beta')
ylabel('Power,[w]')
print('Plots/Lab7/5powBeta','-depsc')

figure()
[~,ind] = min(powerVec);
betaChosen1 = b(ind);
y = findY(whiteRecorded,whiteNoise,betaChosen1,abs(delaySamples));

hold on 
plot(timeVector,whiteRecorded)
plot(timeVector,whiteSpeech)
plot(timeVector,y)
grid on
legend('WhiteRecorded','whiteSpeech','filtered')
xlabel('Time,[s]')
ylabel('Amplitude')
print('Plots/Lab7/5filtered','-depsc')


%% bullet 7


[Pxy,W1] = cpsd(whiteRecorded,whiteNoise,zeros(1,0),512,1024,'twosided');
[Pxx,W2] = cpsd(whiteNoise,whiteNoise,zeros(1,0),512,1024,'twosided');

wOptimal = ifft(Pxy./Pxx);

filtered = filter(wOptimal,1,whiteNoise);

y1 = whiteRecorded-filtered;

figure()
plot(timeVector,y1)
grid on;
xlabel('Time,[s]')
ylabel('Amplitude')
print('Plots/Lab7/7filteredPow','-depsc')

[betaOpt7,delay7] = max(wOptimal);

filteredSNR7 = snr(y1,whiteNoise);
unfilteredSNR7 = snr(whiteRecorded,whiteNoise);

% filteredSNR7 = var(y1)/var(whiteNoise)
% unfilteredSNR7 = var(whiteRecorded)/var(whiteNoise)
% 

%% Bullet 8

hair = load('signals_hairdryer.mat')
hairNoise = hair.noise;
hairRecorded = hair.recorded;
hairSpeech = hair.speech;
hairfs = hair.fs;


%2 repeated
[x,lag] = xcorr(hairNoise,hairRecorded);

plot(lag,x)
grid on
xlabel('Lag,[N]')
ylabel('Amplitude')
print('Plots/Lab7/82auto','-depsc')

[~,ind] = max(x);
delaySamples8 = lag(ind);
delayTime8 = delaySamples/fs;


%5 repeated

figure()
b = 0.5:0.04:0.8;
legendInfo = cell(length(b),1);
%powerVec = zeros(length(b),1);
count = 1;
count1 = 1;
for beta = b
y = findY(hairRecorded,hairNoise,beta,abs(delaySamples));

powerVec(count) = pow(y);


plot(timeVector,y)
hold on

legendInfo{count1} = ['beta = ' num2str(beta)];
count = count+1;
count1 = count1 +1;

end
grid on
legend(legendInfo);
xlabel('Time,[s]')
ylabel('Amplitude')
print('Plots/Lab7/85betaEst','-depsc')

figure()
plot(b,powerVec)
grid on
xlabel('beta')
ylabel('Power, [w]')
print('Plots/Lab7/85powBeta','-depsc')

figure()
[~,ind] = min(powerVec);
betaChosen2 = b(ind); 
y = findY(hairRecorded,hairNoise,betaChosen2 ,abs(delaySamples));

hold on 
plot(timeVector,hairRecorded)
plot(timeVector,hairSpeech)
plot(timeVector,y)
grid on
xlabel('Time,[s]')
ylabel('Amplitude')
legend('hairRecorded','hairSpeech','hairFiltered')
print('Plots/Lab7/85filtered','-depsc')


%7 repeated
[Pxy,W1] = cpsd(hairRecorded,hairNoise,zeros(1,0),512,1024,'twosided');
[Pxx,W2] = cpsd(hairNoise,hairNoise,zeros(1,0),512,1024,'twosided');

wOptimal = ifft(Pxy./Pxx);

filtered = filter(wOptimal,1,hairNoise);

y2 = hairRecorded-filtered;

figure()
plot(timeVector,y2)
hold on
plot(timeVector,hairRecorded)
plot(timeVector,hairSpeech)
grid on;
xlabel('Time,[s]')
ylabel('Amplitude')
legend('filtered','unfiltered','actual signal')
print('Plots/Lab7/87filteredPow','-depsc')

[betaOpt8,delay8] = max(wOptimal);
filteredSNR8 = snr(y2,hairNoise);
unfilteredSNR8 = snr(hairRecorded,hairNoise);

% filteredSNR8 = var(y2)/var(hairNoise)
% unfilteredSNR8 = var(hairRecorded)/var(hairNoise)
