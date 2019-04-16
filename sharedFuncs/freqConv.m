function [filtered] = freqConv(signalA,signalB)
%Returns the linear convolution of the 2 signals

%Length of the signals -1
lA = length(signalA)-1;
lB = length(signalB)-1;


%Zero pad signals with the length of the opposite signal -1
aM = [signalA,zeros(1,lB)]
bM = [signalB,zeros(1,lA)]

%Take into fourier domain
A = myDFT(aM);
B = myDFT(bM);

%Multiplication in frequency is convolution in time
FILTERED = A.*B;

%Take back to time domain and get the convoluted signal
filtered = myIDFT(FILTERED);


end

