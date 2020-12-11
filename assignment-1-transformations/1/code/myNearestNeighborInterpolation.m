function y = myNearestNeighborInterpolation(input_image, phi_x, phi_y)

[rows_in, cols_in] = size(input_image);

x_vals = floor(phi_x);
y_vals = floor(phi_y);

x_vals = max(1, min(rows_in, x_vals));
y_vals = max(1, min(cols_in, y_vals));

GridVals = sub2ind([rows_in, cols_in], x_vals, y_vals);
y = input_image(GridVals);