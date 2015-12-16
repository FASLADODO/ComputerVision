
function [u,v,hitMap] = opticalFlow( I1,I2,windowSize,tau)
%  Computes the optical flow's x and y co-ordinates and hitMap
%   u is the x component of optical flow
%   v is the y component of optical flow
%   hitMap are the co-ordinates where Optical Flow is valid


sigma = 0.5;
% sigma = 1.5 % Used for corridor image
h = fspecial('gaussian',[3 3],sigma);
%h = fspecial('gaussian',[5 5],sigma); % Used for corridor image

% Spatial Filtering of I1,I2;
I1 = imfilter(I1,h,'replicate');
I2 = imfilter(I2,h,'replicate');

% Compute It i.e. Temporal Differences 


% Convolution Kernel along x & y
kx = [-1/2 0 1/2];
ky = [-1/2; 0 ;1/2];

% Gradient
Ix = conv2(I1,kx,'same'); % GradientX
Iy = conv2(I1,ky,'same'); % GradientY


It = I1-I2;

% Computing Products of Gradients
Ix2 = Ix.^2;
Ixy = Ix.*Iy;
Iy2 = Iy.^2;
Ixt = Ix.*It;
Iyt = Iy.*It;

% Summing windows for corners
sumKernel = ones(windowSize,windowSize);



% Ix2 = sigma(Ix2) over the window


Ix2 = conv2(Ix2,sumKernel,'same');

% Iy2 = sigma(Iy2) over the window
Iy2 = conv2(Iy2,sumKernel,'same');

% Ixy = sigma(Ixy) over the window
Ixy = conv2(Ixy,sumKernel,'same');


% Ixt = sigma(Ixt) over the window
Ixt = conv2(Ixt,sumKernel,'same');

% Ixt = sigma(Ixt) over the window
Iyt = conv2(Iyt,sumKernel,'same');

% For Averaging across the windows
%Ix2 = Ix2./(windowSize*windowSize);
%Iy2 = Iy2./(windowSize*windowSize);
%Ixy = Ixy./(windowSize*windowSize);
%Ixt = Ixt./(windowSize*windowSize);
%Iyt = Iyt./(windowSize*windowSize);



% To check that Lambda is Greater than Tau
% [a b; c d]-LI = 0;
% L  = (a+d)/2-sqrt((a-d)^2+4*b*c)/2,(a+d)/2+sqrt((a-d)^2+4*b*c)/2 
% Lmin = (a+d)/2-sqrt((a-d)^2+4*b*c)/2
% In our case a  Ix2, b = Ixy, c=Ixy, d =Iy2


Lmin = zeros(size(I1,1),size(I2,1));

a = Ix2;
b = Ixy;
c = Ixy;
d = Iy2;

%Lmin = ((a+d).*0.5) - sqrt(((a-d).^2)+ (b.*c).*4)/2;

Lmin = (Ix2+Iy2)/2 -(((Ix2-Iy2).^2+4*(Ixy.^2)).^0.5)/2; 

hitMap = (Lmin>tau);







numRows = size(hitMap,1);
numCols = size(hitMap,2);

u = zeros(numRows,numCols);
v = zeros(numRows,numCols);

% i corrseponds to y 
% j corresponds to x
% u corresponds to vx
% v corresponds to vy

% Computes the optical flow velocities and HitMaps




for i = 1:numRows
    for j = 1:numCols
        if hitMap(i,j)
            A = [Ix2(i,j),Ixy(i,j);Ixy(i,j),Iy2(i,j)];
            B = [-Ixt(i,j); -Iyt(i,j)];    
            O = ((A'*A)\A')*B;
            u(i,j) = O(1);
            v(i,j) = O(2);
        end
    end
end



end
