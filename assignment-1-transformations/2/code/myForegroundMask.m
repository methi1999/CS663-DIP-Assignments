function [original, mask, foreground] = myForegroundMask(pth, threshold)
    original = double(imread(pth));
    mask = double(original > threshold);
    foreground = original.*mask;    
    original = original/255;
    foreground = foreground/255;
end
