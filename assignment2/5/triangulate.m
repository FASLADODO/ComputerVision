function [ points3D ] = triangulate(corsSSD, P1, P2)

rc = size(corsSSD,1);
x = ones(3,rc);
y = ones(3,rc);
points3D = zeros(4,rc);
r = zeros(4,4);

x(1:2,:) = corsSSD(:,1:2)';
y(1:2,:) = corsSSD(:,3:4)';

for i=1:rc
    xskew =[0 -x(3,i) x(2,i) ; x(3,i) 0 -x(1,i) ; -x(2,i) x(1,i) 0];
    yskew =[0 -y(3,i) y(2,i) ; y(3,i) 0 -y(1,i) ; -y(2,i) y(1,i) 0];
    r1 = xskew * P1;
    r2 = yskew * P2;
    r(1:2,:) = r1(1:2,:);
    r(3:4,:) = r2(1:2,:);
    
    [u v w] = svd(r);    
    points3D(:,i) = w(:,4);   
    
    points3D(:,i) = points3D(:,i)./points3D(4,i);
end

end

