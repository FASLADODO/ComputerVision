
p1 = [-1; -0.5; 2];
p2 = [1; -0.5; 2];
p3 = [1; 0.5; 2];
p4 = [-1; 0.5; 2];

I = rigidtransform(p1,p2,p3,p4,0,0,0,0,0,0,1);
subplot(2,2,1) 
plotsquare(I);
title('proj, origin');

I = rigidtransform(p1,p2,p3,p4,0,0,0,0,0,1,1);
subplot(2,2,3) 
plotsquare(I);
title('proj, translation');

I = rigidtransform(p1,p2,p3,p4,0,45,60,0,0,1,1);
subplot(2,2,2) 
plotsquare(I);
title('proj, rotation');

I = rigidtransform(p1,p2,p3,p4,0,90,60,0,0,13,15);
subplot(2,2,4) 
plotsquare(I);
title('proj, rotation long distance');
