function [h, rect] = rbselect()
    h = [];

    rect = rbbox;
    rect = pxrect2dt(gca, rect);
    
    X0 = rect(1);
    Y0 = rect(2);
    X1 = rect(1) + rect(3);
    Y1 = rect(2) + rect(4);
    
    objects = findobj(gca, '-property','XData');
    
    n = length(objects);
    for k = 1:n
        
        object = objects(k);
        x0 = min(object.XData);
        x1 = max(object.XData);
        y0 = min(object.YData);
        y1 = max(object.YData);
        
        if X0 < x0 && Y0 < y0 && X1 > x1 && Y1 > y1
            h = [h object];
        end
    end
end