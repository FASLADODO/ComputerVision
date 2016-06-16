clc;
close all;
clear all;
clc;
close all;
clear all;

[trainset trainlabels] = loadSubset(0);

[W mu] = eigenTrain(trainset,20);

x      = trainset';% Taking x as a nxm Matrix where n = dim of feature vectors and m = no of
% samples


% Looping for 10 images
for i = 1:10
    % Taking image of person_01_01.png,person_02_01.png,...person_10_01.png
    VectorImg         = trainset((i-1)*7+1,:);
    % Reshaping the image to 50x50
    IorigSpace        = reshape(VectorImg,[50 50]);
    % Projecting image to reduced PCA space
    IProjSpace        = W*(VectorImg');
    % Reprojecting image to original full image size feature space
    IRepProjSpace     = (W')*IProjSpace;
    % Resizing image to 50x50
    BackProjImage     = reshape(IRepProjSpace,[50 50]);
    %Converting image to double
    ScaleRepProjSpace = im2double(BackProjImage);
    subplot(1,2,1),imshow(IorigSpace);
    subplot(1,2,2),imshow(ScaleRepProjSpace);
    figure
end


    