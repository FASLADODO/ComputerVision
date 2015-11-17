function [ corners ] = CornerDetect(Image, nCorners, smoothSTD, windowSize) 

I = rgb2gray(Image);
I = imgaussfilt(I, smoothSTD);
%figure, imagesc(I);

dk = [-0.5,0,0.5];

ix = conv2(I, dk, 'same');
iy = conv2(I, transpose(dk), 'same');

%figure, imagesc(ix);
%figure, imagesc(iy);

ixy = ix.*iy;
ix2 = ix.^2;
iy2 = iy.^2;

%figure, imagesc(ixy);
%figure, imagesc(ix2);
%figure, imagesc(iy2);

window = ones(windowSize, windowSize);

ix2 = conv2(ix2,window,'same');
ixy = conv2(ixy,window,'same');
iy2 = conv2(iy2,window,'same');

%figure, imagesc(ixy);
%figure, imagesc(ix2);
%figure, imagesc(iy2);

det = ix2.*iy2 - ixy.^2;
trace = ix2+iy2;
e = det - 0.04*(trace.^2);

r = size(e,1);
c = size(e,2);

corners = zeros(nCorners,2);

is=61;   
js=61;      
wi=60;      
wj=60;

for count=1:nCorners
    
    maxi=0;
    for i= is:r-is 
        for j=js:c-js
                if(e(i,j) > maxi) 
                        maxi=e(i,j);
                        corners(count,1)=i;
                        corners(count,2)=j;
                end
        end
    end
    
    for i=-wi:wi

         if(corners(count,1)+i<1 || corners(count,1)+i>r)
             continue;
         end
         
         for j=-wj:wj
             
             if(corners(count,2)+j<1 || corners(count,2)+j>c)
                 continue;
             end
             
             e(corners(count,1)+i,corners(count,2)+j)=0;
         end
    end
end

end

