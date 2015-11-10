addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');
F = imread('filter.jpg');
I = imread('toy.png');
n=3;
%figure, imshow(I);
%figure, imshow(F);

R = heatmap(F,I);
figure, imagesc(R);

[x,y] = boundarybox(R,n);

xf = size(F,2);
yf = size(F,1);

hold on
figure, imshow(I)

for i=1:n
    nx = x(1,i) - xf/2;
    ny = y(1,i) - yf/2;
    rectangle('Position', [nx ny xf yf], 'EdgeColor','b');    
end

hold off

%J = frame2im(getframe());