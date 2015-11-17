r = size(im1,1); %storing no. of rows 
c = size(im1,2); %storing no. of columns

G = zeros(3,1);  %surface
N = zeros(r,c,3); % surface normal x,y,z
A = zeros(r,c);  %albedo
I = zeros(4,1); % each image pixel intensity
p = zeros(r,c); % x gradient of heightmap
q = zeros(r,c); % y gradient of heightmap
f = zeros(r,c); % heightmap

[x,y] = meshgrid(1:c,1:r); % for quiver
mask = ones(r,c); % for horn integral

for k=0:1  % choosing 3 source or 4 source
    
    if k == 1 %4 source
        V = [l1;l2;l3;l4]; % matrix of all sources
    else %3 source
        V = [l1;l2;l4];
    end
    
    for i=1:r    
        for j=1:c
            
            if k == 1
                I = [double(im1(i,j));double(im2(i,j));double(im3(i,j));double(im4(i,j))]; % choosing 3 or 4 images
            else
                I = [double(im1(i,j));double(im2(i,j));double(im4(i,j))];
            end
            
            %calculating inverse
            %G = pinv(V) * I;
            G = inverse(V) * I;
            
            A(i,j) = norm(G); %calculate albedo
            N(i,j,:) = G / A(i,j); %calculate normals
            p(i,j) = N(i,j,1) / N(i,j,3); %calculate gradients of heightmap
            q(i,j) = N(i,j,2) / N(i,j,3);  
            
        end
    end
    
    p = p .* (-1); % to get normals as [-p,-q,1]
    q = q .* (-1);
    
    gra = (gradient(p) - gradient(q)).^2; % check diff b/w gradients of p,q small everywhere

    f = integralcalc(p,q);    %integrate to get heightmap
    A = normalize(A);        %to get albedo in range [0,1]
    
    figure, subplot(1,2,1)  % showing albedo
    imagesc(0:1,0:1,A);
    str = strcat(num2str(size(V,1)), ' Source : Albedo Map');
    title(str);
    
    pn = zeros(r,c); % for subsampling
    qn = zeros(r,c); % for subsampling
    
    for i=1:2:r    
        for j=1:2:c
            pn(i,j) = p(i,j);
            qn(i,j) = q(i,j);
        end
    end
    
    subplot(1,2,2)    % showing normals
    quiver3(x,y,f,pn,qn,mask,2);
    str = strcat(num2str(size(V,1)), ' Source : Surface Normals Map');
    title(str);
    
    figure(2), subplot(1,2,k+1)
    imshow(A);
    str = strcat(num2str(size(V,1)), ' Source : Albedo Map');
    title(str);
    
    figure, subplot(1,2,1)    % showing integrated heightmap
    surf(f); 
    str = strcat(num2str(size(V,1)), ' Source : Depth Map');
    title(str);
    
    f = integrate_horn2(p,q,mask,5000,0);
    
    subplot(1,2,2)        % showing horn integrated heightmap
    surf(f);
    str = strcat(num2str(size(V,1)), ' Source : Horn Depth Map');
    title(str);
end


