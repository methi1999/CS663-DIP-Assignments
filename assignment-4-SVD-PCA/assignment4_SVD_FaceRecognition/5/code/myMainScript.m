

tic;
%%
clear;
[trainvecspace, testvecspace, trainnumimg, testnumimg, imgrownum, imgcolnum] = orldataloader();
meanvec = mean(trainvecspace,2);
trainvecspace = bsxfun(@minus,trainvecspace,meanvec);
[U,S,V] = svd(trainvecspace,'econ');


%% Reconstruction of Images
% for k = [2, 10, 20, 30, 50, 75, 100, 125, 150, 170]
for k = [2, 10, 20, 30, 50, 75, 100, 125, 150, 170]
    Ured = zeros(size(U));
    Ured(:,1:k) = U(:,1:k);
    image = Ured*S*V';
    image = bsxfun(@plus,image,meanvec);
    oneimg = reshape(image(:,82), [imgrownum imgcolnum]);
    figure
    imshow(uint8(oneimg))
    var = [];
    var = append(num2str(k),' eigenvalues retained');
    title(var)
end
%% Plot eigen vectors
% The plots below represent normalized eigen vectors generated from the ORL
% dataset
for val = 1:25
    img = reshape(U(:,val), [imgrownum imgcolnum]);
    img = rescale(img ,0, 255);
    img=uint8(img);
    figure;
    imshow(img)
    %subplot(5,5,val), imshow(img)
    var = [];
    var = append(num2str(val),'th Eigen Vector');
    title(var)
end
%%
toc;
