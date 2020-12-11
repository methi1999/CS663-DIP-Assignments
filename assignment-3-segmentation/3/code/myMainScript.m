%% Q3: Background blur

%%
% The Algorithm:
%%
% # Apply Mean Shift Segmentation (use code from the previous part) and knnsearch (with k=2) to get 2 segments.
% Then use the built-in function _bwareafilt_ to extract the largest contour. For both
% bird and the flower, the largest contour luckily turns out to be the
% actual foreground. In other cases, we will need manual intervention in
% this step. The foreground mask is stored in the _results/_ directory for
% quickly running the code. 
% # Use Canny Edge detection (built-in MATLAB function) to get the boundary
% of the foreground.
% # Initialise a matrix (Same size as that of image) with all alphas where
% (i,j) entry denotes the minimum distance of the pixel from the foreground mask.
% Then iterate over all the boundary pixels. For each boundary
% pixel, iterate over the radius from 1 to alpha and find all pixels (i,j)
% such that their distance from current boundary pixel is between r-1 and r.
% Set matrix(i,j) to min(matrix(i,j), r). Set radius for all pixels in the foreground to 0.
% # Now, for disc blurring, iterate over all pixels in the image. If radius =
% 0 (foreground), do nothing. Otherwise, use the built-in MATLAB function
% fspecial(r, 'disk') to construct the disc filter and apply it to the
% current point.

%% Image of a flower
%  For mean shift:
%  Gaussian kernel bandwidth for the spatial feature : 150
%  Gaussian kernel bandwidth for the color feature : 60
%  Number of Iterations : 30
clc
clear
img = imread('../data/flower.jpg');
alpha = 20;
downsample_fac = 1;
I = imresize(img, downsample_fac);
tic;
% get mean shift segmentation result
% foregroundMask = myForegroundMask(double(I),150,60,30,200,0.1);
% foreground = bwareafilt(foregroundMask, 1);
% imwrite(foreground, '/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/flower_foreground.png');
foreground = imread('/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/flower_foreground.png');
only_f = img;
only_b = img;
for c = 1:3
    temp = only_f(:,:,c);
    temp(~logical(foreground)) = 0;
    only_f(:,:,c) = temp;
    temp = only_b(:,:,c);
    temp(logical(foreground)) = 0;
    only_b(:,:,c) = temp;    
end

figure;
subplot(1,4,1)
imshow(img)
title("Original Image");
subplot(1,4,2)
imshow(foreground)
title("Mask");
subplot(1,4,3)
imshow(only_b)
title("Only Background");
subplot(1,4,4)
imshow(only_f)
title("Only Foreground");

%% Variation of r with distance from foreground
bd = edge(foreground,'Canny');
[rows,cols] = find(bd);
boundary = [cols, rows];
% find radius map
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.2));
foreground = logical(foreground);
radiusMask(foreground) = 0;
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.2*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.4));
foreground = logical(foreground);
radiusMask(foreground) = 0;    
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.4*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.6));
foreground = logical(foreground);
radiusMask(foreground) = 0;    
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.6*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.8));
foreground = logical(foreground);
radiusMask(foreground) = 0;    
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.8*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, alpha);
foreground = logical(foreground);
radiusMask(foreground) = 0;
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("alpha");
colorbar;
colormap jet;
axis off;

%% Final image after blurring
figure;
% blur
final = uint8(myDiscBlur(I, radiusMask, alpha));
title("Final Image");
imshow(final)


%% Image of a bird
%  Image is downsampled by 0.25 due to computational constraints. As a result, alpha = 40*0.25 = 10.
%  For mean shift: 
%  Gaussian kernel bandwidth for the spatial feature : 30
%  Gaussian kernel bandwidth for the color feature : 40
%  Number of Iterations : 30
clc
clear
img = imread('../data/bird.jpg');
alpha = 10;
downsample_fac = 0.25;
I = imresize(img, downsample_fac);
tic;
% get mean shift segmentation result
% foregroundMask = myForegroundMask(double(I),30,40,30,300,0.1);
% foreground = bwareafilt(foregroundMask, 1);
% imwrite(foreground, '/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/bird_foreground.png');
foreground = imread('/Users/mithileshvaidya/Documents/Sem 7/DIP/CS663-Assignments/assignment-3-segmentation/3/results/bird_foreground.png');
only_f = I;
only_b = I;
for c = 1:3
    temp = only_f(:,:,c);
    temp(~logical(foreground)) = 0;
    only_f(:,:,c) = temp;
    temp = only_b(:,:,c);
    temp(logical(foreground)) = 0;
    only_b(:,:,c) = temp;    
end

figure;
subplot(1,4,1)
imshow(I)
title("Original Image");
subplot(1,4,2)
imshow(foreground)
title("Mask");
subplot(1,4,3)
imshow(only_b)
title("Only Background");
subplot(1,4,4)
imshow(only_f)
title("Only Foreground");

%% Variation of r with distance from foreground
bd = edge(foreground,'Canny');
[rows,cols] = find(bd);
boundary = [cols, rows];
% find radius map
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.2));
foreground = logical(foreground);
radiusMask(foreground) = 0;
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.2*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.4));
foreground = logical(foreground);
radiusMask(foreground) = 0;    
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.4*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.6));
foreground = logical(foreground);
radiusMask(foreground) = 0;    
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.6*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, round(alpha*0.8));
foreground = logical(foreground);
radiusMask(foreground) = 0;    
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("0.8*alpha");
colorbar;
colormap jet;
axis off;
%%
radiusMask = myRadiusMap(I, boundary, alpha);
foreground = logical(foreground);
radiusMask(foreground) = 0;
%%
subplot(1,1,1), imagesc(radiusMask);
daspect ([1 1 1]);
title("alpha");
colorbar;
colormap jet;
axis off;

%% Final image after blurring
figure;
% blur
final = uint8(myDiscBlur(I, radiusMask, alpha));
title("Final Image");
imshow(final)