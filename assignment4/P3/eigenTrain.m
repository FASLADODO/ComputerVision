function [ W,mu] = eigenTrain(trainset,k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

avg  = mean(trainset); % Computes mean of entire image sets

D = zeros(size(trainset,2),size(trainset,1));
for i = 1:size(trainset,1)
    x = trainset(i,:);
    x = x-avg;
    D(:,i) = x';
end

[U,S,V] = svds(D,k);

W  = U';
mu = avg;

end

