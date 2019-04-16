function [signal] = myIDFT(spectrum)
%returns the signal, given the spectrum as input
%Version3 - now without any for loops!

if(size(spectrum,1) <size(spectrum,2))
    spectrum = transpose(spectrum);
end

M = length(spectrum) %number of samples

%preallocate space for matrix with twiddlefactors
twiddleMatrix = zeros(M,M);


%make all rows be equal to kVector
kVector = 0:M-1; 
twiddleMatrix = repmat(kVector,M,1);

%the actual twiddleMatrix obtained by multiplying elementwise.
twiddleMatrix = transpose(kVector .* transpose(twiddleMatrix));

%the spectrum matrix can now be calculated, each coloumn is one sample
signalMatrix = spectrum.*exp(1i*2*pi*twiddleMatrix/M);

%sum through coloumns to get the fourier transformed of the signal
signal = sum(signalMatrix)/M;


end





