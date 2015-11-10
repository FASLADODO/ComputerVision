addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');
F = imread('filter.jpg');
I = imread('toy.png');

%figure, imshow(I);
%figure, imshow(F);

R = heatmap(F,I);
%figure, imagesc(R);

[x,y] = boundarybox(R,3);

r = size(F,1);
c = size(F,2);

gtr = r-44;
gtc = c-27;

figure, imshow(I)
hold on

nx = x(1,1) - c/2;
ny = y(1,1) - r/2;
gtx = nx+14;
gty = ny+8;

rectangle('Position', [nx ny c r], 'EdgeColor','b');
rectangle('Position', [gtx gty gtc gtr], 'EdgeColor','r');
hold off

[common,union] = overlap(nx,ny,c,r,gtx,gty,gtc,gtr);

ans = common/union * 100;
ans

gtr = r;
gtc = c;

figure, imshow(I)
hold on

nx = x(1,1) - c/2;
ny = y(1,1) - r/2;
gtx = nx+14;
gty = ny+8;

rectangle('Position', [nx ny c r], 'EdgeColor','b');
rectangle('Position', [gtx gty gtc gtr], 'EdgeColor','r');
hold off

[common,union] = overlap(nx,ny,c,r,gtx,gty,gtc,gtr);

ans = common/union * 100;
ans

gtr = r-22;
gtc = c-11;

figure, imshow(I)
hold on

nx = x(1,1) - c/2;
ny = y(1,1) - r/2;
gtx = nx+14;
gty = ny+8;

rectangle('Position', [nx ny c r], 'EdgeColor','b');
rectangle('Position', [gtx gty gtc gtr], 'EdgeColor','r');
hold off

[common,union] = overlap(nx,ny,c,r,gtx,gty,gtc,gtr);

ans = common/union * 100;
ans

