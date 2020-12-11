%% Q3
%%
% To remove the periodic noise, we apply a notch filter. The steps are
% given below:
%
% # Pad the HxW image to get a 2Hx2W image.
% # Calculate the 2D Fourier Transform.
% # Examine the log magnitude plot to find the noise frequency. We found
% the periodic noise pattern at (u, v) bins: (277, 267) and (237, 247).
% (Since the image is real, the plot is symmetric about
% the centre frequency.)
% # Apply a notch filter centred at (x,y). The notch filter has a one sided-window
% of length 7 such that the border pixels have an attenuation of 1
% and as we move in towards the centre, the attenuation of all 8 pixels
% which are equidistant from the centre gets multiplied by $10^{-2}$.
% # Calculate the inverse 2D DFT and crop out the central HxW portion. This
% is the final desired filtered image.

% Load noisy image
orig = load('../data/image_low_frequency_noise.mat').Z;
% define notch
w = int16(7);
total = 2*w+1;
notch = ones(total,total);
for i = 1:w
    notch(1+i:total-i, 1+i:total-i) = 1e-2*notch(1+i:total-i, 1+i:total-i);
end
% pad and fourier
padding = size(orig)./2;
padded_image = padarray(orig, padding);
padded_fourier = fftshift(fft2(padded_image));
log_fourier = log(abs(padded_fourier)+1);
% imagesc(log_fourier);
% colorbar;
% apply filter
filtered_fourier = myNotchFilter(padded_fourier, 277, 267, notch, w);
log_fil_fourier = log(abs(filtered_fourier)+1);
% imagesc(log_fil_fourier);
% colorbar;
% get back original image
filtered = real(ifft2(ifftshift(filtered_fourier)));
% crop
filtered = filtered(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2)); 
% imagesc(filtered);
%% Images
subplot(2,1,1), imagesc(orig);
daspect([1 1 1]);
colorbar;
title('Original');
subplot(2,1,2), imagesc(filtered);
daspect([1 1 1]);
colorbar;
title('Filtered');
%% Fourier plots
subplot(2,1,1), imagesc(log_fourier);
daspect([1 1 1]);
colorbar;
title('Original');
subplot(2,1,2), imagesc(log_fil_fourier);
daspect([1 1 1]);
colorbar;
title('Filtered');
% colorbar;

%% Notch filter
subplot(1,1,1);
imagesc(log(notch));
title('Log magnitude');
daspect([1 1 1]);
colorbar;