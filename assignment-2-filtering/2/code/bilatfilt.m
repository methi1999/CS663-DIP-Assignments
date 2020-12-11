function pix = bilatfilt(inputmat)
global Gauss;
global excoefint
global denint
intpix =0;
intsum = 0;
%disp(inputmat)
centre = inputmat((size(inputmat,1)+1)/2,(size(inputmat,1)+1)/2);
for k = 1:size(inputmat,1)
    for l = 1:size(inputmat,2)
        intpix = intpix + inputmat(k,l)*Gauss(k,l)*exp(((inputmat(k,l)-centre)^2)*excoefint)*denint;
        intsum = intsum + Gauss(k,l)*exp(((inputmat(k,l)-centre)^2)*excoefint)*denint;
    end
end
pix = intpix/intsum;