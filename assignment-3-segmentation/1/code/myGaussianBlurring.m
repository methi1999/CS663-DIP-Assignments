function y = myGaussianBlurring(input_image, gaussian_size, gaussian_sigma)

gaussian_blur = zeros(gaussian_size,gaussian_size);
gauss_normal = 0;
side = (gaussian_size + 1) / 2;

for i = 1:gaussian_size
    for j = 1:gaussian_size
        exponent = ((i-side).^2 + (j-side).^2)./(2*gaussian_sigma.^2);
        to_add = exp(-exponent);
        gaussian_blur(i,j) = to_add;
        gauss_normal = gauss_normal + to_add;
    end
end

gaussian_blur = gaussian_blur / gauss_normal;
y = gaussian_blur .* input_image;
y = sum(y, 'all');