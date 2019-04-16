function [H,freq] = transfer(B,A,N)
%Returns Transfer function of filter with coeficient vectors B and A
%Inputs
%B:     B is the coefficients of the zeros of the filter
%A:     A is the coefficients of the poles of the filter
%N:     N is the number of samples of the returned transferfunction
%
%Outputs:
%H:     is the sampled transfer function
%freq:  is the frequency vector used for plotting the transfer function
%later

%assume fs = 1

lB = length(B);
lA = length(A);
H = zeros(N,1);

for n = 1:N-1
    Ys = 0;
    Xs = 0;
    z = exp(j*pi*(n-1)/N);
    
    tz = 1;
    for i = 1:lB
        Ys = Ys + B(i)/tz;
        tz = tz*z;
    end
    
    tz = 1;
    for i = 1:lA
        Xs = Xs + A(i)/tz;
        tz = tz*z;
    end
    H(n) = Ys/Xs;
end
    freq = [0:1/N:1-1/N];
    
end


