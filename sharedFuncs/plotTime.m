function M = plotTime(signal,fs)

%samples/second   samples
%sampling period
dT = 1/fs;

M = length(signal);

%sampling time
T = dT*M;

%time vector
t = 0:dT:T-dT;

plot(t,signal);

xlabel('Time, [s]')
ylabel('Voltage, [V]')
grid on;





end

