%% Q1: SVD
%%
% * To test our code, we generate random matrices with random dimensions (m,n) in
% the range [1,100].
% * To test the correctness, we calculate the Frobenius norm of $A -
% reconstructed$ where A is the original input matrix to the SVD function
% and reconstructed = $USV^T$ where U, S and V are calculated by the SVD
% function.
% * The norm has an order of $10^{-15}$. It is not exactly 0 due to
% floating point precision limitations.
clear
clc
% input matrix
r = randi([1 100],2,1);
A = rand(r(1), r(2));
% A = eye(3);

% get result
[U, S, V] = mySVD(A);

% check
reconstructed = U*S*V';
norm(A-reconstructed)

% References:
% 1. https://in.mathworks.com/help/matlab/ref/eig.html