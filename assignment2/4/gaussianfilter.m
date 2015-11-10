function [ I ] = gaussianfilter( I )

kernel = [1/16,1/8,1/16;1/8,1/4,1/8;1/16,1/8,1/16];

I = im2double(I);
I = conv2(I,kernel,'same');

end

