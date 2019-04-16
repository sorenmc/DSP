function [analogSignal,fv] = analogSampled(fs,M)
%FIND ANALOG SIGNAL
%g(t) defined for 0<t<T
%g(t) = 0 for every other input
%G(f) = int ^+inf _-inf  g(t) * exp(-j*omega*t) dt 
%G(f) = int ^T _0  g(t) * exp(-j*omega*t) dt
%The fourier transform of a rect function is a sinc function
%to match signal in time we set fs = 5
%and M = 120


%find spectral resolution - this is the inverse of the total
% time sampled
TT = M/fs;
df = 1/(TT);

fv = 0:df:fs-df;
%analogSignal = TT*2*sinc(fv*TT).*exp(-1i*2*pi*fv*TT/2);
analogSignal = TT*sinc(fv*2);
fv = fv/(fs);

end

