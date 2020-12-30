function c = vqkmeans(d,k)

% VQLBG Vector quantization using the k-means algorithm
%
% Inputs:
%       d contains training data vectors (one per column)
%       k is number of centroids required
%
% Outputs:
%       c contains the result VQ codebook (k columns, one for each centroids)

data = d';

sum(any(~isnan(data), 2))

[~,C] = kmeans(data,k,"Display","final","Replicates",10);

c = C';


