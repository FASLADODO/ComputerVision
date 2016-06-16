function [ I, corsSSD ] = naiveCorrespondanceMatching( I1, I2, corners1, corners2, R, SSDth )

r = size(corners1,1);
ssd = zeros(r,r);

I = zeros(size(I1,1),2*size(I1,2));

for i=1:size(I1,1)
    for j=1:size(I1,2)
        I(i,j) = I1(i,j);
    end
end

for i=1:size(I2,1)
    for j=1:size(I2,2)
        I(i,j+size(I1,2)) = I2(i,j);
    end
end


for i=1:r
    for j=1:r
        
        ssd(i,j) = SSDmatch(I1,corners1(i,:),I2,corners2(j,:), R);
        
    end
end

index = ones(r,1);
mini = zeros(r,1);
i=1;

while i<=r

    [mini(i,1), index(i,1)] = min(ssd(i,:));
    
    if mini(i,1) < SSDth
        ssd(i,index(i,1)) = 100;
        mini(i,1) = 0;
    end

    i=i+1;
    
end

index
mini

corsSSD = mini;

figure, imshow(I);
hold on

ra=50;
ang=0:0.01:2*pi;

for i = 1:r
    plot(corners1(i,2)+ra*cos(ang),corners1(i,1)+ra*sin(ang),'r');
    plot(size(I1,2)+ corners2(i,2)+ra*cos(ang),corners2(i,1)+ra*sin(ang),'r');
end

for i=1:r
    j=index(i,1);
    
    if mini(i,1) == 0
        %do nothing
    else
        plot([corners1(i,2),size(I1,2)+corners2(j,2)],[corners1(i,1),corners2(j,1)],'b');
    end
end

hold off











end

