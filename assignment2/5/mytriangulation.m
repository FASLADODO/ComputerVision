addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');

ncorners = 50;
smoothSTD = 1;
windowSize = 7;
R=7;
outlierTH = 20;
SSDth=0.59;

load('dino2.mat');
P1 = proj_dino01;
P2 = proj_dino02;
I = dino01;
J = dino02;
F = fund(cor1, cor2);
corners1 = CornerDetect(I, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I, J, corners1, F, R, SSDth);
points3D = triangulate(corsSSD, P1, P2);
[ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD);
J = rgb2gray(J);
orig = corsSSD(:,3:4);

figure, imshow(J);
hold on
plot(orig(:,2),orig(:,1),'ko');
plot(outlier(:,2),outlier(:,1),'r+');
plot(inlier(:,2),inlier(:,1),'b+');
hold off


load('warrior2.mat');
SSDth=0.95;
P1 = proj_warrior01;
P2 = proj_warrior02;
I = warrior01;
J = warrior02;
F = fund(cor1, cor2);
corners1 = CornerDetect(I, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I, J, corners1, F, R, SSDth);
points3D = triangulate(corsSSD, P1, P2);
[ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD);
J = rgb2gray(J);
orig = corsSSD(:,3:4);

figure, imshow(J);
hold on
plot(orig(:,2),orig(:,1),'ko');
plot(outlier(:,2),outlier(:,1),'r+');
plot(inlier(:,2),inlier(:,1),'b+');
hold off



load('matrix2.mat');
SSDth=0.96;
P1 = proj_matrix01;
P2 = proj_matrix02;
I = matrix01;
J = matrix02;
F = fund(cor1, cor2);
corners1 = CornerDetect(I, ncorners, smoothSTD, windowSize);
corsSSD = correspondanceMatchingLine( I, J, corners1, F, R, SSDth);
points3D = triangulate(corsSSD, P1, P2);
[ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD);
J = rgb2gray(J);
orig = corsSSD(:,3:4);

figure, imshow(J);
hold on
plot(orig(:,2),orig(:,1),'ko');
plot(outlier(:,2),outlier(:,1),'r+');
plot(inlier(:,2),inlier(:,1),'b+');
hold off


