function [spect, f] = plot_spectrumExercise2(signal,fs,plotVar)
%Outputs:
%spec:      The spectrum of the signal (negative and positive frequencies
%
%Inputs:
%signal:    The signal that you want to find the spectrum of.
%fs:        The sampling frequency.
%M:         Length of the signal.

%DFT
M = length(signal);
spectrum = fft(signal);


spectrum = fftshift(spectrum);

%find spectral resolution - this is the inverse of the total time sampled
df = 1/(M/fs);

%frequency vector for plotting
if(mod(M,2) == 0)
     f = -fs/2: df :fs/2-df;  
    %f = linspace(-fs/2,fs/2-df) 
else
    
    f = 0:-df:-fs/2;
    f = fliplr(f);
    f = [f,0+df:df:fs/2];
end


%normalize with respect to nyquist frequency
%f=f/(fs]2);

%Plot the spectrum
if(plotVar == 'stem')
    stem(f, abs(spectrum))
else
    plot(f, abs(spectrum))
end
grid on
%xlabel('Normalized Frequency (Nyquist normalized) (\times \pi rad/sample)')
xlabel('Frequency [Hz]')
ylabel('Magnitude [V]')

%return spectrum
spect = spectrum;

end

