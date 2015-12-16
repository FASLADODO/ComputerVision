function SparseOpticalFlow( I1,I2,nCorners,smoothSTD,windowSize,Tau)
%   Computes the Sparse Optical Flow

    cornerW = 15;
    corners = CornerDetect(I1,nCorners,smoothSTD,cornerW);
    [u,v] = opticalFlow( I1,I2,windowSize,Tau);
    uNew = zeros(length(corners),1);
    vNew = zeros(length(corners),1);


    for i = 1:nCorners
        ycord = corners(i,1);
        xcord = corners(i,2);
        uNew(i) = u(ycord,xcord);
        vNew(i) = v(ycord,xcord);
    end
    
figure
imshow(I1);
hold on,
plot(corners(:,2),corners(:,1),'bo');
quiver(corners(:,2),corners(:,1),uNew,vNew,1,'r');

     

end

