%% Q2: Edge-preserving Smoothing using Bilateral Filtering.
% All randomness is seeded so that exact RMSD values can be observed

%% First Image
%%  
% Optimized value of Sigma was found empirically to be 1.4 along space and
% 10 along intensity axis. 
imstruct = load('../data/barbara.mat');
im = imstruct.imageOrig;
spread = max(im,[],'all') - min(im,[],'all');
rng(0);
noise = (0.05*spread).*randn(size(im,1));
ns = im + noise;
cleaned = myBilateralFiltering(ns,1.0*1.4,1.0*10);
global Gauss
f = figure('visible','on');
f.WindowState = 'maximized';
subplot(1, 3, 1)
imshow(mat2gray(im),'InitialMagnification','fit')
title({'Original Image', 'of Barbara'});
subplot(1, 3, 2)
imshow(mat2gray(ns),'InitialMagnification','fit')
title({'Corrupted Image' ,'of Barbara'});
subplot(1, 3, 3)
imshow(mat2gray(cleaned),'InitialMagnification','fit')
title({'Filtered Image' ,'of Barbara'});
rmsd = sqrt(mean((cleaned-im).^2, 'all'));
ogrmsd = sqrt(mean((ns-im).^2, 'all'));

%%  
%  Denoised RMSD values for different (spatial sigma, intensity sigma) around optimal pair (1.4,10) are as follows-
%  Without Filtering - 5.000
%  (1.4,10) - 3.2908 
%  (0.9*1.4,10)- 3.2961 
%  (1.1*1.4,10) - 3.2925
%  (1.4,0.9*10) - 3.3154
%  (1.4,1.1*10) - 3.3039
%%
f = figure('visible','on');
subplot(1, 1, 1)
imshow(mat2gray(Gauss),'InitialMagnification','fit')
title("Spatial Gaussian Kernel displayed as an image");
%% Second Image
%%
% Optimized value of Sigma was found empirically to be 0.7 along space and
% 55 along intensity axis. 


im = imread('../data/grass.png');
im = double(im);
spread = range(im,'all');
rng(0);
noise = (0.05*spread).*randn(size(im,1));
ns = im + noise;
cleaned = myBilateralFiltering(ns,0.7*1.0,55*1.1);
f = figure('visible','on');
f.WindowState = 'maximized';
subplot(1, 3, 1)
imshow(mat2gray(im),'InitialMagnification','fit')
title("Clean Image of Grass");
subplot(1, 3, 2)
imshow(mat2gray(ns),'InitialMagnification','fit')
title("Corrupted Image of Grass");
subplot(1, 3, 3)
imshow(mat2gray(cleaned),'InitialMagnification','fit')
title("Filtered Image of Grass");
rmsd = sqrt(mean((cleaned-im).^2, 'all'));
ogrmsd = sqrt(mean((ns-im).^2, 'all'));
%%  
%  Denoised RMSD values for different (spatial sigma, intensity sigma) around optimal pair (0.7,55) are as follows-
%  Without Filtering - 11.7669
%  (0.7,55) - 7.3971 
%  (0.9*0.7,55)- 7.5501
%  (1.1*0.7,55) - 7.4692
%  (0.7,0.9*55) - 7.3991
%  (0.7,1.1*55) - 7.4181
%%
f = figure('visible','on');
subplot(1, 1, 1)
imshow(mat2gray(Gauss),'InitialMagnification','fit')
title("Spatial Gaussian Kernel displayed as an image");
%% Third Image
% Optimized value of Sigma was found empirically to be 1.0 along space and
% 36 along intensity axis. Note that exact values depend on the run as the
% random seed is not fixed.

im = imread('../data/honeyCombReal.png');
im = double(im);
spread = range(im,'all');
rng(0);
noise = (0.05*spread).*randn(size(im,1));
ns = im + noise;
cleaned = myBilateralFiltering(ns,1.0*1.0,36*1.0);
f = figure('visible','on');
f.WindowState = 'maximized';
subplot(1, 3, 1)
imshow(mat2gray(im),'InitialMagnification','fit')
title({'Clean Image', 'of Honeycomb'});
subplot(1, 3, 2)
imshow(mat2gray(ns),'InitialMagnification','fit')
title({'Corrupted Image' ,'of Honeycomb'});
subplot(1, 3, 3)
imshow(mat2gray(cleaned),'InitialMagnification','fit')
title({'Filtered Image', 'of Honeycomb'});
rmsd = sqrt(mean((cleaned-im).^2, 'all'));
ogrmsd = sqrt(mean((ns-im).^2, 'all'));
%%  
%  Denoised RMSD values for different (spatial sigma, intensity sigma) around optimal pair (1.0,36) are as follows-
%  Without Filtering - 12.6648
%  (1.0,36) - 7.3176 
%  (0.9*1.0,36)- 7.3626 
%  (1.1*1.0,36) - 7.3313
%  (1.0,0.9*36) - 7.3805
%  (1.0,1.1*36) - 7.3196
%%
f = figure('visible','on');
subplot(1, 1, 1)
imshow(mat2gray(Gauss),'InitialMagnification','fit')
title("Spatial Gaussian Kernel displayed as an image");
%% References
%%  
% Increasing size of figure window - https://in.mathworks.com/matlabcentral/answers/102219-how-do-i-make-a-figure-full-screen-programmatically-in-matlab

