clc;
close all;
clear all;

[trainset trainlabels] = loadSubset(0);


% W & mu for the face samples obtained from training script
correctness = zeros(4,20);
error       = zeros(4,20);
for cond = 1:1

    for sub = 1:4
        [testset  testlabels]  = loadSubset(sub);
        
        for k = 1:20
            
            if cond ==1
                [W mu] = eigenTrain(trainset,k);
                
                
            else
                [W mu] = eigenTrain(trainset,k+4);
                W = W(5:end,:);
                x      = trainset';% Taking x as a nxm Matrix where n = dim of feature vectors and m = no of
% samples

                l       = size(W,1);
                GridImg = zeros(100,500); 
                r       = 1;
                c       = 1;
%                 for i = 1:10
%                     vectorImg  = W(i,:);
%                     reshapeImg = reshape(vectorImg,[50 50]);
%                     reshapeImg = norm_mat(reshapeImg);
%                     GridImg(1:50,r:r+49) = reshapeImg;
%                     vectorImg  = W(i+10,:);
%                     reshapeImg = reshape(vectorImg,[50 50]);
%                     reshapeImg = norm_mat(reshapeImg);
%                     GridImg(51:100,r:r+49) = reshapeImg;
%                     r = r+50;
%                 end
%     
%                 imshow(GridImg);
%     
                
                
                
                
                
                
                
                
                
            end
            RealLabel = testlabels;
            

            newTestlabels = eigenTest(trainset,trainlabels,testset,W,mu,k);

            numTest     = size(newTestlabels,1);
            cmpVec      = (newTestlabels==RealLabel);
            correctness(sub,k) = sum(cmpVec)/numTest;
            error(sub,k) = (1-sum(cmpVec)/numTest)*100;
        end
    end
    %plot(1:20,correctness(1,:),1:20,correctness(2,:),1:20,correctness(3,:),1:20,correctness(4,:));
    plot(1:20,error(1,:),1:20,error(2,:),1:20,error(3,:),1:20,error(4,:));
    title('Plot of error percentage against k values');
    legend('Dataset1','Dataset2','Dataset3','Dataset4');
    xlabel('k->');
    ylabel('error percent->');
    hold off;
    figure;
    
end