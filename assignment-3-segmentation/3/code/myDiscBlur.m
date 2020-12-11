function out = myDiscBlur(img, radius_map, alpha)
    out = img;
    img = double(padarray(img,[alpha alpha],'replicate','both'));
    radius_map = round(radius_map);    
    for channel = 1:size(img, 3)
        for x = alpha+1:size(img, 1)-alpha
            for y = alpha+1:size(img, 2)-alpha
                r = radius_map(x-alpha,y-alpha);
                if r < 1
                    continue
                end
                h = fspecial('disk',r);
                patch = img(x-r:x+r, y-r:y+r, channel);
                val = sum(patch.*h, 'all');
                out(x-alpha, y-alpha, channel) = val;
            end
        end
    end