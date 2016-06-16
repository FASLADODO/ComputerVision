clc;
close all;
clear all;

[trainset trainlabels] = loadSubset(0);

[W mu] = eigenTrain(trainset,20);

x      = trainset';% Taking x as a nxm Matrix where n = dim of feature vectors and m = no of
% samples

l       = size(W,1);
GridImg = zeros(100,500); 
r       = 1;
c       = 1;
for i = 1:10
    vectorImg  = W(i,:);
    reshapeImg = reshape(vectorImg,[50 50]);
    reshapeImg = norm_mat(reshapeImg);
    GridImg(1:50,r:r+49) = reshapeImg;
    vectorImg  = W(i+10,:);
    reshapeImg = reshape(vectorImg,[50 50]);
    reshapeImg = norm_mat(reshapeImg);
    GridImg(51:100,r:r+49) = reshapeImg;
    r = r+50;
end
    
imshow(GridImg);
    



