addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');

ncorners = 10;
smoothSTD = 1;
windowSize = 7;
R=7;
SSDth=0.59;

load('dino2.mat');
I = dino01;
J = dino02;
F = fund(cor1, cor2);
corners1 = CornerDetect(I, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I, J, corners1, F, R, SSDth);


load('warrior2.mat');
SSDth=0.95;
I = warrior01;
J = warrior02;
F = fund(cor1, cor2);
corners1 = CornerDetect(I, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I, J, corners1, F, R, SSDth);



load('matrix2.mat');
SSDth=0.96;
I = matrix01;
J = matrix02;
F = fund(cor1, cor2);
corners1 = CornerDetect(I, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I, J, corners1, F, R, SSDth);