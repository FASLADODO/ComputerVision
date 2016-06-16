function [ corsSSD ] = correspondanceMatchingLine(  I1, I2, corners1, F, R, SSDth )

I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

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

x = zeros(3,1);
l = zeros(3,1);

rc = size(corners1,1);
ssd = zeros(rc,1);
corners2 = zeros(rc,2);

for i=1:rc
    x = [corners1(i,2); corners1(i,1); 1;];
    l = F * x;
    l = l./l(3,1);
   %l
    pts = linePts(l,[1,size(I2,2)],[1,size(I2,1)]);  
    %pts
    pts = round(pts);
    
   %pts
    
    if pts(1,1) > pts(2,1)
        x1 = pts(2,1);
        y1 = pts(2,2);
        x2 = pts(1,1);
        y2 = pts(1,2);
    else
        x1 = pts(1,1);
        y1 = pts(1,2);
        x2 = pts(2,1);
        y2 = pts(2,2);
    end

    m = (y2-y1)/(x2-x1);
    %m
    %x1,y1,x2,y2
    
    k=2*R;
    x1 = x1+k;
    y1 = round(k*m + y1);
    x2 = x2-k;
    y2 = round((-1*k*m) + y2);
    
    %x1,y1,x2,y2
    
    minssd = SSDmatch(I1,[corners1(i,1),corners1(i,2)],I2,[y1,x1],R);    
    corners2(i,1) = y1;
    corners2(i,2) = x1;
    
    while x1 <= x2       
        x1 = x1+1;
        y1 = y1+m;
        y = round(y1);
 
        ssd(i) = SSDmatch(I1,[corners1(i,1),corners1(i,2)],I2,[y,x1],R);
        
        if ssd(i) < minssd            
            minssd = ssd(i);
            corners2(i,1) = y;
            corners2(i,2) = x1;
        end    
    end    
    
    if minssd < SSDth
        ssd(i) = 0;
    else
        ssd(i) = minssd;
    end    
end

figure, imshow(I);
hold on

%plot(corners1(:,2),corners1(:,1),'bo');   
%plot(size(I1,2)+ corners2(:,2),corners2(:,1),'bo');

ra=50;
ang=0:0.02:2*pi; 

for i = 1:rc
    plot(corners1(i,2)+ra*cos(ang),corners1(i,1)+ra*sin(ang),'r');
    plot(size(I1,2)+ corners2(i,2)+ra*cos(ang),corners2(i,1)+ra*sin(ang),'r');
end

for i=1:rc
    
    if ssd(i) == 0
        %do nothing
    else
        plot([corners1(i,2),size(I1,2)+corners2(i,2)],[corners1(i,1),corners2(i,1)],'b');
    end
end

hold off

corsSSD = zeros(rc,4);
corsSSD(:,1:2) = corners1;
corsSSD(:,3:4) = corners2;

ssd
%corners1
%corners2
%corsSSD

end

