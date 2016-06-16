function [ I ] = inverse( A )

r = size(A,1); %rows
c = size(A,2); %columns

if(r == c)
    I = inv(A);
elseif r > c
    B = transpose(A);
    C = B * A;
    I = C\B;
else
    B = transpose(A);
    C = A * B;
    I = B/C;
end

end

