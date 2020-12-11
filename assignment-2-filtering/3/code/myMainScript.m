%% References & Ideology
% We used the following references for this question:
%
% 1) The MATLAB documentation:
%
% https://in.mathworks.com/matlabcentral/answers/316163-how-to-get-pixelcount-in-image
%
% https://in.mathworks.com/matlabcentral/answers/13020-2d-gaussian-function
%
% https://www.mathworks.com/help/images/ref/nlfilter.html
% 
% In this question, we note that patch filtering has two tunable parameters
% in general: one of them is the $\sigma_g$ parameter for the gaussian patch,
% and the other is the $\sigma_w$ parameter for the window. Here, we set the
% $\sigma_g$ parameter of the gaussian patch to be 1.5 (since the patch is 9*9,
% this is a reasonably small value of sigma that should work well). 
%
% Then, we tune the $\sigma_w$ value of the window, which was asked in the
% question.
%
% Although having implemented and tested it (about 4.2x faster),
% we decided not to use Gaussian blurring + Downsampling, since the quality
% degradation is observable. Since we had enough time for the assignment,
% we decided to use only the high quality outputs, thus keeping the RMSD
% values significantly lower than the downsampled output.

%%
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% Q3a
% The optimal $\sigma_w$ is 0.66
%
% The RMSD for optimal $\sigma_w$ is 2.5824
%
% The RMSD for optimal $\sigma_w$ * 0.9 is 2.6197
%
% The RMSD for optimal $\sigma_w$ * 1.1 is 2.6473
%
%Since the images have been generated and stored in the images directory, 
%we will be directly loading the outputs and reporting them. 
%The original images can be recomputed by the code below.

first_im = load('../images/barbara_first.mat');
input_im = load('../images/barbara_input.mat');
output_im_sigma = load('../images/barbara_sigma.mat');
output_im_large_sigma = load('../images/barbara_large_sigma.mat');
output_im_small_sigma = load('../images/barbara_small_sigma.mat');

first_im = double(cell2mat(struct2cell(first_im)));
input_im = double(cell2mat(struct2cell(input_im)));
output_im_sigma = double(cell2mat(struct2cell(output_im_sigma)));
output_im_large_sigma = double(cell2mat(struct2cell(output_im_large_sigma)));
output_im_small_sigma = double(cell2mat(struct2cell(output_im_small_sigma)));

