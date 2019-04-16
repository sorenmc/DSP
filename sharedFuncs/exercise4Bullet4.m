function exercise4Bullet4( passBand,stopBand,fs)

frequencies = [0,passBand,stopBand,fs/2]/(fs/2);
attenuations = [1,1,0,0];
figure()
count = 1;%used for knowing number of iterations;

for N = 61:2:67
    B = firpm(N,frequencies,attenuations);
    [H1T,freq1T] = transfer(B,1,64);
    plot(freq1T,20*log10(abs(H1T)))
    xlabel('Normalized frequency (\times \pi rad/sample)');
    ylabel('Magnitude (dB)');
    hold on
    grid on
    %used to vary the amount of legends used
    legendInfo{count} = ['N = ' num2str(N)]
    count = count +1;
end
ylim([-65 1])
legend(legendInfo);
print('Plots/Lab4/TransferFunctionOrdersFIR','-depsc')
end