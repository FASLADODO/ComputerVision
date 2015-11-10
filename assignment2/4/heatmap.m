function [ R ] = heatmap( F, I )

F = im2double(F);
I = im2double(I);

F = F - mean(F(:));
I = I - mean(I(:));

%figure, imshow(I);
%figure, imshow(F);

R = conv2(I,F, 'same');

%figure, imagesc(R);

end

