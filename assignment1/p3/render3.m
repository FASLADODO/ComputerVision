%[fx, fy] = gradient(heightmap);

z = heightmap;

r = size(z,1);
c = size(z,2);

fx = zeros(r,c);
fy = zeros(r,c);
% calculate normals through gradient
for i=1:r
    for j=1:c
        
        if j == 1
            fx(i,j) = z(i,j+1) - z(i,j);
        elseif j == c
            fx(i,j) = z(i,j) - z(i,j-1);
        else
            fx(i,j) = (z(i,j+1) - z(i,j-1))/2;
        end
        
        if i == 1
            fy(i,j) = z(i+1,j) - z(i,j);
        elseif i == r
            fy(i,j) = z(i,j) - z(i-1,j);
        else
            fy(i,j) = (z(i+1,j) - z(i-1,j))/2;
        end    
        
    end
end

fx = fx .* -1;
fy = fy .* -1;

fz = ones(r, c);
det = 0;

[x, y] = meshgrid(1:c, 1:r);

for i= 1:2:r
    for j = 1:2:c
        det = (fx(i,j).^2) + (fy(i,j).^2) + 1;
        det = sqrt(det);
        
        fx(i,j) = fx(i,j)/det;
        fy(i,j) = fy(i,j)/det;
        fz(i,j) = fz(i,j)/det;
    end
end

quiver3(x, y, heightmap, fx, fy, fz, 10);
        
        
        

