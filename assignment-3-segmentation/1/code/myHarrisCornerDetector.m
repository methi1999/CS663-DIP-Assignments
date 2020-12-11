function [partialX, partialY, grad_im, eigen_prim, eigen_second, cornerness_im] = myHarrisCornerDetector(input_im, gauss_side, sigma, k)

partialX = nlfilter(input_im, [3,1], @(x) myHorizontalDerivative(x));
partialY = nlfilter(input_im, [1,3], @(x) myVerticalDerivative(x));
grad_im = partialX .^ 2 + partialY .^ 2;
grad_im = grad_im .^ 0.5;

Ix_square_weighted = partialX .^ 2;
Iy_square_weighted = partialY .^ 2;
Ix_Iy_weighted = partialX .* partialY;

Ix_square_weighted = nlfilter(Ix_square_weighted, [gauss_side, gauss_side], @(x) myGaussianBlurring(x, gauss_side, sigma));
Iy_square_weighted = nlfilter(Iy_square_weighted, [gauss_side, gauss_side], @(x) myGaussianBlurring(x, gauss_side, sigma));
Ix_Iy_weighted = nlfilter(Ix_Iy_weighted, [gauss_side, gauss_side], @(x) myGaussianBlurring(x, gauss_side, sigma));

sqrt_mat = ((4 .* (Ix_Iy_weighted .^ 2)) + (Ix_square_weighted - Iy_square_weighted) .^ 2) .^ 0.5;
square_add = Ix_square_weighted + Iy_square_weighted;

eigen_prim = 0.5 * (square_add + sqrt_mat);
eigen_second = 0.5 * (square_add - sqrt_mat);

cornerness_im = (eigen_prim .* eigen_second) - (k .* ((eigen_prim + eigen_second) .^ 2));