function [ inlier, outlier ] = findOutliers(points3D, P2, outlierTH, corsSSD)

rc = size(corsSSD,1);
y = zeros(3,rc);
inli = zeros(rc,2);
outli = zeros(rc,2);
in=1;
out=1;

orig = corsSSD(:,3:4)';

for i=1:rc
	y(:,i) = P2 * points3D(:,i);
    y(:,i) = y(:,i)./y(3,i);
    
    d = (orig(1,i)-y(1,i)).^2 + (orig(2,i)-y(2,i)).^2;
    d = sqrt(d);
    
    if(d >= outlierTH)
        outli(out,1) = y(1,i);
        outli(out,2) = y(2,i);
        out = out+1;
    else
        inli(in,1) = y(1,i);
        inli(in,2) = y(2,i);
        in = in+1;
    end

end

if in == 1
    inlier = inli(in,:);
else
    inlier = inli(1:in-1,:);
end

if out == 1
    outlier = outli(out,:);
else
    outlier = outli(1:out-1,:);
end


end

