%% Q6
% Q. What will happen if you test your system on images of people which were not part of the training set?
%
% -> The face recognition algorithm from Q4 will output the class of the
% person which closely resembles the unknown person. Here, closeness is
% defined by the Euclidean distance in the Eigenspace.

%% Methodology for detecting known person
%%
% # Construct an eigenspace of 32*6 = 192 training images. We should
% ideally get 32 clusters, with 6 points in each cluster. (Assuming that
% Eigenspace representation forms one cluster per person)
% # Compute the centroid of each cluster (we already known which points
% form a cluster and hence no clustering algorithm is involved).
% # For each cluster, calculate the distance between the centroid of the
% cluster and the corresponding 4 test images of each person. Compute the
% average of this distance. We will get 32 such scalar distance values, one
% for each cluster/person. Let this 32-dimensional vector be denoted by D.
% # These values give an estimate of the distance of an unknown image of a
% known person.
% # Let threshold = mean(D) + k*standard deviation(D). If k = 0 i.e. use
% only the mean, the false negative fraction will be close to 0.5 on the 32*4
% test images. Hence, we add an offset which can be controlled by k.
% # By increasing k, the threshold increases -> false negatives (FN) decrease
% but false positives (FP) increase. We empirically found that k = 0.5 strikes
% the right balance between FP and FN.
%% Results
%%
% * 4 test images each of the first 32 people (Total 128 images) should be
% classified as known while 10 images of 8 unknown people (Total of 80)
% should be classified as negatives.
% * Code from Q4 is used for computing the Eigenspace.
% * Top 75 eigenvalues are chosen.
%
% Final values are: False Positive Rate = 19/80 = 0.2375; False Negative
% Rate = 34/128 = 0.2656.

clear;
[trainvecspace, testvecspace, unknownvecspace, trainnumimg, testnumimg] = orldataloader();
meanvec = mean(trainvecspace,2);
trainvecspace = bsxfun(@minus,trainvecspace,meanvec);
testvecspace = bsxfun(@minus,testvecspace,meanvec);
unknownvecspace = bsxfun(@minus,unknownvecspace,meanvec);
[U,S,V] = svd(trainvecspace,'econ');

k = 75;
num_people = uint8(size(trainvecspace,2)/trainnumimg);
% Ured = zeros(size(U));
% Ured(:,1:k) = U(:,1:k);
Ured = U(:,1:k);
eigenvec = Ured';
searchspace = eigenvec*trainvecspace;
meanspace = zeros(size(searchspace, 1), num_people);
for i=1:num_people
    meanspace(:, i) = mean(searchspace(:, (i-1)*trainnumimg+1:i*trainnumimg), 2);
end
queryspace = eigenvec*testvecspace;
D = pdist2(queryspace', meanspace');
threshold = zeros(num_people, 1);
for i=1:num_people
    threshold(i) = sum(D((i-1)*4+1:i*4, i), 'all')/4;
end
threshold = mean(threshold) + 0.5*std(threshold);

TP = 128;
TN = 80;
total_space = cat(2, eigenvec*testvecspace, eigenvec*unknownvecspace);
d = pdist2(total_space', meanspace');
is_present = sum(d < threshold, 2) > 0;
fn = sum(1-is_present(1:TP))/TP;
fp = sum(is_present(TP+1:end))/TN;

