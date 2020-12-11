function y = myRadiusMap(img, boundary, alpha)
    min_r = (alpha^2)*ones(size(img, 1), size(img, 2));

    [xgrid, ygrid] = meshgrid(1:size(img,2), 1:size(img,1));
    % iterate over each boundary pixel

    for i = 1:size(boundary, 1)
        x0 = boundary(i, 1);
        y0 = boundary(i, 2);
        distances = ((xgrid-x0).^2 + (ygrid-y0).^2);
        for r = 1:alpha        
            mask1 = distances < r.^2;        
            mask2 = distances >= (r-1).^2;
            mask = mask1 & mask2;
            min_r(mask) = min(min_r(mask), distances(mask));
        end
    end
    y = sqrt(min_r);