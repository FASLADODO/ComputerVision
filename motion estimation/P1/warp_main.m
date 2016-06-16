clc;
close all;
clear all;
I1 = imread('stadium.jpg');
% get points in image
figure(10);
imshow(I1);
% Select points in an image, prefereably corners of an ad
points = ginput(4);
%points = [280 205;420 210;400 260;270 235];
%points = [280 205;270 235;400 260;420 210];

new_points = [1 1; 1 100 ; 300 100 ; 300 1];
H = computeH(points,new_points);

points = fix(points);
new_points = fix(new_points);

hpoints = ones(4,3);
hnew_points = ones(4,3);

hpoints(:,1:2) = points;
hnew_points(:,1:2) = new_points;

figure(1);
subplot(1,2,1);
imshow(I1);
hold on
plotsquare(hpoints');
hold off

% warp will return the ad rectified
%warped_img  = warp(I1,new_points,H);

% Content of warp function
warped_img = warp(I1, new_points, H);
subplot(1,2,2);
imshow(warped_img);
hold on
plotsquare(hnew_points');
hold off







