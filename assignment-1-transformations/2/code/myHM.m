function [ref_img, input_img, hm_img] = myHM(ref_pth, input_pth)
%     ref_pth = '../data/retina.png';
%     input_pth = '../data/retinaRef.png';
    % read images
    ref_img = imread(ref_pth);
    input_img = imread(input_pth);
    hm_img = zeros(size(input_img));
    
    for channel = 1:size(ref_img, 3)
        % calculate histogram
        [ref_counts, ~] = imhist(ref_img(:,:,channel)); % ~ means ignore
        [input_counts, ~] = imhist(input_img(:,:,channel)); % ~ means ignore    
        % calculate cdf
        ref_cdf = cumsum(ref_counts)/sum(ref_counts);
        ref_cdf_uint8 = uint8(255*ref_cdf);
        % calculate inverse. Fill  0s with previous value
        inverse_ref_cdf = zeros(256, 1);
        inverse_ref_cdf(ref_cdf_uint8) = 1:256;
        inverse_ref_cdf(inverse_ref_cdf == 0) = NaN;
%         inverse_ref_cdf = fillmissing(inverse_ref_cdf, 'next');
%         inverse_ref_cdf = fillmissing(inverse_ref_cdf, 'previous'); % for final NaNs
        % use linear interpolation to fill in the missing values (since
        % staircase not bijective)
        inverse_ref_cdf = fillmissing(inverse_ref_cdf, 'linear');
        % linear interpolation at boundaries may cause problems so clamp
        inverse_ref_cdf(inverse_ref_cdf > 255) = 255;
        inverse_ref_cdf(inverse_ref_cdf < 0) = 0;
        
        % this plot should be idenTITy
%         plot(1:256, inverse_ref_cdf(ref_cdf_uint8))
%         hold on

        % plot cdf and inverse to check visually
%         plot(1:256, ref_cdf_uint8)
%         hold on
%         plot(1:256, inverse_ref_cdf)
%         hold off

        input_cdf = cumsum(input_counts)/sum(input_counts);

        % index using CDF values
        temp = uint8(255*input_cdf(input_img(:,:,channel)+1)); % 1 due to indexing from 1       
        hm_img(:, :, channel) = floor(inverse_ref_cdf(temp+1))/255;
    end
    ref_img = double(ref_img)/255;
    input_img = double(input_img)/255;
end