function [velArray,seg] = velSegments(signals,fs,window,Tprf,c)
%window = constant given in seconds

N = fs*window;
nJumps = round(size(signals,1)/N);
velArray = zeros(1,nJumps);

%used to window the signal
startSeg = 1;
endSeg = N;

%window the signal and use it as input to the function
for i = 1:nJumps
    if ( i ==nJumps)
        segment = signals(startSeg:end,:);
    else
        segment = signals(startSeg:endSeg,:);
    end
    velArray(i) = determineVel(segment,Tprf,c,fs);
    startSeg = startSeg+N;
    endSeg = endSeg+N;
end

seg = 1:nJumps;

end

