clc;
close all;
clear all;

[trainset trainlabels] = loadSubset(0);



c = 10;

[W mu] = fisherTrain(trainset,trainlabels,c);

I = zeros(50,(c-1)*50);

for i = 1:c-1
    image           = W(i,:);
    resizeImg       = reshape(image,[50 50]);
    normImg         = norm_mat(resizeImg);
    I(:,(i-1)*50+1:i*50) = normImg;
end


% Compute Fisher projections of trainset

error = zeros(4,c-1);

for subset = 1:4
    [testset  testlabels]  = loadSubset(subset);
for k = 1:c-1


    WW = W(1:k,:);


    % 1-NN on Fisherspace 
    
    repMu     = repmat(mu,size(trainset,1),1);
    x         = (trainset - repMu)';
    ProjTrain = WW*x;
    kx        = ProjTrain';
    numTrain  = size(trainset,1);

    
    repMu     = repmat(mu,size(testset,1),1);
    y         = (testset - repMu)';    
    ProjTest  = WW*y;
    ky        = ProjTest';
    
    classify  = zeros(size(testset,1),1);

for i = 1:size(testset,1)
        testveci    = ky(i,:);
        A           = repmat(testveci,numTrain,1);
        diff        = (A - kx).^2;
        sumSqdiff   = sum(diff,2);
        [~,idx]   = min(sumSqdiff);
        classify(i) = trainlabels(idx);
end
    
    cmpVec  = testlabels == classify;
    error(subset,k)   = 1- sum(cmpVec)/size(testlabels,1);
    
end
end

plot(1:9,error(1,:),1:9,error(2,:),1:9,error(3,:),1:9,error(4,:));
title('Plot of error against k values by Fisherface method');
legend('Dataset1','Dataset2','Dataset3','Dataset4');
xlabel('k->');
ylabel('error rate->');
hold off;
figure;
    
