addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');

nCorners = 20;
smoothSTD = 1;
windowSize = 7;

load('dino2.mat');
I = dino01;
J = dino02;

corners1 = CornerDetect(I, nCorners, smoothSTD, windowSize);

I = rgb2gray(I);
figure, imshow(I);
hold on
radius=40;
angle = 0:0.02:2*pi; 
for i = 1:nCorners
    plot(corners1(i,2)+radius*cos(angle),corners1(i,1)+radius*sin(angle),'b');
end
hold off

corners2 = CornerDetect(J, nCorners, smoothSTD, windowSize);

J = rgb2gray(J);
figure, imshow(J);
hold on
radius=40;
angle = 0:0.02:2*pi; 
for i = 1:nCorners
    plot(corners2(i,2)+radius*cos(angle),corners2(i,1)+radius*sin(angle),'b');
end
hold off

load('warrior2.mat');
I = warrior01;
J = warrior02;

corners1 = CornerDetect(I, nCorners, smoothSTD, windowSize);

I = rgb2gray(I);
figure, imshow(I);
hold on
radius=40;
angle = 0:0.02:2*pi; 
for i = 1:nCorners
    plot(corners1(i,2)+radius*cos(angle),corners1(i,1)+radius*sin(angle),'b');
end
hold off

corners2 = CornerDetect(J, nCorners, smoothSTD, windowSize);

J = rgb2gray(J);
figure, imshow(J);
hold on
radius=40;
angle = 0:0.02:2*pi; 
for i = 1:nCorners
    plot(corners2(i,2)+radius*cos(angle),corners2(i,1)+radius*sin(angle),'b');
end
hold off

load('matrix2.mat');
I = matrix01;
J = matrix02;

corners1 = CornerDetect(I, nCorners, smoothSTD, windowSize);

I = rgb2gray(I);
figure, imshow(I);
hold on
radius=40;
angle = 0:0.02:2*pi; 
for i = 1:nCorners
    plot(corners1(i,2)+radius*cos(angle),corners1(i,1)+radius*sin(angle),'b');
end
hold off

corners2 = CornerDetect(J, nCorners, smoothSTD, windowSize);

J = rgb2gray(J);
figure, imshow(J);
hold on
radius=40;
angle = 0:0.02:2*pi; 
for i = 1:nCorners
    plot(corners2(i,2)+radius*cos(angle),corners2(i,1)+radius*sin(angle),'b');
end
hold off















