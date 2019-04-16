function [res,lag] = myCrossCorrelate(X,Y)
%Returns the cross correlation of X and Y.
%res = the result
%lag = vector with lag



%Make sure that zero padding does not interefere...
NX = length(X);
NY = length(Y);
if (NX > NY)
    if(sum(X(1:NX-NY)) == 0)
        Y = [Y,zeros(1,NX-NY)];
    else
        Y = [zeros(1,NX-NY),Y];
    end
elseif (NY > NX)
    if(sum(Y(1:NY-NX)) == 0)
        X = [X,zeros(1,NY-NX)];
    else
        X = [zeros(1,NY-NX),X];
    end
end
X = reshape(X,[1,length(X)]);
Y = reshape(Y,[1,length(Y)]);

NX = length(X);
NY = length(Y);

NOUT = NX+NY-1;

res = zeros(1,NOUT);

k=1;
n = length(X);

for l = 1:NOUT
    if(l <= NX)
        res(l) = sum(X(1:k).*Y(n:end));
    else
        res(l) = sum(X(k:end).*Y(1:n));
    end
    k = k+1;
    n = n-1;
    
    if (l == NX)
        k = 2;
        n = length(X)-1;
    end
end

lag = [-floor(NOUT/2):floor(NOUT/2)];


end