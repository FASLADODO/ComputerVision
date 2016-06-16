clc;
close all;
clear all;
I1 = imread('corridor/bt.000.png');
I2 = imread('corridor/bt.001.png');

% Scaling images from 0 to 1
I1 = im2double(I1);
% Scaling images from 0 to 1
I2 = im2double(I2);

nCorners = 50;
% Tuning Parameters
smoothSTD = 1.5;
windowSize=30;
Tau = 0.1;
SparseOpticalFlow( I1,I2,nCorners,smoothSTD,windowSize,Tau);