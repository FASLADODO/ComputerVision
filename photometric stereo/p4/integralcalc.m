function [ f ] = integralcalc(p,q)

r = size(p,1); %rows
c = size(p,2); %columns
f = zeros(r,c); %heightmap

for i=1:r

    if i > 1
        f(i,1) = f(i-1,1) + q(i,1);
    end

    for j=2:c        
        f(i,j) = f(i,j-1) + p(i,j);
    end
    
end

end

