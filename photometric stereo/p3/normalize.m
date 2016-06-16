function [ A ] = normalize( A )

mi = min(A(:));
ma = max(A(:));

for i=1:size(A,1)
    for j=1:size(A,2)
        A(i,j) = (A(i,j) - mi) / (ma - mi);
    end
end

end

