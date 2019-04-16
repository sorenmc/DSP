function [H,freq] = findImpResponse(bin,N)
fs = 1000;
df = fs/N;
freq = -fs/2:df:fs/2-df ;
Imp = [ones(1,bin)/bin,zeros(1,N-bin)];
H = abs(fftshift(fft(Imp)));
%pause(150e-3)
plot(freq,abs(H));

end

