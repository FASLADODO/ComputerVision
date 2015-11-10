function [ E ] = extrinsic( R, T )

R = [R;0,0,0];
T = [T;1];
E = [R,T];

end

