clc;
close all;
clear all;



I1Cell = cell(3,1);
I2Cell = cell(3,1);

I1 = imread('synth/synth_000.png');
I2 = imread('synth/synth_001.png');

[rows cols ColorBand] = size(I1);

if(ColorBand>1)
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
end
    
% Scaling images from 0 to 1
I1 = im2double(I1);
% Scaling images from 0 to 1
I2 = im2double(I2);


I1Cell{1} = I1;
I2Cell{1} = I2;


I1 = imread('sphere/sphere.0.png');
I2 = imread('sphere/sphere.1.png');

[rows cols ColorBand] = size(I1);

if(ColorBand>1)
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
end

% Scaling images from 0 to 1
I1 = im2double(I1);
% Scaling images from 0 to 1
I2 = im2double(I2);

I1Cell{2} = I1;
I2Cell{2} = I2;





I1 = imread('corridor/bt.000.png');
I2 = imread('corridor/bt.001.png');

[rows cols ColorBand] = size(I1);

if(ColorBand>1)
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
end


% Scaling images from 0 to 1
I1 = im2double(I1);
% Scaling images from 0 to 1
I2 = im2double(I2);

I1Cell{3} = I1;
I2Cell{3} = I2;








%Tau 0.15 for the corridor image - window size 15
%Tau = 0.5;   % Tau 0.5 for the corridor image - window size 30
%Tau = 0.7;   % Tau 0.7 for the corridor image - window size 100

%tau = [0.15,0.5,0.7]  % For the Corridor Images
%tau = [0.01,0.05,1.68]; % For sphere Images

tauArr = [0.08,0.35,3;0.01,0.05,1.68;0.15,0.5,0.9];

%tau = [0.08,0.35,3]; % For Synth 

win = [15,30,100];

nCorners = 50;
smoothSTD = 1;
SmoothSize = 7;
corners = CornerDetect(I1,nCorners,smoothSTD,SmoothSize);




for k = 1:1

    I1 = I1Cell{k};
    I2 = I2Cell{k};
    
    for i = 1:3


        % Move to Function Optical Flow when Ready
        windowSize = win(i);
        Tau        = tauArr(k,i);

        [u,v,hitMap] = opticalFlow( I1,I2,windowSize,Tau);
        % For Quiver Plot we need x,y,u,v
    
        if k<3
            uRes = imresize(u,0.2);
            vRes = imresize(v,0.2);
        else
            uRes = imresize(u,0.1);
            vRes = imresize(v,0.1);
        end
        figure,
        imshow(hitMap),axis;
        strLabel = strcat('Valid Area ,windowsize: ',int2str(windowSize));
        title(strLabel);
    
        figure,
        quiver(uRes,vRes,2);
        strLabel = strcat('NeedleMap ,windowsize: ',int2str(windowSize));
        set(gca,'YDir','reverse');
    


    end


end





