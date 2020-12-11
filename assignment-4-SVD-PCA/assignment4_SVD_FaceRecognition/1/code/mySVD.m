function [sorted_U, sorted_S, sorted_V] = mySVD(A)

[m, n] = size(A);
% calculating U
a_at = A*A';
[U, D1] = eig(a_at);
S = sqrt(diag(D1));
[singular_vals,idx] = sort(S, 'descend');
sorted_S = diag(singular_vals);
if m<n
    sorted_S = cat(2, sorted_S, zeros(m, n-m));
else
    sorted_S = sorted_S(:, 1:n);
end
sorted_U = U(:, idx);

% calculating V
at_u = A'*sorted_U;
sorted_V = at_u./singular_vals';
if m<n
    sorted_V = cat(2, sorted_V, zeros(n, n-m));
else
    sorted_V = sorted_V(:, 1:n);
end