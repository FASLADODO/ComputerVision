r = size(albedo,1);
c = size(albedo,2);

z = heightmap;

nx = zeros(r,c);
ny = zeros(r,c);
nz = ones(r,c);

% calculate normals through gradient
for i=1:r
    for j=1:c
        
        if j == 1
            nx(i,j) = z(i,j+1) - z(i,j);
        elseif j == c
            nx(i,j) = z(i,j) - z(i,j-1);
        else
            nx(i,j) = (z(i,j+1) - z(i,j-1))/2;
        end
        
        if i == 1
            ny(i,j) = z(i+1,j) - z(i,j);
        elseif i == r
            ny(i,j) = z(i,j) - z(i-1,j);
        else
            ny(i,j) = (z(i+1,j) - z(i-1,j))/2;
        end    
        
    end
end

%[nx, ny] = gradient(z);

nx = nx .* (-1);
ny = ny .* (-1);

I = zeros(r,c);
d = 0;
s0 = 1;

a = uniform_albedo;
str = 'uniform-albedo';

for l = 0:1 % for choosing albedo
    
    C = zeros(r,c);
    
    for k = 1:2 % choosing light source
        
        s = lightsource(k,:);
        
        for i=1:r
            for j=1:c
                
                ts = s - [j, i, z(i,j)];
                ts = transpose(ts);
                
                d = sqrt(ts(1)^2 + ts(2)^2 + ts(3)^2);
                nn = sqrt(nx(i,j)^2 + ny(i,j)^2 + nz(i,j)^2);
                
                dotp = [nx(i,j), ny(i,j), nz(i,j)]./nn * ts./d;
                
                I(i,j) = (a(i,j) * dotp * s0 / (d^2));
                C(i,j) = C(i,j) + I(i,j);
                I(i,j) = max(I(i,j), 0);
                
            end
        end
        figure(1), subplot(2,3,3*l+k)
        I = normalize(I);
        imagesc(I);        
        title(strcat('Source ', num2str(k)));
        xlabel(str);
        
        figure(2), subplot(2,3,3*l+k)
        imshow(I);
        title(strcat('Grayscale Source ', num2str(k)));
        xlabel(str);
        
    end
    
    figure(1), subplot(2,3,3*l+k+1)
    
    for i=1:r
        for j=1:c
            C(i,j) = max(C(i,j), 0);
        end
    end
    
    C = normalize(C);
    imagesc(C);
    title('Combined');
    xlabel(str);    
    
    figure(2), subplot(2,3,3*l+k+1)
    imshow(C);
    title('Grayscale Combined');
    xlabel(str); 
    
    a = albedo;
    str = 'albedo';
    
end




