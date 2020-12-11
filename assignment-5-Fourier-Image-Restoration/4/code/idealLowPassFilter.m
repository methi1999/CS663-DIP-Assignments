function [y, H] = idealLowPassFilter(input_image, D)

[h, w] = size(input_image);
fft_of_img = fftshift(fft2(input_image));
H = zeros(h,w);
centerx = 1 + floor(h / 2);
centery = 1 + floor(w / 2);
for i = 1:h
    for j = 1:w
        if((i - centerx)^2 + (j - centery)^2 <= 4*D*D)
            H(i,j) = 1;
        end
    end
end
fft_of_img = fft_of_img .* H;
y = ifft2(ifftshift(fft_of_img));
y = real(y);