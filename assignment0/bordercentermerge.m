function bordercentermerge(border, center)

a = imread(border);
b = imread(center);

ar = size(a,1);
br = size(b,1);
ac = size(a,2);
bc = size(b,2);

ar
br
ac
bc

ar = int32((ar-br)/2);
ac = int32((ac-bc)/2);

ar
br
ac
bc

a(ar:ar+br-1, ac:ac+bc-1, :) = b;
figure, imshow(a);

[pathstr,name,ext] = fileparts(border);
name = strcat(name,'result',ext);

imwrite(a, fullfile(pathstr, name));

end
