function circle(center, radius)
    
	
	x = center(1) - radius;
	y = center(2) - radius;
    w = 2*radius;
    h = 2*radius;
	
	p = [x y w h];
	
	rectangle('Position', p, 'Curvature', [1 1]);
	
end