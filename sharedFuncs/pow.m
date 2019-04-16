function [P] = pow(signal)
N = length(signal);
P = (1/(2*N+1))*sum(abs(signal).^2);
end

