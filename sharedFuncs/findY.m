function y = findY(x1,x2,beta,k)
w = zeros(k,1);
w = [w;beta];

filtered = filter(w,1,x2);

y = x1-filtered;
end