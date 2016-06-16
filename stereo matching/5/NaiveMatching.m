addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');

nCorners = 10;
smoothSTD = 1;
windowSize = 7;
R=7;
SSDth=0.59;

load('dino2.mat');
I1 = dino01;
I2 = dino02;

corners1 = CornerDetect(I1, nCorners, smoothSTD, windowSize);
corners2 = CornerDetect(I2, nCorners, smoothSTD, windowSize);
[I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth);

load('warrior2.mat');
SSDth=0.95;
I1 = warrior01;
I2 = warrior02;

corners1 = CornerDetect(I1, nCorners, smoothSTD, windowSize);
corners2 = CornerDetect(I2, nCorners, smoothSTD, windowSize);
[I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth);

load('matrix2.mat');
SSDth=0.96;
I1 = matrix01;
I2 = matrix02;

corners1 = CornerDetect(I1, nCorners, smoothSTD, windowSize);
corners2 = CornerDetect(I2, nCorners, smoothSTD, windowSize);
[I, corsSSD] = naiveCorrespondanceMatching(I1, I2, corners1, corners2, R, SSDth);
