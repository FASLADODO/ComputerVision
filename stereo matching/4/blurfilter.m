function [ I ] = blurfilter( I )

kernel = [1,1,1;1,1,1;1,1,1]./9;
kernel
I = im2double(I);
I = conv2(I,kernel,'same');
I = conv2(I,kernel,'same');
end

