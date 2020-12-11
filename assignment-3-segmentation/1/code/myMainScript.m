%% Q1
% References:
%
% 1) We used nlfilter from the matlab standard documentation. 
%
% 2) We used the class slides for the definition of structure tensor. The
% formulae for the eigenvalues could easily be derived from there.
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% Q1a
% For the gaussian blurring, we use a 9*9 sliding window with a variance of
% 0.6.
boat_im = load('../data/boat.mat');
boat_im = double(cell2mat(struct2cell(boat_im)));

boat_im = boat_im - min(min(boat_im));
boat_im = boat_im / (1.0 * max(max(boat_im)));

boat_im_blur = nlfilter(boat_im, [9,9], @(x) myGaussianBlurring(x, 9, 0.6));
%%
subplot(1,1,1), imagesc(boat_im);
daspect ([1 1 1]);
title('Original Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
subplot(1,1,1), imagesc(boat_im_blur);
daspect ([1 1 1]);
title('Blurred Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
[partialX, partialY, grad_im, eigen_prim, eigen_second, cornerness_im] = myHarrisCornerDetector(boat_im_blur, 9, 0.6, 0.03);
%% Q1b
subplot(1,1,1), imagesc(partialX);
daspect ([1 1 1]);
title('Partial Derivative along X axis');
colorbar;
colormap (myColorScale);
colormap gray;
%%
subplot(1,1,1), imagesc(partialY);
daspect ([1 1 1]);
title('Partial Derivative along Y axis');
colorbar;
colormap (myColorScale);
colormap gray;
%%
% (We also plot the gradient as a sanity check)
subplot(1,1,1), imagesc(grad_im);
daspect ([1 1 1]);
title('Gradient Plot');
colorbar;
colormap (myColorScale);
colormap gray;
%% Q1c
% We note that the principal eigenvalue is large whenever there is an edge
% or corner, which clearly seems to match the theoretical expectations.
subplot(1,1,1), imagesc(eigen_prim);
daspect ([1 1 1]);
title('Principal Eigenvalue of Structure Tensor');
colorbar;
colormap (myColorScale);
colormap gray;
%%
% The secondary eigenvalue is only large when a corner is present.
subplot(1,1,1), imagesc(eigen_second);
daspect ([1 1 1]);
title('Other Eigenvalue of Structure Tensor');
colorbar;
colormap (myColorScale);
colormap gray;
%% Q1d
% In the computation of the structure tensor, we use a 9*9 gaussian with a
% 0.6 variance. The free parameter k = 0.03, which is chosen such that the
% points which are neither edges nor corners have cornerness values close
% to zero and the points which are edges and not corners have negative
% cornerness values.

subplot(1,1,1), imagesc(cornerness_im);
daspect([1 1 1]);
title('Harris Cornerness Measure');
colorbar;
colormap (myColorScale);
colormap gray;

%% 
% We superimpose the cornerness measure after thresholding with the
% original image to see the corners. The threshold value is chosen as
% 2e-5. The white points denote corners.

new_cornerness = cornerness_im > 0.000020;
new_cornerness = new_cornerness - min(min(new_cornerness));
new_cornerness = new_cornerness / max(max(new_cornerness));
new_cornerness = new_cornerness + boat_im_blur;
new_cornerness = new_cornerness - min(min(new_cornerness));
new_cornerness = new_cornerness / max(max(new_cornerness));
subplot(1,1,1), imagesc(new_cornerness);
daspect ([1 1 1]);
title('Superimposed image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
toc;