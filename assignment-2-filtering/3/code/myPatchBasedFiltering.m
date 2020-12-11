function y = myPatchBasedFiltering(input_image, sigma_star)

y = nlfilter(input_image, [33,33], @(x) FirstAveraging(x, sigma_star, 1.5));