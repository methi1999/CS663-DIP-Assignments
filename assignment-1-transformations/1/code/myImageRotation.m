function y = myImageRotation(input_image, angle)

[rows_in, cols_in] = size(input_image);

[temp_y, temp_x] = meshgrid(1:cols_in, 1:rows_in);

center_x = (1+rows_in) / 2;
center_y = (1+cols_in) / 2;

phi_x = (temp_x - center_x) * cosd(-angle) - (temp_y - center_y) * sind(-angle) + center_x;
phi_y = (temp_x - center_x) * sind(-angle) + (temp_y - center_y) * cosd(-angle) + center_y;

y = myBilinearInterpolation(input_image, phi_x, phi_y);

