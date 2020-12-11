function [orig_img, clahe_img] = myCLAHE(pth, one_sided_window, threshold)
%     one_sided_window = 2; % half of the total window
%     pth = '../data/barbara.png';
    % actual CLAHE function
    function [clahe] = perChunk(inp_chunk)
        midpt_x = uint8((size(inp_chunk, 1) + 1)/2);
        midpt_y = uint8((size(inp_chunk, 2) + 1)/2);
        edges = -0.5:1:256.5;
        counts = histcounts(inp_chunk, edges);
        % remove padded 256s which are present in the 257th bin
        counts = counts(1:256);
        % pdf
        pdf = double(counts)/sum(counts);
    %     f = figure('visible', 'on');
    %     plot(1:256, pdf, 'r--')
    %     hold on
        % calculate total mass above threshold
        above_thresh = pdf > threshold;
        total_excess_mass = sum((pdf - threshold).*above_thresh);
        % clamp values
        pdf(pdf > threshold) = threshold;
        % redistribute it
        pdf = pdf + total_excess_mass/256;
    %     plot(1:256, pdf, 'b--')
    %     saveas(f, 'eg', 'png');
        % calculate cdf
        cdf = cumsum(pdf)/sum(pdf);
        % HE
        clahe = cdf(inp_chunk(midpt_x, midpt_y)+1);    
    end

    orig_img = imread(pth);
    num_rows = size(orig_img, 1);
    num_cols = size(orig_img, 2);
%     orig_img = orig_img(1:10, 1:10, 1);
    clahe_img = zeros(size(orig_img));
    
    for channel = 1:size(orig_img, 3)
        cur_channel = orig_img(:,:,channel);
        % https://in.mathworks.com/help/images/ref/padarray.html
        % pad corners with 256 so that they can be removed later
        cur_channel_pad = padarray(cur_channel,[one_sided_window, one_sided_window],256,'both');
        final = nlfilter(cur_channel_pad, [2*one_sided_window+1,2*one_sided_window+1], @perChunk);
        % crop
        final = final(one_sided_window+1:one_sided_window+num_rows, one_sided_window+1:one_sided_window+num_cols);
        clahe_img(:,:,channel) = final;
    end            
    orig_img = double(orig_img)/255;
end

% function [orig_img, clahe_img] = myCLAHE(pth, threshold, one_side_window)
% %     threshold = 0.2;
% %     one_side_window = 2; % half of the total window
% %     pth = '../data/statue.png';
%         
%     orig_img = imread(pth);
% %     orig_img = orig_img(1:2, 1:2, 1);
%     num_rows = size(orig_img, 1);
%     num_cols = size(orig_img, 2);
%     clahe_img = zeros(size(orig_img));
%     
%     for channel = 1:size(orig_img, 3)
%         cur_channel = orig_img(:,:,channel);
%         % https://in.mathworks.com/help/images/ref/padarray.html
%         % pad corners with 256 so that they can be removed later
%         cur_channel_pad = padarray(cur_channel,[one_side_window, one_side_window],256,'both');
%         
%         for row = one_side_window+1:one_side_window+num_rows
%             for col = one_side_window+1:one_side_window+num_cols
%                 l = row-one_side_window;
%                 r = row+one_side_window;
%                 t = col-one_side_window;
%                 b = col+one_side_window;
%                 chunk = cur_channel_pad(l:r,t:b);
%                 % calculate hist
%                 [counts, ~] = histcounts(chunk, 257); % ~ means ignore
%                 % remove padded 256s which are present in the 257th bin
%                 counts = counts(1:256);
%                 % pdf
%                 pdf = counts./sum(counts);
%                 % calculate total mass above threshold
%                 above_thresh = pdf > threshold;
%                 total_excess_mass = sum((pdf - threshold).*above_thresh);
%                 % redistribute it
%                 pdf = pdf + total_excess_mass/size(pdf, 1);
%                 % calculate cdf
%                 cdf = cumsum(pdf)/sum(pdf);
%                 % HE
%                 clahe_img(l:r, t:b, channel) = cdf(chunk+1);
%             end
%         end                  
% %         plot(1:256, pdf);
% %         hold on
%     end
% end