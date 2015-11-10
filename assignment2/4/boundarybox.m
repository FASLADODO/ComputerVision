function [ x,y ] = boundarybox( R,n )

maxi = zeros(1,n);
x = zeros(1,n);
y = zeros(1,n);

for k=1:n
    for i=1:size(R,1)
        for j=1:size(R,2)

            if R(i,j) > maxi(1,k)
                maxi(1,k) = R(i,j);
                x(1,k) = j;
                y(1,k) = i;
                R(i,j) = 0;
            end

        end
    end
end

end

