%% Q5
%% Clean Image
% We begin this section by creating images I and J as 300x300 size uint8
% matrices. After bringing these input images into Fourier Domain we try to
% estimate the shift along x axis and y axis when comparing image I and J.
% We generate phase values at (10,10), (11,10) and (10,11) as per equation 
% (3) given in the paper " An FFT-based technique for Translation, Rotation 
% and Scale-Invariant Image rotation".
%
% By dividing the complex phase value that we generate for coordinates of
% the form (x+1,y) by that of (x,y) we calculate the xshift (after
% appropriate scaling). Similarly we use coordinates of the form (x,y+1)
% and (x,y) to generate the shift in y. We can evaluate this anywhere on the grid 
% but we chose (10,10) for all experiments. 
% 
% The Log fourier magnitude transform of the cross power spectrum shows a maxima at 
% 271,71. This corresponds to -30,70 shift values.
clear;
I = zeros(300,'uint8');
I(50:100,50:120) = 255;
%imshow(I)
J = zeros(300,'uint8');
J(20:70,120:190) = 255;
%imshow(J)
%If = fftshift(fft2(I));
If = fft2(I);
Ifmag = abs(If);
%prodIfmag = prod(If);
%Jf = fftshift(fft2(J));
Jf = fft2(J);
Jfmag = abs(Jf);
Jfc = conj(Jf);
Expnum = If.*Jfc;
Expden = Ifmag.*Jfmag;
CrossPowSpec = Expnum./Expden;
Logcrosspowerspec = log(abs(fft2(CrossPowSpec))+1);
imagesc(Logcrosspowerspec)
colorbar
title('Log Fourier magnitude of Cross Power Spectrum')
prediction1 = If(10,10)*Jfc(10,10)/(Ifmag(10,10)*Jfmag(10,10));
prediction2 = If(11,10)*Jfc(11,10)/(Ifmag(11,10)*Jfmag(11,10));
prediction3 = If(10,11)*Jfc(10,11)/(Ifmag(10,11)*Jfmag(10,11));
xshift = 300*angle(prediction2/prediction1)./(2*pi);
yshift = 300*angle(prediction3/prediction1)./(2*pi);
text = ['Predicted Xshift = ',num2str(xshift),' Predicted Yshift = ',num2str(yshift)];
disp(text)
%% Noisy Image
% In order to display consistent results for report we tested with a fixed
% random seed set to default (i.e. default seed (0) and algorithm (Mersenne Twister))
% All settings for this experiment are the same as the previous part, with
% the exception of the addition of gaussian noise of zero mean and variance
% of 20. This leads to inconsistent predictions for shift.
% 
% The effect of this is clearly demonstrated in the Log fourier magnitude 
% transform of the cross power spectrum, where a maxima is visible at
% -30,70 but this peak is plagued by a a very low SNR. 
clear;
rng('default');
I = zeros(300,'double');
I(50:100,50:120) = 255;
I = I + 20*randn(300);
%imshow(I)
J = zeros(300,'double');
J(20:70,120:190) = 255;
J = J + 20*randn(300);
If = fft2(I);
Ifmag = abs(If);
%prodIfmag = prod(If);
%Jf = fftshift(fft2(J));
Jf = fft2(J);
Jfmag = abs(Jf);
Jfc = conj(Jf);
Expnum = If.*Jfc;
Expden = Ifmag.*Jfmag;
CrossPowSpec = Expnum./Expden;
Logcrosspowerspec = log(abs(fft2(CrossPowSpec))+1);
imagesc(Logcrosspowerspec)
colorbar
title('Log Fourier magnitude of Cross Power Spectrum')
x=10;
y=10;
prediction1 = If(x,y)*Jfc(x,y)/(Ifmag(x,y)*Jfmag(x,y));
prediction2 = If(x+1,y)*Jfc(x+1,y)/(Ifmag(x+1,y)*Jfmag(x+1,y));
prediction3 = If(x,y+1)*Jfc(x,y+1)/(Ifmag(x,y+1)*Jfmag(x,y+1));
xshift = 300*angle(prediction2/prediction1)./(2*pi);
yshift = 300*angle(prediction3/prediction1)./(2*pi);
text = ['single coordinate based Predicted Xshift = ',num2str(xshift),' Predicted Yshift = ',num2str(yshift)];
disp(text)
%totxshift
%=0;
%totyshift =0;
%for i =1:299
%   for j = 1:299
%       x=i;
%       y=j;
%       prediction1 = If(x,y)*Jfc(x,y)/(Ifmag(x,y)*Jfmag(x,y));
%       prediction2 = If(x+1,y)*Jfc(x+1,y)/(Ifmag(x+1,y)*Jfmag(x+1,y));
%       prediction3 = If(x,y+1)*Jfc(x,y+1)/(Ifmag(x,y+1)*Jfmag(x,y+1));
%       totxshift = totxshift+ 300*angle(prediction2/prediction1)./(2*pi);
%       totyshift = totyshift +300*angle(prediction3/prediction1)./(2*pi);
%   end
%end
%totxshift = totxshift/(299*299);
%totyshift = totyshift/(299*299);
%% Complexity of Algorithm
% For an NxN image, a pixel wise image comparison would take the order of N^4 operations, 
% as there are N^2 pixels to compare, and N^2 locations that the image has
% to be shifted to for each comparison. In contrast this approach takes the
% order of Nlog(N) operations to generate DFT, followed by matrix
% multiplications that can take upto order N^2 to generate. Therefore DFT based approach takes order N^2,
% making it much faster than pixel wise comparison.

%% Rotation of Images
% In the case of translation of image we were provided with a simple linear
% equation, where we could fix value of one coordinate and increase value
% of the other to obtain a unit change. This was used to evaluate x and y
% translation shifts.
% 
% In the case of a rotated image, we are fortunate to receive similar linear
% equations, but we first convert the image into its magnitude components
% removing the effect of translation. Subsequently we convert the image
% into a polar representation, where there is a displacement in one
% coordinate, which is the angle. We can follow exactly the same steps that we have
% done for calculating shift in x and y coordinates, applied to r (radius)
% and $\theta$ (angle) coordinates.
% 
% $M_{1}(r, \theta) = M_{2}(r, \theta - \theta _{0})$ is identical to
% solving $F_{1} (x,y) = F_{2}(x-x_{0},y-y_{0})$ for $x_{0} = 0$.
% 
% Here we generate $M_{1}$ and $M_{2}$ from input images by first applying
% DFT to the input images which and taking magnitude to remove phase
% difference corresponding to image translation.