%% Q2: Image Segmentation using Mean Shift.

%% Image of a Baboon
%  Gaussian kernel bandwidth for the color feature : 300
%  Gaussian kernel bandwidth for the spatial feature : 100
%  Number of Iterations : 20
im = imread('../data/baboonColor.png');
smoothened = imgaussfilt(im,1);
subsamp = smoothened(1:2:end,1:2:end,:);
tic;
mnshf = myMeanShiftSegmentation(double(subsamp),100,300,20,200,0.3);
subplot(1, 2, 1)
imshow(im)
title("Original Image");
subplot(1, 2, 2)
imshow(mnshf./255)
title("Mean Shift Filtered Image");
toc;
%% Image of a bird
%  Gaussian kernel bandwidth for the color feature : 200
%  Gaussian kernel bandwidth for the spatial feature : 40
%  Number of Iterations : 20
im = imread('../data/bird.jpg');
smoothened = imgaussfilt(im,1);
subsamp = smoothened(1:4:end,1:4:end,:);
tic;
mnshf = myMeanShiftSegmentation(double(subsamp),40,200,20,200,0.3);
subplot(1, 2, 1)
imshow(im)
title("Original Image");
subplot(1, 2, 2)
imshow(mnshf./255)
title("Mean Shift Filtered Image");
toc;
%% Image of a Flower
%  Gaussian kernel bandwidth for the color feature : 200
%  Gaussian kernel bandwidth for the spatial feature : 200
%  Number of Iterations : 20
im = imread('../data/flower.jpg');
smoothened = imgaussfilt(im,1);
subsamp = smoothened(1:2:end,1:2:end,:);
tic;
mnshf = myMeanShiftSegmentation(double(subsamp),200,200,20,200,0.3);
subplot(1, 2, 1)
imshow(im)
title("Original Image");
subplot(1, 2, 2)
imshow(mnshf./255)
title("Mean Shift Filtered Image");
toc;
%%

