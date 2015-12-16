function [ warped_img ] = warp( I1, new_points,H)
%UNTITLED Summary of this function goes here
%   Warped Image

u_min = min(new_points(:,1));
u_max = max(new_points(:,1));

v_min = min(new_points(:,2));
v_max = max(new_points(:,2));



%[u v] = meshgrid(u_min:0.02:u_max,v_min:0.02:v_max);
[u v] = meshgrid(u_min:u_max,v_min:v_max);

s = max(size(u));



fu = zeros(size(u,1),size(u,2));
fv = zeros(size(v,1),size(v,2));   

for i = 1:size(u,1)
    for j = 1:size(u,2)
        C = [u(i,j);v(i,j);1];
        Cold = H\C;
        %Cold = H\
        Cold = Cold./Cold(3);
        if(Cold(1)<1)
            k = 0;
        end
         fu(i,j)  = max(1,Cold(1));
         fv(i,j)  = max(1,Cold(2));
        
    end
end

I_warp = uint8(zeros(size(fu,1),size(fu,2),3));
for i = 1:size(fu,1)
    for j = 1:size(fu,2)
        i_warp = fix(max(fv(i,j),1));
        j_warp = fix(max(fu(i,j),1));
        I_warp(i,j,:) = I1(i_warp,j_warp,:);
    end
end

warped_img = I_warp;

end

