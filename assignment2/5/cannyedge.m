addpath('C:\Users\Abhinav\Downloads\UCSD\vision\hw2');

F = imread('cartemplate.jpg');
F = im2double(F);
F = imgaussfilt(F,1.4);
figure, imagesc(F);

kx = [-0.5,0,0.5];
ky = [-0.5;0;0.5];

fx = conv2(F,kx,'same');
fy = conv2(F,ky,'same');

g = hypot(fx,fy);
theta = atan2(fy,fx);
theta = abs(theta);
theta = theta.*(180/pi);

r = size(theta,1);
c = size(theta,2);

for i=1:r
    for j=1:c
        
    if theta(i,j) > 0 && theta(i,j) <= 22.5
        theta(i,j) = 0;
    elseif theta(i,j) > 22.5 && theta(i,j) <= 67.5
        theta(i,j) = 45;
    elseif theta(i,j) > 67.5 && theta(i,j) <= 112.5
        theta(i,j) = 90;
    elseif theta(i,j) > 112.5 && theta(i,j) <= 157.5
        theta(i,j) = 135;
    elseif theta(i,j) > 157.5 && theta(i,j) <= 180
        theta(i,j) = 0;
    end
        
    end
end

temp = zeros(r,c);

for i=1:r
    for j=1:c
        
    var1 = 0;
    var2 = 0;
        
    if theta(i,j) == 0
        
        if (j+1) <= c
            var1 = g(i, j+1);
        end
        if (j-1) > 0        
            var2 = g(i, j-1);
        end
        
    elseif theta(i,j) == 45
        
        if (j+1) <= c && (i-1) > 0
            var1 = g(i-1, j+1);
        end
        if (j-1) > 0 && (i+1) <= r
            var2 = g(i+1, j-1);
        end

    elseif theta(i,j) ==90

        if (i+1) <= r
            var1 = g(i+1, j);
        end
        if (i-1) > 0
            var2 = g(i-1, j);
        end
        
    elseif theta(i,j) == 135
        
        if (j+1) <= c && (i+1) <= r
            var1 = g(i+1, j+1);
        end
        if (j-1) > 0 && (i-1) > 0
            var2 = g(i-1, j-1);
        end

    end
    
    if (temp(i,j) < var1) || (temp(i,j) < var2)
        temp(i,j) = 0;
    end
        
    end
end

ma = max(temp(:));
mi = min(temp(:));

hthreshold = (ma + mi)/2;
lthreshold = (ma - mi)/2;

for i=1:r
    for j=1:c
        
        if temp(i,j) >= hthreshold
            temp(i,j) = hthreshold;
        elseif temp(i,j) >= lthreshold
            temp(i,j) = lthreshold;
        else
            temp(i,j) = 0;
        end
    end
end

figure, imagesc(g);







