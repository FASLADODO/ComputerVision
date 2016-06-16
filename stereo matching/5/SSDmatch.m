function [ ssd ] = SSDmatch( I1, C1, I2, C2, w )

ssd=0;

for i=-w:w
    
    if (C1(1,1)+i<1) || (C1(1,1)+i > size(I1,1)) || (C2(1,1)+i<1) || (C2(1,1)+i > size(I2,1))
        continue;
    end
    
    for j=-w:w
        
        if (C1(1,2)+j<1) || (C1(1,2)+j > size(I1,2)) || (C2(1,2)+j<1) || (C2(1,2)+j > size(I2,2))
            continue;
        end
        
        diff = (I1(C1(1,1)+i, C1(1,2)+j) - I2(C2(1,1)+i, C2(1,2)+j)).^2;
        ssd = ssd+diff;
        
    end
end


end