% images = {'../data/barbara.mat'};
% im = 1;
% path = images{im};
% input_im = load(path);
% input_im = cell2mat(struct2cell(input_im));
% input_im = double(input_im);
% first_im = input_im;
% spread = range(input_im,'all');
% rng(0);
% noise = (0.05*spread)*randn(size(input_im,1));
% input_im = input_im + noise;
% output_im_sigma = myPatchBasedFiltering(input_im, 0.66);
% output_im_small_sigma = myPatchBasedFiltering(input_im, 0.9 * 0.66);
% output_im_large_sigma = myPatchBasedFiltering(input_im, 1.1 * 0.66);
%%
imagesc(first_im);
daspect ([1 1 1]);
title('Original Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(input_im);
daspect ([1 1 1]);
title('Corrupted Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(output_im_sigma);
daspect ([1 1 1]);
title('Filtered Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
%ok
% diff = output_im_small_sigma - first_im;
% diff = diff .^ 2;
% diff = sum(diff, 'all');
% num_pixels = numel(first_im);
% RMSE = sqrt(1.0 / num_pixels * diff);
% RMSE
%% Q3b
% The optimal $\sigma_w$ is 0.88 
% 
% The RMSD for optimal $\sigma_w$ is 3.8867
%
% The RMSD for optimal $\sigma_w$ * 0.9 is 3.9041
%
% The RMSD for optimal $\sigma_w$ * 1.1 is 3.9810

%Since the images have been generated and stored in the images directory, 
%we will be directly loading the outputs and reporting them. 
%The original images can be recomputed by the code below.

first_im = load('../images/grass_first.mat');
input_im = load('../images/grass_input.mat');
output_im_sigma = load('../images/grass_sigma.mat');
output_im_large_sigma = load('../images/grass_large_sigma.mat');
output_im_small_sigma = load('../images/grass_small_sigma.mat');

first_im = double(cell2mat(struct2cell(first_im)));
input_im = double(cell2mat(struct2cell(input_im)));
output_im_sigma = double(cell2mat(struct2cell(output_im_sigma)));
output_im_large_sigma = double(cell2mat(struct2cell(output_im_large_sigma)));
output_im_small_sigma = double(cell2mat(struct2cell(output_im_small_sigma)));

% images = {'../data/grass.png'};
% im = 1;
% path = images{im};
% input_im = imread(path);
% input_im = double(input_im);
% first_im = input_im;
% rng(0);
% noise = (0.05*spread)*randn(size(input_im,1));    
% input_im = input_im + noise;
% output_im_sigma = myPatchBasedFiltering(input_im, 0.88);
% output_im_small_sigma = myPatchBasedFiltering(input_im, 0.9 * 0.88);
% output_im_large_sigma = myPatchBasedFiltering(input_im, 1.1 * 0.88);
%%
imagesc(first_im);
daspect ([1 1 1]);
title('Original Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(input_im);
daspect ([1 1 1]);
title('Corrupted Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(output_im_sigma);
daspect ([1 1 1]);
title('Filtered Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
%ok
% diff = output_im_small_sigma - first_im;
% diff = diff .^ 2;
% diff = sum(diff, 'all');
% num_pixels = numel(first_im);
% RMSE = sqrt(1.0 / num_pixels * diff);
% RMSE
%% Q3c
% The optimal $\sigma_w$ is 0.9
%
% The RMSD for optimal $\sigma_w$ is 3.9328
%
% The RMSD for optimal $\sigma_w$ * 0.9 is 3.9387
%
% The RMSD for optimal $\sigma_w$ * 1.1 is 4.0038

%Since the images have been generated and stored in the images directory, 
%we will be directly loading the outputs and reporting them. 
%The original images can be recomputed by the code below.

first_im = load('../images/honeycomb_first.mat');
input_im = load('../images/honeycomb_input.mat');
output_im_sigma = load('../images/honeycomb_sigma.mat');
output_im_large_sigma = load('../images/honeycomb_large_sigma.mat');
output_im_small_sigma = load('../images/honeycomb_small_sigma.mat');

first_im = double(cell2mat(struct2cell(first_im)));
input_im = double(cell2mat(struct2cell(input_im)));
output_im_sigma = double(cell2mat(struct2cell(output_im_sigma)));
output_im_large_sigma = double(cell2mat(struct2cell(output_im_large_sigma)));
output_im_small_sigma = double(cell2mat(struct2cell(output_im_small_sigma)));

% images = {'../data/honeyCombReal.png'};
% im = 1;
% path = images{im};
% input_im = imread(path);
% input_im = double(input_im);
% first_im = input_im;
% rng(0);
% noise = (0.05*spread)*randn(size(input_im,1));    
% input_im = input_im + noise;
% output_im_sigma = myPatchBasedFiltering(input_im, 0.9);
% output_im_small_sigma = myPatchBasedFiltering(input_im, 0.9 * 0.9);
% output_im_large_sigma = myPatchBasedFiltering(input_im, 1.1 * 0.9);
%%
imagesc(first_im);
daspect ([1 1 1]);
title('Original Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(input_im);
daspect ([1 1 1]);
title('Corrupted Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
imagesc(output_im_sigma);
daspect ([1 1 1]);
title('Filtered Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
%ok
% diff = output_im_large_sigma - first_im;
% diff = diff .^ 2;
% diff = sum(diff, 'all');
% num_pixels = numel(first_im);
% RMSE = sqrt(1.0 / num_pixels * diff);
% RMSE
%% Q3d
% The intensity diagram for the isotropic gaussian patch is as follows
gaussian_patch = zeros(9,9);
gauss_normal = 0;
gaussian_sigma = 1.5;
for i = 1:9
    for j = 1:9
        exponent = ((i-5).^2 + (j-5).^2)./(2*gaussian_sigma.^2);
        to_add = exp(-exponent);
        gaussian_patch(i,j) = to_add;
        gauss_normal = gauss_normal + to_add;
    end
end

gaussian_patch = gaussian_patch / gauss_normal;
imagesc(gaussian_patch);
daspect ([1 1 1]);
title('Gaussian Mask');
colorbar;
colormap (myColorScale);
colormap gray;