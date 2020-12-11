function [y, H] = idealGaussianFilter(input_image, sigma)

[h, w] = size(input_image);
fft_of_img = fftshift(fft2(input_image));
H = zeros(h,w);
centerx = 1 + floor(h / 2);
centery = 1 + floor(w / 2);
for i = 1:h
    for j = 1:w
        diffx = abs(i - centerx);
        diffy = abs(j - centery);
        H(i,j) = exp((-diffx^2 - diffy^2) / (4*sigma^2));
    end
end
fft_of_img = fft_of_img .* H;
y = ifft2(ifftshift(fft_of_img));
y = real(y);