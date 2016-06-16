subplot(1,2,1)
surf(heightmap, uniform_albedo);
title('surface using uniform-albedo');
subplot(1,2,2)
surf(heightmap, albedo);
title('surface using albedo');