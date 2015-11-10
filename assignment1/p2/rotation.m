function [ rmatrix ] = rotation( angle, direction )

if direction == 3 %z
    rmatrix = [cos(angle), -sin(angle), 0;
               sin(angle), cos(angle), 0;
               0, 0, 1];
           
elseif direction == 2 %y
    rmatrix = [cos(angle), 0, sin(angle);
               0, 1, 0;
               -sin(angle), 0, cos(angle)];    
           
elseif direction == 1 %x
    rmatrix = [1, 0, 0;
               0, cos(angle), -sin(angle);
               0, sin(angle), cos(angle)];
           
else
    rmatrix = ones();
end

rmatrix

end

