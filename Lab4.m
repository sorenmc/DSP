clear
close all
clc

%% exercise bullet 1
B1=[0.0725    0.2200    0.4085    0.4883    0.4085    0.2200    0.0725];
A1=[1.0000   -0.5835    1.7021   -0.8477   0.8401   -0.2823    0.0924];
z1 = abs(roots(B1))
p1 = abs(roots(A1))

B2=[1.0000    1.3000    0.4900   -0.0130   -0.0290];
A2=[1.0000   -0.4326   -1.6656    0.1253   0.2877];
z2 = abs(roots(B2))
p2 = abs(roots(A2))

B3=[1.0000   -1.4000    0.2400    0.3340   -0.1305];
A3=[1.0000    0.5913   -0.6436    0.3803   -1.0091];
z3 = abs(roots(B3))
p3 = abs(roots(A3))



figure('Name','Stable filter vs Unstable Filter')
impulse = zeros(64,1);
impulse(1) = 1;
plot(filter(B1,A1,impulse))
hold on
plot(filter(B2,A2,impulse))
plot(filter(B3,A3,impulse))
legend('Filter1', 'Filter2', 'Filter3')
grid on
xlabel('Samples [N]')
ylabel('Amplitude [V]')
print('Plots/Lab4/StableVsUnstable','-depsc')
%% Exercise Bullet 3

f1 = filter(B1,A1,impulse);
H1 = fft(f1);
freq1 = -1:1/32:1-1/32;
[H1T,freq1T] = transfer(B1,A1,32);
figure()
plot(freq1,fftshift(20*log10(abs(H1))))
hold on
plot(freq1T,20*log10(abs(H1T)))
xlabel('Normalized frequency (\times \pi rad/sample)');
ylabel('Magnitude (dB)');
legend('TF from impulse response','TF from coefficients')
grid on
print('Plots/Lab4/TransferFunctionsImp','-depsc')


%% Exercise Bullet 4
fs = 2000;
passBand = 500;
stopBand = 570;
exercise4Bullet4(passBand,stopBand,fs);
%% Bullet 5
figure()
Rp = 0.2;
Rs = 45;
passBand = 500;
count = 1;
for order = 1:10
[B,A] = ellip(order,Rp,Rs,passBand/(fs/2));
[H1T,freq1T] = transfer(B,A,64);
plot(freq1T,20*log10(abs(H1T)))
    xlabel('Normalized frequency (\times \pi rad/sample)');
    ylabel('Magnitude (dB)');
    hold on
    grid on
    
    %used to vary the amount of legends used
    legendInfo{count} = ['Order = ' num2str(order)];
    count = count +1;
end
ylim([-65 1])
legend(legendInfo);
print('Plots/Lab4/TransferFunctionOrdersIIR','-depsc')

%% Bullet 6


%IIR FILTER DESIGN GENERATED USING fdatool
Fs = 2000;  % Sampling Frequency

Fpass = 500;     % Passband Frequency
Fstop = 570;     % Stopband Frequency
Apass = 1;       % Passband Ripple (dB)
Astop = 45;      % Stopband Attenuation (dB)
match = 'both';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass(Fpass, Fstop, Apass, Astop, Fs);
Hd = design(h, 'ellip', 'MatchExactly', match);



%FIR FILTER DESIGN GENERATED USING fdatool
Fs = 2000;  % Sampling Frequency

Fpass = 500;              % Passband Frequency
Fstop = 570;              % Stopband Frequency
Dpass = 0.057501127785;   % Passband Ripple
Dstop = 0.0056234132519;  % Stopband Attenuation
dens  = 20;               % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);



