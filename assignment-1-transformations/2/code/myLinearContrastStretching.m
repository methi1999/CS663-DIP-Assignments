function [img, new_img] = myLinearContrastStretching(path)
    % read images
    img = imread(path);
    new_img = zeros(size(img));
    cdf_min = 0.05;
    cdf_max = 0.95;
  
    for channel = 1:size(img, 3)
        [counts, ~] = imhist(img(:,:,channel)); % ~ means ignore    
        % calculate cdf
        cdf = cumsum(counts)/sum(counts);
%         plot(1:256, cdf);
%         hold on
        min_idx = size(cdf(cdf<cdf_min),1);
        max_idx = size(cdf(cdf<cdf_max),1);
        linear = (double(img(:,:,channel))-1-min_idx)/(max_idx - min_idx);
        linear (linear < 0) = 0;
        linear (linear > 1) = 1;
        new_img(:,:,channel) = linear;        
    end
    img = double(img)/255;
    
end

% min max
% broadcasting is used. No need of iterating over channels
% img_max = max(img, [], [1 2]);
% img_max(1, 1, :) = img_max;
% img_min = min(img, [], [1 2]);
% img_min(1, 1, :) = img_min;
% new_val = (img-img_min)./(img_max-img_min);
    
% piecewise linear
% slope1 = 0.5;
% pt1 = 64;
% slope2 = 1.5;
% pt2 = 128;
% slope3 = 0.5;
% pt3 = 64;
% % ensure range
% assert(slope1*pt1 + slope2*pt2 + slope3*pt3 == 256);
% % calculate new image
% new_val = (img*slope1).*uint8(img < pt1);
% new_val = new_val + ((img-pt1)*slope2+pt1*slope1).*uint8(img<pt2 & img>=pt1);
% new_val = new_val + ((img-pt1-pt2)*slope3+pt2*slope2+pt1*slope1).*uint8(img >= pt1+pt2);