function [W,mu,SB,SW]=fisherTrain(trainset,trainlabels,c)

N = size(trainset,1);
[Wpca mu]= eigenTrain(trainset,N-c);

% Project on the pca space
ProjTrainData = (Wpca * trainset')';
ProjMeanData  = mean(ProjTrainData);

Ni = N/c;


%Calculate mean of class
MeanClassData = zeros(10, size(ProjTrainData,2));
for i = 0:c-1
    MeanClassData(i+1,:) = mean(ProjTrainData(7*i+1:7*(i+1),:));
end
% Between class scatter
SB = zeros(size(MeanClassData,2),size(MeanClassData,2));
for i = 1:c
    SB = SB + 7*(MeanClassData(i,:)' - ProjMeanData')*(MeanClassData(i,:)' - ProjMeanData')';
end
% Within class scatter
SW = zeros(size(MeanClassData,2),size(MeanClassData,2));
for k = 1:c
    for i = 1:Ni
        SW = SW + (ProjTrainData((k-1)*7+i,:)' - MeanClassData(k,:)')*(ProjTrainData((k-1)*7+i,:)' - MeanClassData(k,:)')';
    end
end

%Calculate Wfld
[V,D]=eig(SB,SW);
%c-1 largest eigen values
VL = V(:,1:(c-1));
[D,I] = sort(diag(D), 'descend');
V = V(:, I);
VL = V(:,1:(c-1));



Wfld = VL';
W = Wfld*Wpca;






    