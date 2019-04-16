function [spectrum] = myDFT(signal)
%Returns the fourier spectrum
%Version 3 - now without any for loops!

if(size(signal,1) <size(signal,2))
    signal = transpose(signal);
end

M = length(signal);

%preallocate space for matrix with twiddlefactors
twiddleMatrix = zeros(M,M);

%make all rows be equal to kVector
kVector = 0:M-1;
twiddleMatrix = repmat(kVector,M,1);


%the actual twiddleMatrix obtained by multiplying elementwise.
twiddleMatrix = transpose(kVector .* transpose(twiddleMatrix));

%the spectrum matrix can now be calculated, each coloumn is one sample
spectrumMatrix = signal.*exp(-1i*2*pi*twiddleMatrix/M);

%sum through coloumns to get the fourier transformed of the signal
spectrum = sum(spectrumMatrix);


end

