function [spect, f] = plot_spectrum(signal,fs,M)
%Outputs:
%spec:      The spectrum of the signal (negative and positive frequencies
%
%Inputs:
%signal:    The signal that you want to find the spectrum of.
%fs:        The sampling frequency.
%M:         Length of the signal.

%DFT

spectrum = myDFT(signal);

%shift the spectrum, so the negative frequencies comes first
%followed by the positive frequencies

if(mod(M,2) == 0) %even number of samples
    
    spectrum = circshift(spectrum, M/2);
    
else %odd number of samples
    spectrum = circshift(spectrum, ceil(M/2) );
    
end

%find spectral resolution - this is the inverse of the total time sampled
df = 1/(M/fs);

%frequency vector for plotting
f = 0: df :fs/2-df;

%normalize with respect to nyquist frequency
f=f/(fs/2);


%find magnitude of the spectrum
plotSpectrum = spectrum(M/2+1:end);



%Plot the spectrum
plot(f,abs(plotSpectrum))
grid on
xlabel('Normalized Frequency (Nyquist normalized) (\times \pi rad/sample)')
ylabel('Magnitude (V)')


%return spectrum
spect = spectrum;



end

