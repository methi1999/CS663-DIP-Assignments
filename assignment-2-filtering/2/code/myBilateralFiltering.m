function y = myBilateralFiltering(inputim, sigmasp, sigmaint)
densp=1/(sigmasp*sqrt(2*pi));
global denint excoefint Gauss
denint = 1/(sigmaint*sqrt(2*pi));
excoefsp= -1/(2*sigmasp^2);
excoefint = -1/(2*sigmaint^2);

%Need to select padding
pad =size(inputim,1);
threshold = 0.01;
for i = 1:size(inputim,1)
    expi = exp((i^2)*excoefsp)*densp;
    if expi <threshold
        pad= i-1;
        break
    end
end
wi=padarray(inputim,[pad,pad]);
% ^ Pad the file  
% Create Gaussian matrix for spatial calculations
Gauss = zeros(2*pad+1,2*pad+1);
for i = 1:2*pad+1
    for j = 1:2*pad+1
        Gauss(i,j)=exp(((i-pad-1)^2+(j-pad-1)^2)*excoefsp)*densp;
    end
end
%subplot(1, 1, 1)
%imshow(mat2gray(Gauss))
%title("Spatial Gaussian Kernel displayed as an image");
myfilterhandle = @bilatfilt;
result = nlfilter(wi,[2*pad+1 2*pad+1], @(x) bilatfilt(x));
y = result(pad+1:end-pad,pad+1:end-pad);
% function to calculate each filtered pixel
       
