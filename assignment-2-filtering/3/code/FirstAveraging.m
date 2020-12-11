function y = FirstAveraging(input_image, h, gaussian_sigma)

gaussian_patch = zeros(9,9);
gauss_normal = 0;
for i = 1:9
    for j = 1:9
        exponent = ((i-5).^2 + (j-5).^2)./(2*gaussian_sigma.^2);
        to_add = exp(-exponent);
        gaussian_patch(i,j) = to_add;
        gauss_normal = gauss_normal + to_add;
    end
end

gaussian_patch = gaussian_patch / gauss_normal;

% input_image
% gaussian_patch

centerX = floor((size(input_image,1)+1)/2);
centerY = floor((size(input_image,2)+1)/2);

centerPatch = input_image(centerX-4:centerX+4, centerY-4:centerY+4);

weightMat = zeros(25,25);

for i = centerX-12:centerX+12
    for j = centerY-12: centerY+12
        
        currPatch = input_image(i-4:i+4, j-4:j+4);
        patchDifference = (centerPatch-currPatch).^2;
        patchDifference = patchDifference .* gaussian_patch;
        patchDifference = patchDifference / (9.0 * 9.0);
        totalSum = sum(patchDifference, 'all');
%         totalSum
        weightMat(13+i-centerX, 13+j-centerY) = exp(-totalSum/(h^2));
    end
end

totalWeight = sum(weightMat, 'all');
weightMat = weightMat ./ totalWeight;

% weightMat

intensityContribution = input_image(centerX-12:centerX+12, centerY-12:centerY+12) .* weightMat;
y = sum(intensityContribution, 'all');
