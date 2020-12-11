function y = myBicubicInterpolation(input_image, phi_x, phi_y)

[rows_in, cols_in] = size(input_image);
[rows_out, cols_out] = size(phi_x);

x_vals = floor(phi_x);
y_vals = floor(phi_y);

x_vals = max(2, min(rows_in-2, x_vals));
y_vals = max(2, min(cols_in-2, y_vals));

temp = zeros(rows_out, cols_out);

C_mat = zeros(4,4);
C_mat(1,1) = 1;
C_mat(2,3) = 1;
C_mat(3,1) = -3;
C_mat(3,2) = 3;
C_mat(3,3) = -2;
C_mat(3,4) = -1;
C_mat(4,1) = 2;
C_mat(4,2) = -2;
C_mat(4,3) = 1;
C_mat(4,4) = 1;

for i = 1:rows_out
    for j = 1:cols_out
        
        r = x_vals(i,j);
        c = y_vals(i,j);
        d = zeros(4,4);
        
        d(1,1) = input_image(r,c);
        d(1,2) = input_image(r,c+1);
        d(1,3) = 0.5 * (input_image(r,c+1) - input_image(r,c-1));
        d(1,4) = 0.5 * (input_image(r,c+2) - input_image(r,c));
        d(2,1) = input_image(r+1,c);
        d(2,2) = input_image(r+1,c+1);
        d(2,3) = 0.5 * (input_image(r+1,c+1) - input_image(r+1,c-1));
        d(2,4) = 0.5 * (input_image(r+1,c+2) - input_image(r+1,c));
        d(3,1) = 0.5 * (input_image(r+1,c) - input_image(r-1,c));
        d(3,2) = 0.5 * (input_image(r+1,c+1) - input_image(r-1,c+1));
        d(3,3) = 0.25 * (input_image(r+1,c+1) + input_image(r-1,c-1)...
            - input_image(r+1,c-1) - input_image(r-1,c+1));
        d(3,4) = 0.25 * (input_image(r+1,c+2) + input_image(r-1,c)...
            - input_image(r+1,c) - input_image(r-1,c+2));
        d(4,1) = 0.5 * (input_image(r+2,c) - input_image(r,c));
        d(4,2) = 0.5 * (input_image(r+2,c+1) - input_image(r,c+1));
        d(4,3) = 0.25 * (input_image(r+2,c+1) + input_image(r,c-1)...
            - input_image(r+2,c-1) - input_image(r,c+1));
        d(4,4) = 0.25 * (input_image(r+2,c+2) + input_image(r,c)...
            - input_image(r+2,c) - input_image(r,c+2));
        
        alpha_mat = (C_mat * d) * (C_mat');
        delta_x = min(1,max(0,phi_x(i,j) - x_vals(i,j)));
        delta_y = min(1,max(0,phi_y(i,j) - y_vals(i,j)));
        
        X_mat = zeros(1,4);
        X_mat(1,1) = 1;
        X_mat(1,2) = delta_x;
        X_mat(1,3) = delta_x^2;
        X_mat(1,4) = delta_x^3;
        
        Y_mat = zeros(4,1);
        Y_mat(1,1) = 1;
        Y_mat(2,1) = delta_y;
        Y_mat(3,1) = delta_y^2;
        Y_mat(4,1) = delta_y^3;
    
        temp_mat = X_mat * alpha_mat;
        temp_mat = temp_mat * Y_mat;
        temp(i,j) = temp_mat(1,1);
    end
end

y=temp;