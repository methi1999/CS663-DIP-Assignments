function [orig_img, he_img] = myHE(pth)
    % read imgs
    orig_img = imread(pth);    
    he_img = zeros(size(orig_img));
    
    for channel = 1:size(orig_img, 3)
    % calculate histogram
        [counts, ~] = imhist(orig_img(:,:,channel)); % ~ means ignore    
        % calculate cdf
        cdf = cumsum(counts)/sum(counts);
        % plot(cdf)    
        % index using CDF values
        he_img(:,:,channel) = cdf(orig_img(:,:,channel)+1);
    end
end