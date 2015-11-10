function [ I ] = rigidtransform(p1, p2, p3, p4, rx, ry, rz, tx, ty, tz, f)

p1 = [p1; 1];
p2 = [p2; 1];
p3 = [p3; 1];
p4 = [p4; 1];

rx = radian(rx);
ry = radian(ry);
rz = radian(rz);

%p1p2p3p4

R = rotation(rx,1) * rotation(ry,2) * rotation(rz,3); %3x3
T = translate(tx,1) + translate(ty,2) + translate(tz,3); %3x1

E = extrinsic(R,T);
E

K = intrinsic(f);
%K

np1 = K * E * p1;
np2 = K * E * p2;
np3 = K * E * p3;
np4 = K * E * p4;

np1
np2
np3
np4

I = zeros(3,4);
I = [np1(1:3),np2(1:3),np3(1:3),np4(1:3)];

end

