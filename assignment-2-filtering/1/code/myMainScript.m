%% Q1: Image Sharpening using Unsharp Masking

% Let F be the original image, G be the Gaussian filter. Steps:
%%
% # F*G (F convolved with G) gives a low-pass version of the image.
% # Subtracting this low-pass version of F from F i.e. F - F*G can be
% considered as the high-pass version of F since the low-pass components
% have been subtracted.
% # Adding a scaled version of this high-pass version i.e. F + s(F - F*G)
% enhances the edges since they can be considered as the high-pass
% components of an image. s is a scaling factor which needs to be tuned.

%% Image 1

% Parameters:
%%
% * Standard deviation of Gaussian: 5
% * Scaling factor: 0.9

clc
imstruct = load('../data/lionCrop.mat');
im = imstruct.imageOrig;
sigma = 5;
filter_len = 4*sigma;
scaling = 0.9;
[orig, sharp, mask] = myUnsharpMasking(im, filter_len, sigma, scaling);
f = figure('visible', 'on');
subplot(1, 2, 1)
imshow(mat2gray(orig))
title("Original Image");
subplot(1, 2, 2)
imshow(mat2gray(sharp))
title("Sharp Image");
%%
f = figure('visible', 'on');
subplot(1, 1, 1)
imshow(mat2gray(imresize(mask, 0.5)))
title("High-pass version which is added");
%%
% Most of the percpetible change can be seen in the mane of the lion.
%% Image 2

% Parameters:
%%
% * Standard deviation of Gaussian: 10
% * Scaling factor: 0.5

clc
imstruct = load('../data/superMoonCrop.mat');
im = imstruct.imageOrig;
sigma = 10;
filter_len = sigma*5;
scaling = 0.5;
[orig, sharp, mask] = myUnsharpMasking(im, filter_len, sigma, scaling);
f = figure('visible', 'on');
subplot(1, 2, 1)
imshow(mat2gray(orig))
title("Original Image");
subplot(1, 2, 2)
imshow(mat2gray(sharp))
title("Sharp Image");

f = figure('visible', 'on');
subplot(1, 1, 1)
imshow(mat2gray(imresize(mask, 0.5)))
title("High-pass version which is added");
%%
% The main difference can be seen in the cluster on the left.