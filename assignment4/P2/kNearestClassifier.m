clc;
close all;
clear all;
[trainset trainlabels] = loadSubset(0);
correctness = zeros(4,1);
error = zeros(4,1);

k = 5;

for j = 1:4

    [testset RealLablel] = loadSubset(j);

    numTest   = size(testset,1);
    numTrain  = size(trainset,1);
    classify  = size(numTest);
    

    for i = 1:numTest
        testveci      = testset(i,:);
        A             = repmat(testveci,numTrain,1);
        diff          = (A - trainset).^2;
        sumSqdiff     = sum(diff,2);
        [res idx]     = sort(sumSqdiff);
        kNearestDis   = res(1:k);
        kNearestIdx   = idx(1:k);
        
% Classifying nearest Neighbours        
        Label         = zeros(k,1);
        for jj = 1:k
            id        = kNearestIdx(jj); 
            Label(jj) = trainlabels(id);
        end
            
        
        
        MajorityLabel = (mode(Label));
        classify(i) = (MajorityLabel);
    end

    classify    = classify';
    cmpVec      = (classify==RealLablel);
    correctness(j) = sum(cmpVec)/numTest;
    error(j) = 1 - correctness(j);
end


