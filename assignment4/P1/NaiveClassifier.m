clc;
close all;
clear all;
[trainset trainlabels] = loadSubset(0);
correctness = zeros(4,1);% Stores the correctness ratio
error       = zeros(4,1);% Stores the error ratio

% Loop through all the subsets
for k = 1:4

    [testset RealLablel] = loadSubset(k);

    numTest   = size(testset,1);
    numTrain  = size(trainset,1);
    classify  = size(numTest);
    
    

    for i = 1:numTest
        % Loading one image at a time
        testveci    = testset(i,:);
        % Replicating to subtract distance from each image
        A           = repmat(testveci,numTrain,1);
        % Squared L2 distance 
        diff        = (A - trainset).^2;
        % Summing L2 distance for each image
        sumSqdiff   = sum(diff,2);
        % Identiying nearest neighbour
        [val,idx]   = min(sumSqdiff);
        % Putting Label
        classify(i) = trainlabels(idx);
        nn(i)        = idx;
    end

    classify    = classify';
    % Checking with the real labels
    cmpVec      = (classify==RealLablel);
    % Accuracy ratio
    correctness(k) = sum(cmpVec)/numTest;
    % Misprediction ratio
    error(k)       = 1 - correctness(k);
end



