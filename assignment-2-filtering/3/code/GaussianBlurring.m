function y = GaussianBlurring(input_image)

gaussian_blur = zeros(5,5);
gauss_normal = 0;
gaussian_sigma = 0.67;

for i = 1:5
    for j = 1:5
        exponent = ((i-3).^2 + (j-3).^2)./(2*gaussian_sigma.^2);
        to_add = exp(-exponent);
        gaussian_blur(i,j) = to_add;
        gauss_normal = gauss_normal + to_add;
    end
end
for i = 1:5
    for j = 1:5
        gaussian_blur(i,j) = gaussian_blur(i,j) / gauss_normal;
    end
end

y = gaussian_blur .* input_image;
y = sum(y, 'all');