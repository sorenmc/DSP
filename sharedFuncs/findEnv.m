function [envelope,signal] = findEnv(spectrum)
%Input:
%spectrum:      Spectrum of a signal
%
%Output
%envelope:      The envelope of a signal


%using equation 5.45 from the notes to find the analytical signal,
%we set p = 0, to get the first interval from 0 to
%nyquist frequency.

M = length(spectrum);
if(mod(M,2)==0)
    spectrum(1:M/2) = 0;
    spectrum(M/2 + 1:end) = [spectrum(M/2 + 1:end)*2];
else
    spectrum(1:floor(M/2)) = 0;
    spectrum(ceil(M/2):end) = spectrum(ceil(M/2):end)*2;
end

fft(signal)
ifft(spektrum)

signal = myIDFT(spectrum);
envelope = abs(signal);
end

