clc;
close all;
clear all;

clc;
close all;
clear all;




I1 = imread('synth/synth_000.png');

[rows cols ColorBand] = size(I1);

if(ColorBand>1)
    I1 = rgb2gray(I1);
    
end
    
% Scaling images from 0 to 1
I1 = im2double(I1);
% Scaling images from 0 to 1

nCorners = 50;
smoothSTD = 1;
smoothSize = 7;

corners = CornerDetect(I1,nCorners,smoothSTD,smoothSize);

imshow(I1);
hold on,
plot(corners(:,2),corners(:,1),'bo');   


I1 = imread('sphere/sphere.0.png');

[rows cols ColorBand] = size(I1);

if(ColorBand>1)
    I1 = rgb2gray(I1);
    
end
    
% Scaling images from 0 to 1
I1 = im2double(I1);
% Scaling images from 0 to 1



figure,
corners = CornerDetect(I1,nCorners,smoothSTD,smoothSize);
imshow(I1);
hold on,
plot(corners(:,2),corners(:,1),'bo');   



I1 = imread('corridor/bt.000.png');

[rows cols ColorBand] = size(I1);

if(ColorBand>1)
    I1 = rgb2gray(I1);
    
end
    
% Scaling images from 0 to 1
I1 = im2double(I1);
% Scaling images from 0 to 1
figure,
corners = CornerDetect(I1,nCorners,smoothSTD,smoothSize);
imshow(I1);
hold on,
plot(corners(:,2),corners(:,1),'bo');   













