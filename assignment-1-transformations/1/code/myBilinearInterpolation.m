function y = myBilinearInterpolation(input_image, phi_x, phi_y)

[rows_in, cols_in] = size(input_image);

x_vals = floor(phi_x);
y_vals = floor(phi_y);

x_vals = max(1, min(rows_in-1, x_vals));
y_vals = max(1, min(cols_in-1, y_vals));

diff_x = phi_x - x_vals;
diff_y = phi_y - y_vals;

Grid00 = sub2ind([rows_in, cols_in], x_vals, y_vals);
Grid01 = sub2ind([rows_in, cols_in], x_vals, y_vals+1);
Grid10 = sub2ind([rows_in, cols_in], x_vals+1, y_vals);
Grid11 = sub2ind([rows_in, cols_in], x_vals+1, y_vals+1);

y = diff_x .* diff_y .* input_image(Grid11) + diff_x .* (1-diff_y) .* input_image(Grid10) ...
+ (1-diff_x) .* diff_y .* input_image(Grid01) + (1-diff_x) .* (1-diff_y) .* input_image(Grid00);
