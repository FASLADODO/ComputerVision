function testlabels = eigenTest(trainset,trainlabels,testset,W,mu,k)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here


    repMu     = repmat(mu,size(trainset,1),1);
    x         = (trainset - repMu)';
    ProjTrain = W*x;
    kx        = ProjTrain';


    repMu     = repmat(mu,size(testset,1),1);
    y         = (testset - repMu)';
    ProjTest  = W*y;
    ky        = ProjTest';

    numTest   = size(ky,1);
    numTrain  = size(kx,1);
    classify  = size(numTest);
    

    for i = 1:numTest
        testveci    = ky(i,:);
        A           = repmat(testveci,numTrain,1);
        diff        = (A - kx).^2;
        sumSqdiff   = sum(diff,2);
        [~,idx]   = min(sumSqdiff);
        classify(i) = trainlabels(idx);
    end
    
    testlabels = classify';
end


