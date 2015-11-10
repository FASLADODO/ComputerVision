function [ K ] = intrinsic(f)

K = [f,0,0,0;
     0,f,0,0;
     0,0,1,0];
K
end

