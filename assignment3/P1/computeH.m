function [ H ] = computeH( points,new_points)
%   Computes the 2D projection mapping of the
%   matrix.

x1_src = points(1,1);
y1_src = points(1,2);
x2_src = points(2,1);
y2_src = points(2,2);
x3_src = points(3,1);
y3_src = points(3,2);
x4_src = points(4,1);
y4_src = points(4,2);
X_src = [x1_src x2_src x3_src; y1_src y2_src y3_src;1 1 1];
R_src = [x4_src;y4_src;1];

%XS = R , so S = inv(X)*R
S = (X_src)\R_src;

s1 = S(1);
s2 = S(2);
s3 = S(3);

invH_src = [s1*x1_src s2*x2_src s3*x3_src;s1*y1_src s2*y2_src s3*y3_src;s1 s2 s3];
    

x1 = new_points(1,1);
y1 = new_points(1,2);
x2 = new_points(2,1);
y2 = new_points(2,2);
x3 = new_points(3,1);
y3 = new_points(3,2);
x4 = new_points(4,1);
y4 = new_points(4,2);
X = [x1 x2 x3; y1 y2 y3;1 1 1];
R = [x4;y4;1];

%XS = R , so S = inv(X)*R
S = X\R;

s1 = S(1);
s2 = S(2);
s3 = S(3);

invH_dst = [s1*x1 s2*x2 s3*x3;s1*y1 s2*y2 s3*y3;s1 s2 s3];



H12 = invH_dst*(inv(invH_src));

H = H12



end

