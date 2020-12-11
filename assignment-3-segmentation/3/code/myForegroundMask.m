function y = myForegroundMask(im,sp_sig,col_sig,stopiter,numneighbour,lambda)
    %Set XY coordinates
    [row,col] = meshgrid(1:size(im,2),1:size(im,1));
    %Scale XY coordinates to same dimensions as image colour intensities
    coordscale=255/max([size(im,2),size(im,1)]);
    %Create Featurespace with 5 columns and heightxwidth rows (formatted this way for knnsearch)
    %Features are weighted by their gaussian variance, effectively creating a
    %5D feature space where all features are equivalent
    featurespace = zeros(size(im,1)*size(im,2), 5);
    for i = 1:size(im,1)
        for j = 1:size(im,2)
            featurespace((i-1)*size(im,2)+j,:)=[coordscale*row(i,j)/sp_sig,coordscale*col(i,j)/sp_sig,im(i,j,1)/col_sig,im(i,j,2)/col_sig,im(i,j,3)/col_sig];
        end
    end
    %a represents 1-learning rate (=lambda)
    a=1-lambda;
    %iterate over the image, each time moving via gradient ascent
    for it = 1:stopiter
%         it
        [idx,D]=knnsearch(featurespace,featurespace,'k',numneighbour); %do k nearest neighbour search for each pixel
        %Calculate gradient at each pixel
        for val = 1:size(featurespace,1) 
            coef=exp(-(D(val,:).^2)/2); 
            coef = coef'./sum(coef);
            grad(val,:)=sum(featurespace(idx(val,:),:).*[coef coef coef coef coef]);
        end
        %update featurespace
        featurespace=a*featurespace+lambda*grad;
    end
    %find 2 clusters in the image space
    idx = kmeans(featurespace(:, 3:5), 2);
    y = logical(reshape(idx-1, size(im, 2), size(im, 1))');