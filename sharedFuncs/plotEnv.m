function plotEnv( env, signal,fs,M )
%Plots envelope on top of spectrum (has to be analytical

%Total time sampled
T = (M/fs);

%Time resolution
dT = 1/fs;

%Time vector for plotting
t = 0: dT :T-dT;


plot(t,signal)
hold on
plot(t,env)

grid on
xlabel('Time, [s]')
ylabel('Magnitude (V)')
xlim([0 2.6e-4])
ylim([-1 1])
end

