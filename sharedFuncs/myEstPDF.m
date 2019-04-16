function [] = myEstPDF(sig,split,mode)
N = length(sig);

%The density resolution
resolution = (max(sig) - min(sig))/split;
divide = [min(sig):resolution:max(sig)-resolution];

%plot histogram estimating the PDF
bar(divide,histc(sig,divide)/N);
hold on

if ( strcmp(mode,'Uniform'))
    pdf = 1/(resolution*split);
    theoreticalPDF = ones(split,1)*pdf/N*split;
    plot(divide,theoreticalPDF);
elseif(strcmp(mode,'Normal'))
    mu = mean(sig);
    s = var(sig);
    pdf = 1/sqrt(2*pi*s) * exp(-1* ((divide-mu).^2)/(2*s))/(N/split);
    pdf = pdf/sum(pdf);
    
    plot(divide,pdf);
end


xlabel('Amplitude')
ylabel('Frequency')
legend('Estimated','Theoretical')
end

