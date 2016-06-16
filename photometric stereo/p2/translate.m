function [ tmatrix ] = translate( degree, direction )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

tmatrix = zeros(3,1);

if direction == 3 %z
    tmatrix = [0;0;degree];
           
elseif direction == 2 %y
    tmatrix = [0;degree;0];    
           
elseif direction == 1 %x
    tmatrix = [degree;0;0];
           
else
    % matrix of zeroes
end

end

