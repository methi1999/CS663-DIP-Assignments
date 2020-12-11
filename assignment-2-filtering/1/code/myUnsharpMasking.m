function [im_out, sharp_out, mask] = myUnsharpMasking(im, filter_len, sigma, scaling)
    % define 2D filter
    h = fspecial('gaussian', filter_len, sigma);
    applied = imfilter(im, h);
    mask = im - applied;
    sharp_out = im + scaling*mask;
    % linear contrast stretching
    sharp_out = (sharp_out - min(sharp_out(:)))/(max(sharp_out(:)) - min(sharp_out(:)));
    im_out = (im - min(im(:)))/(max(im(:)) - min(im(:)));