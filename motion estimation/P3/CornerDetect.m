function [corners] = CornerDetect(Images,nCorners,smoothSTD,windowSize)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
clc;
pi = 3.142;
I = Images;


figure, subplot(1,2,1),
imshow(I);



% Blur Image %
GaussKernel = fspecial('gaussian',[windowSize windowSize],smoothSTD);
IBlur = imfilter(I,GaussKernel,'replicate'); % Blur Image

subplot(1,2,2), imshow(IBlur);

kx = [-1/2 0 1/2];
ky = [-1/2; 0 ;1/2];
Ix = conv2(IBlur,kx,'same'); % GradientX
Iy = conv2(IBlur,ky,'same'); % GradientY


Ix2 = Ix.^2;
Ixy = Ix.*Iy;
Iy2 = Iy.^2;



sumKernel = ones(windowSize,windowSize);

Ix2 = conv2(Ix2,sumKernel,'same'); % Sum of the Ix2 of elements window
Iy2 = conv2(Iy2,sumKernel,'same'); % Sum of the Iy2 of elements window
Ixy = conv2(Ixy,sumKernel,'same'); % Sum of the Ixy of elements window
    

% Compute minimum Eigen Values

Lmin = (Ix2+Iy2)/2 -(((Ix2-Iy2).^2+4*(Ixy.^2)).^0.5)/2; 
%L2 = (Ix2+Iy2)/2 +(((Ix2-Iy2).^2+4*(Ixy.^2)).^0.5)/2; 

%Lmin = min(L1,L2);

numRows = size(Ix,1);
numCols = size(Ix,2);

corners = zeros(nCorners,2);

%HalfLen = (MaxSupWinLen-1)/2;
HalfLen = 10;
c=1;

while(c<nCorners+1)
%i = HalfLen+1;
i = HalfLen+1;
max=-100000;
iMax = HalfLen;
jMax = HalfLen;  

while(i<numRows-HalfLen)
    j = HalfLen+1;
    while(j<numCols-HalfLen)
       if(Lmin(i,j)>max)
          max=Lmin(i,j);
          iMax = i;
          jMax = j;
       end             
       j=j+1;
    end
    i=i+1;
end
    corners(c,1) = iMax;
    corners(c,2) = jMax;
    c=c+1;
    Lmin(iMax-HalfLen:iMax+HalfLen,jMax-HalfLen:jMax+HalfLen)=0;
   
end



figure, imshow(I);
hold on,
plot(corners(:,2),corners(:,1),'ro');            
r=30;
ang=0:0.01:2*pi; 
%xp=r*cos(ang);
%yp=r*sin(ang);
for i = 1:nCorners
  %plot(corners(i,2)+xp,corners(i,1)+yp,'b');
end
hold off
end








