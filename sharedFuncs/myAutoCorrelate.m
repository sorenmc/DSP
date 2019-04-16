function y = myAutoCorrelate(X)

X = reshape(X,[1,length(X)]);
NX = length(X);
NY = NX*2-1;
y = zeros(1,NY);
k=1;
n = length(X);

for l = 1:NX
     y(l) = sum(X(n:end).*X(1:k));      
     k = k+1;
     n = n-1;
end


y = fliplr(y)+y;
y(round(NY/2)) = y(round(NY/2))/2;
end