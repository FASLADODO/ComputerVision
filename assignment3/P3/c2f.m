clc;
close all;
clear all;
I11 = imread('flower/00029.png');
I22 = imread('flower/00030.png');

%figure,imshow(I11);
%figure,imshow(I22);

% Scaling images from 0 to 1
I1 = im2double(I11);
I1 = rgb2gray(I1);
% Scaling images from 0 to 1
I2 = im2double(I22);
I2 = rgb2gray(I2);

%I1 = medfilt2(I1,[5 5]);
%I2 = medfilt2(I2,[5 5]);

%windowSize = 10;
%Tau = 0.005;

%windowSize = 5;
%Tau = 0.001;

windowSize = 15;
Tau = 0.01;

nCorners = 50;
smoothSTD = 1;
SmoothSize = 7;
corners = CornerDetect(I1,nCorners,smoothSTD,SmoothSize);

[u4,v4] = opticalFlow(I1,I2,windowSize,Tau);

u3 = imresize(u4, [35 50], 'bilinear');
v3 = imresize(v4, [35 50], 'bilinear');

%[x1,y1] = meshgrid(1:size(u3,2),1:size(u3,1));

%figure, subplot(1,2,1),
%quiver(x1,y1,u3,v3);
figure,

quiver(u3,v3,1);
axis([1 50 1 35]);

set(gca,'YDir','reverse');

%subplot(1,2,2),
figure,

n=4;
c1 = cell(n,1);
c2 = cell(n,1);
c1{1} = I1;
c2{1} = I2;
%figure, imshow(c1{1});
%figure, imshow(c2{1});

for i=1:n
    I1 = impyramid(I1,'reduce');
    I2 = impyramid(I2,'reduce');
    c1{i+1} = I1;
    c2{i+1} = I2;
    %figure, imshow(c1{i+1});
    %figure, imshow(c2{i+1});
end

%figure, imshow(I1);
%figure, imshow(I2);

%nCorners = 50;
%smoothSTD = 1;
%SmoothSize = 7;
%corners = CornerDetect(I1,nCorners,smoothSTD,SmoothSize);


%Tau 0.15 for the corridor image - window size 15
%Tau = 0.5;   % Tau 0.5 for the corridor image - window size 30
%Tau = 0.7;   % Tau 0.7 for the corridor image - window size 100
%tau = [0.15,0.4,0.7];
%win = [15,30,100];

[u,v] = opticalFlow(I1,I2,windowSize,Tau);

for i = 2:n+1
    
    u1 = interp2( u, linspace(1,size(c1{n-i+3},2),size(c1{n-i+2},2)), linspace(1,size(c1{n-i+3},1),size(c1{n-i+2},1))','linear');
    v1 = interp2( v, linspace(1,size(c1{n-i+3},2),size(c1{n-i+2},2)), linspace(1,size(c1{n-i+3},1),size(c1{n-i+2},1))','linear');
    
    u1 = u1.*2;
    v1 = v1.*2;
    
    %catarr = cat(3,u1,v1);
    
    [x,y] = meshgrid(1:size(u1,2),1:size(u1,1));
    %u1 = u1./numel(windowSize^2);
    %v1 = v1./numel(windowSize^2);
    %ut = u1;
    %vt = v1;
    next = interp2(c1{n-i+2}, x-u1, y-v1, 'linear');
    %next = imwarp(c1{n-i+2},catarr);
    
    %figure, imshow(next);
    
    [u2,v2] = opticalFlow(next,c2{n-i+2},windowSize,Tau);
    
    u1 = u1 + u2;
    v1 = v1 + v2;

    %u = imresize(u1,[size(u1,1) size(u1,2)]);
    %v = imresize(v1,[size(v1,1) size(v1,2)]);
    
    u = u1;
    v = v1;
end

u = imresize(u, [35 50], 'bilinear');
v = imresize(v, [35 50], 'bilinear');

%u = imresize(u1,0.25);
%v = imresize(v1,0.25);
%[x,y] = meshgrid(1:size(u,2),1:size(u,1));

%figure, subplot(1,2,1),
%quiver(x,y,u,v);

quiver(u,v,1);
axis([1 50 1 35]);

set(gca,'YDir','reverse');

%axis([1 20 1 20]); 
%subplot(1,2,2),
%imshow(hitMap)
%figure
    
    
    
    