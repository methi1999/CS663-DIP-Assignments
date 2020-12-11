%% Q4
% References used for this problem:
%
% 1) https://in.mathworks.com/help/matlab/ref/fftshift.html
%
% 2) https://in.mathworks.com/help/matlab/ref/fft2.html
%
% 3) https://in.mathworks.com/help/matlab/ref/ifft2.html
%
% 4) https://in.mathworks.com/help/matlab/ref/ifftshift.html
%
% 5) https://in.mathworks.com/help/images/ref/padarray.html
%
%
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% a) Ideal Low Pass Filter
% D was taken to be 40, 60, 80
%
% We observe that, even though high frequency information is removed, the
% amount of ringing in the image has increased, and thus the image is not
% very pleasant to look at. Thus, this is clearly undesirable.
% We padded [H, W] to [2H, 2W], as given in the slides. However, to get the
% same frequency range as D = 40 would imply in [H, W], we should map D to
% 2D in the [2H, 2W] space. Thus, the filter are of size 512 x 512 (since
% they are applied on the padded image). This can be imagined as a linear
% interpolation.
barbara = imread('../data/barbara256.png');
padding = size(barbara)./2;
padded_barbara = barbara;
padded_barbara = padarray(barbara, padding);
imagesc(barbara);
title('Original Image');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[low_pass_barbara, H] = idealLowPassFilter(padded_barbara, 40);
low_pass_barbara = low_pass_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(low_pass_barbara);
title('Filtered Image, D = 40');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Low Pass Filter Frequency plot, D = 40, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[low_pass_barbara, H] = idealLowPassFilter(padded_barbara, 60);
low_pass_barbara = low_pass_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(low_pass_barbara);
title('Filtered Image, D = 60');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Low Pass Filter Frequency plot, D = 60, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[low_pass_barbara, H] = idealLowPassFilter(padded_barbara, 80);
low_pass_barbara = low_pass_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(low_pass_barbara);
title('Filtered Image, D = 80');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Low Pass Filter Frequency plot, D = 80, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%% b) Gaussian Filter
% Sigma was taken to be 40, 60, 80
%
% Not much ringing is observed. There is smoothening of the image and
% blurring of the edges as in the previous attempt, and you can see some
% high frequency components in the face region and elsewhere, which were removed in the previous part.
% Using the same idea as in the previous part, we map D to 2D and pad [H,
% W] to [2H, 2W]
[gauss_barbara, H] = idealGaussianFilter(padded_barbara, 40);
gauss_barbara = gauss_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(gauss_barbara);
title('Filtered Image, sigma = 40');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Gaussian Filter Frequency plot, sigma = 40, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[gauss_barbara, H] = idealGaussianFilter(padded_barbara, 60);
gauss_barbara = gauss_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(gauss_barbara);
title('Filtered Image, sigma = 60');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Gaussian Filter Frequency plot, sigma = 60, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
[gauss_barbara, H] = idealGaussianFilter(padded_barbara, 80);
gauss_barbara = gauss_barbara(padding(1)+1:end-padding(1), padding(2)+1:end-padding(2));
imagesc(gauss_barbara);
title('Filtered Image, sigma = 80');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
imagesc(log(abs(H)+1));
title('Gaussian Filter Frequency plot, sigma = 80, log scale');
colorbar;
daspect ([1 1 1]);
colormap(myColorScale);
colormap gray;
%%
toc;
