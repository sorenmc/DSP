function signal = sampleExponentialExercise2(f0,fs,T)

%fs = samples/second
%M = samples
%T = M/fs

M = fs*T;
mSample = 0:M-1;
signal = exp(1i*2*pi*f0*mSample/fs);
end

