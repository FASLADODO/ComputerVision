function [ ans ] = carfilter2( icar, text, xresize, yresize )
ca1 = imread(icar);
F = imread('cartemplate.jpg');

%theta = 86;
%tform = affine2d([cosd(theta) -sind(theta) 0; sind(theta) cosd(theta) 0; 0 0 1]); %z
%tform = affine2d([1 0 0;0 cosd(theta) -sind(theta);0 sind(theta) cosd(theta)]); %x
%tform = affine2d([cosd(theta), 0, sind(theta);0, 1, 0;-sind(theta), 0, cosd(theta)]); %y
%F = imwarp(F,tform);
%F = flip(F,2);

%figure, imagesc(F);
figure, imshow(ca1);
ca = imgaussfilt(ca1,1);
%ca = imgaussfilt(ca, 10);
%ca = blurfilter(ca);
rF = imresize(F, [xresize yresize], 'bicubic');
rF = imrotate(rF,180);
%rF = flip(rF,1);
%rF = gaussianfilter(rF);
%rF = blurfilter(rF);
figure, imshow(rF);
H = heatmap(rF,ca);
figure, imagesc(H);

[x,y] = boundarybox(H,5);

x,y

x(1,1) = mean(x);
y(1,1) = mean(y);

xf = size(rF,2);
yf = size(rF,1);

%J = frame2im(getframe());

fileID = fopen(text,'r');
coor = fscanf(fileID,'%d');
fclose(fileID);

r = size(rF,1);
c = size(rF,2);

gtc = coor(3,1) - coor(1,1);
gtr = coor(4,1) - coor(2,1);

gtc
gtr

hold on
figure, imshow(ca1)

nx = x(1,1) - c/2;
ny = y(1,1) - r/2;
gtx = coor(1,1);
gty = coor(2,1);

rectangle('Position', [nx ny c r], 'EdgeColor','b');
rectangle('Position', [gtx gty gtc gtr], 'EdgeColor','r');
hold off

[common,union] = overlap(nx,ny,c,r,gtx,gty,gtc,gtr);

ans = common/union * 100;
ans

end

