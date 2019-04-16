function v = determineVel(sigMatrix,Tprf,c,fs)
    avgCross = zeros(1,size(sigMatrix,1)*2-1);
for i = 1:size(sigMatrix,2)-1
    [tempCross,lag] = myCrossCorrelate(sigMatrix(:,i),sigMatrix(:,i+1));
   avgCross = avgCross + tempCross;
    
end
avgCross = avgCross/(size(sigMatrix,2)-1);


delayInSeconds = returnDelay(avgCross,lag,fs);

v = delayInSeconds*c/(2*Tprf);




end