function [ ans ] = carfilter1( icar, text, xresize, yresize )
ca1 = imread(icar);
F = imread('cartemplate.jpg');

%figure, imagesc(F);
figure, imshow(ca1);
%ca = gaussianfilter(ca);
%ca = blurfilter(ca);
ca = imgaussfilt(ca1,1);
rF = imresize(F, [xresize yresize], 'bicubic');
rF = imrotate(rF,180);
%rF = gaussianfilter(rF);
%rF = blurfilter(rF);
figure, imshow(rF);
H = heatmap(rF,ca);
figure, imagesc(H);

[x,y] = boundarybox(H,1);

xf = size(rF,2);
yf = size(rF,1);

x
y

x(1,1) = mean(x);
y(1,1) = mean(y);

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

