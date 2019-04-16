clear
clc
close all

dbstop if error
%% Bullet 1
fs = 1000;
randSig = rand(1,10000);
N = length(randSig);
dT = 1/fs;
T = N/fs;
freq = [0:dT:T-dT];

figure()
plot(freq,randSig);
xlabel('Time, [s]')
ylabel('Amplitude')
grid on
print('Plots/Lab5/randSig','-depsc')

figure()
myEstPDF(randSig,100,'Uniform');
print('Plots/Lab5/randSigPDF','-depsc')


%% Bullet 2

estMean = (max(randSig)+min(randSig))/2;
randSigMean = randSig - estMean;
figure()
count = 1;
for n = 1:40
    hold on
    [H,freq] = findImpResponse(n,N);
    
    legendInfo{count} = ['n = ' num2str(n)];
    count = count +1;
    
    %test if the filter has its first null at 50 Hz
    if( sum(H(freq<50 & 0 < freq) == 0))
        break;
    end
end
legend(legendInfo);
grid on
print('Plots/Lab5/lowpassFilter','-depsc')


%imp can also be found as fs/1stNullFreq
%1000/50 = 20;
order = fs/50;

%moving average with imp response, N long.
imp = zeros(1,order);
imp(1:order) = 1/order;

filteredRandSig = filter(imp,1,randSigMean);



figure()
plot(randSig)
hold on
grid on
plot(filteredRandSig)
xlabel('Sample number, [N]')
ylabel('Amplitude')
legend('Unfiltered','Filtered')

print('Plots/Lab5/filteredRandSig','-depsc')


figure()
subplot(1,2,1)
myEstPDF(filteredRandSig,100,'Normal');
grid on
subplot(1,2,2)
myEstPDF(filteredRandSig,300,'Normal');
grid on
print('Plots/Lab5/filteredSigPDF','-depsc')




%% Bullet 3
NX = length(filteredRandSig);
[estXCORR,lag] = xcorr(filteredRandSig,filteredRandSig,'unbiased');

%theoretical autocorrelation of the filtered signal is 
%the autocorrelation of the filters impulse response convolved with
%(or h(t) conv h(-t) = h(t) auto h(t)
%the auto correlation of white noise given as  sigma^2 at lag = 0


lLag = length(lag);


autoImp = xcorr(imp,imp);

autoNoise = zeros(1,length(lag));

%Theoretical variance of signal is equal to 
%Uniform distribution variance = (max-min)/12
%subtracting theoretical mean (0.5) will give us 
%max = 0.5
%min = -0.5
%(0.5--0.5)/12 = 0.0833
autoNoise(round(length(autoNoise)/2)) =  1/12; 



%Theoretical
theoreticalXCORR = conv(autoImp,autoNoise);

deleteBins = length(theoreticalXCORR) - length(estXCORR);
theoreticalXCORR(end-deleteBins/2+1:end) = [];
theoreticalXCORR(1:deleteBins/2) = [];



% PLOT THE THEORETICAL AUTO CORRELATION + ESTIMATED AUTO CORRELATION
figure()
subplot(1,2,1)
plot(lag,estXCORR)
hold on
plot(lag,theoreticalXCORR)
grid on
legend('Estimated','Theoretical')
xlabel('Lag')
ylabel('Amplitude')
ylim([min(estXCORR),0.0044])

subplot(1,2,2)

plot(lag,estXCORR)
hold on
plot(lag,theoreticalXCORR)
grid on
legend('Estimated','Theoretical')
xlabel('Lag')
ylabel('Amplitude')
xlim([-22,22])
ylim([-0.5*10^-3,0.0044])



print('Plots/Lab5/autoCorr','-depsc')

%% Bullet 4

ult = load('ult_sig2.mat');
ult = ult.ult_sig2;
figure()
subplot(1,2,1)
myEstPDF(ult,50,'Normal');
grid on
subplot(1,2,2)
myEstPDF(ult,400,'Normal');

print('Plots/Lab5/ultraSigPDF','-depsc')

%% Bullet 5
f0 = 6;
fs = 1000;

g = sin(2*pi*f0*(0:2000)/fs) + 2*randn(1,2001);

gSmooth = zeros(size(g));
Iterations = 100;
for i = 1:Iterations
    gSmooth = gSmooth +sin(2*pi*f0*(0:2000)/fs) + 2*randn(1,2001);
end
gSmooth = gSmooth/Iterations;

figure()
plot(g);
hold on
plot(gSmooth)
legend('g','gSmooth')
grid on
xlim([0,length(g)])
xlabel('Sample, [N]')
ylabel('Amplitude')
print('Plots/Lab5/gaussianNoise','-depsc')

