function delay = returnDelay(corr,lag,fs)
%returns the delay of signal 2 compared to signal 1
%by taking sig1 * sig2 as argument together with the lag parameter

[~,ind] = max(corr);
delay = lag(ind)/fs;
end

