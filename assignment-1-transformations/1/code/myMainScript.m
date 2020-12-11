%% Q1
% We keep the number of colours per intensity to be 200, as specified in
% the assignment submission instructions.
%
% Throughout this question, we have used the following references: 
%
% 1) MATLAB documentation: https://in.mathworks.com/help/matlab/examples.html?category=images_images
%
% 2) In specific, from MATLAB documentation we referred to various
% functions such as imagesc/imread and derivates, truesize and other image
% output controlling functions. We also used standard matlab functions such
% as imrotate to confirm the proper working of our codes as compared to the
% standard MATLAB implementations.
%
% 3) The following "Lectures on Image Processing" were helpful for us to understand
% a practical implementation of the various interpolation functions: 
% https://ia802707.us.archive.org/23/items/Lectures_on_Image_Processing/EECE_4353_15_Resampling.pdf

%keeping number of colours per intensity to be 200
myNumOfColors = 200;
myColorScale = [ [0:1/(myNumOfColors-1):1]' , ...
    [0:1/(myNumOfColors-1):1]' , [0:1/(myNumOfColors-1):1]' ];
tic;
%% Q1a
circle_concentric_1 = imread('../data/circles_concentric.png');

%shrink the image by different factors
circle_concentric_2 = myShrinkImageByFactorD(circle_concentric_1,2);
circle_concentric_3 = myShrinkImageByFactorD(circle_concentric_1,3);

%plot the images side-by-side
subplot(1,1,1), imagesc(circle_concentric_1);
daspect ([1 1 1]);
truesize([300 300]);
title('Original Image');
colorbar;
colormap (myColorScale);
colormap gray;
%%
subplot(1,1,1), imagesc(circle_concentric_2);
daspect ([1 1 1]);
truesize([300 300]);
title('Image with d = 2');
colorbar;
colormap (myColorScale);
colormap gray;
%%
subplot(1,1,1), imagesc(circle_concentric_3);
daspect ([1 1 1]);
truesize([300 300]);
title('Image with d = 3');
colorbar;
axis tight;
colormap (myColorScale);
colormap gray;
%% Q1b
bar = imread('../data/barbaraSmall.png');
bar = double(bar)/255;
[row_bar, col_bar] = size(bar);
output_dim = [row_bar*3-2, col_bar*2-1];

% phi_x[i][j], phi_y[i][j] represents where position (i,j) in output
% image comes from - value will be some real valued x and real valued y
% in the input image
[phi_y, phi_x] = meshgrid(1:output_dim(2),1:output_dim(1));

%make the correct phi_x, phi_y for resizing
phi_x = (phi_x + 2) / 3;
phi_y = (phi_y + 1) / 2;

%do the interpolation
biliterpbar = myBilinearInterpolation(bar, phi_x, phi_y);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,1,1), imagesc(single(bar));
daspect ([1 1 1]);
truesize([300 300]);
title('Original Image');
colorbar
%%
subplot(1,1,1), imagesc(single(biliterpbar));
daspect ([103/307 103/205 1]);
truesize([300 300]);
title('Bilinear Interpolation');
colorbar

%% Q1c
NNiterpbar = myNearestNeighborInterpolation(bar, phi_x, phi_y);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,1,1), imagesc(single(bar));
daspect ([1 1 1]);
colorbar
title('Original Image');
%%
subplot(1,1,1), imagesc(single(NNiterpbar)); % phantom is a popular test image
daspect ([103/307 103/205 1]);
title('Nearest Neighbor Interpolation');
colorbar

%% Q1d
bicubic_iterp_bar = myBicubicInterpolation(bar, phi_x, phi_y);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,1,1), imagesc(single(bar));
daspect ([1 1 1]);
title('Original Image');
colorbar
%%
subplot(1,1,1), imagesc(single(bicubic_iterp_bar)); % phantom is a popular test image
daspect ([103/307 103/205 1]);
title('Bicubic Interpolation');
colorbar
%% Q1e
%%
% We show Barbara's face, smoothed using different methods. We
% observe from the results that bicubic and bilinear interpolation are
% clearly much better than nearest neighbor interpolation. This is also
% apparent from the resizing comparison in the previous subparts.
% The differences between Bilinear and Bicubic are subtle in this image, but
% bicubic stands out. This is more clearly seen on a grayscale image, which
% are shown in the previous subparts. On Comparison, it is clear that
% Bicubic interpolation performs better than Bilinear in practice.
%
% This follows the expected results from interpolation theory - Bicubic is a
% 3rd degree polynomial approximation, thus it is able to capture more
% information of the image and smoothen out the image better. Bilinear
% interpolation is a linear approximation over the 2 dimensions. Nearest
% Neighbor is a zero-th order approximation over it's surroundings, and thus
% it performs significantly worse, while being the easiest to implement.

%%
barbara_face = bar(1:70,34:103);

[face_phi_y, face_phi_x] = meshgrid(1:140,1:140);
face_phi_x = (face_phi_x + 1) / 2;
face_phi_y = (face_phi_y + 1) / 2;

barbara_face_NN = myNearestNeighborInterpolation(barbara_face, face_phi_x, face_phi_y);
barbara_face_bilinear = myBilinearInterpolation(barbara_face, face_phi_x, face_phi_y);
barbara_face_bicubic = myBicubicInterpolation(barbara_face, face_phi_x, face_phi_y);

axis tight;
colormap (myColorScale);
colormap jet;
subplot(1,1,1), imagesc(single(barbara_face)); % phantom is a popular test image
daspect ([1 1 1]);
title('Original Image');
colorbar
%%
subplot(1,1,1), imagesc(single(barbara_face_NN));
daspect ([1/2 1/2 1]);
title('Nearest Neighbor');
colorbar
%%
subplot(1,1,1), imagesc(single(barbara_face_bilinear));
daspect ([1/2 1/2 1]);
title('Bilinear');
colorbar
%%
subplot(1,1,1), imagesc(single(barbara_face_bicubic));
daspect ([1/2 1/2 1]);
title('Bicubic');
colorbar
%% Q1f
% We pad the image so as to not lose information in the rotation.
padded_bar = zeros(140,140);
padded_bar(20:122,20:122) = bar;
%This function takes anti-clockwise rotations as positive.
final = myImageRotation(padded_bar, -30);
axis tight;
colormap (myColorScale);
colormap gray;
subplot(1,1,1), imagesc(bar);
daspect ([1 1 1]);
title('Original Image');
colorbar
%%
subplot(1,1,1), imagesc(final);
daspect ([1 1 1]);
colormap (myColorScale);
colormap gray;
title('30 degree rotation');
colorbar