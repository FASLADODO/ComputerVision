addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');

load('dino2.mat');

I = dino01;
J = dino02;

r = size(I,1);
c = size(I,2);

F = fund(cor1, cor2);
x = zeros(3,1);
I = rgb2gray(I);

ra=30;
ang=0:0.01:2*pi;

figure, imshow(I);
hold on

for i=1:size(cor1,1)
    plot(cor1(i,1)+ra*cos(ang), cor1(i,2)+ra*sin(ang), 'b'); 
    x = [cor2(i,1); cor2(i,2); 1;];
    x = F' * x;
    x = x./x(3,1);
    pts = linePts(x,[1,c],[1,r]);
    plot([pts(1,1),pts(2,1)],[pts(1,2),pts(2,2)],'b');
end
hold off

J = rgb2gray(J);
figure, imshow(J);
hold on

ang=0:0.01:2*pi;

for i=1:size(cor2,1)
    plot(cor2(i,1)+ra*cos(ang), cor2(i,2)+ra*sin(ang), 'b');
    x = [cor1(i,1); cor1(i,2); 1;];
    x = F * x;
    pts = linePts(x,[1,size(J,2)],[1,size(J,1)]);
    pts = round(pts);
    plot([pts(1,1),pts(2,1)],[pts(1,2),pts(2,2)],'b');
end
hold off