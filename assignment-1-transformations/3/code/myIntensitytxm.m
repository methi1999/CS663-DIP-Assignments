function [orig_img, he_img] = myIntensitytxm(pth)

    orig_img = imread(pth);     %read input image
    he_img = zeros(size(orig_img)); %create empty output image
    
    for channel = 1:size(orig_img, 3)  %iterate through colour channels
        % calculate histogram
        [counts, ~] = imhist(orig_img(:,:,channel)); % ~ means ignore    
        alpha=double(median(orig_img(:,:,channel),'all'))/255; %calculate median value 
        cut =floor(alpha*size(counts)); %scale alpha
        
        % calculate cdfs
        mcdf1 = cumsum(counts(1:1:cut)).*(alpha/sum(counts(1:1:cut)));
        mcdf2 = alpha+cumsum(counts(cut+1:1:end)).*((1-alpha)/sum(counts(cut+1:1:end))); %Bias term added to change the range
        tfm=cat(1,mcdf1,mcdf2); %Append the two cdfs
        
        %Generate output image
        he_img(:,:,channel) = tfm(orig_img(:,:,channel)+1); % index original image using CDF values to generate output image
    end
end