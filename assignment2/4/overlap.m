function [ common,union ] = overlap( x1,y1,c1,r1,x2,y2,c2,r2)

a = max(x1,x2);
b = max(y1,y2);
c = min(x1+c1, x2+c2);
d = min(y1+r1, y2+r2);

common = ((c-a)*(d-b));
union = ((r1*c1) + (r2*c2) - common);

end

