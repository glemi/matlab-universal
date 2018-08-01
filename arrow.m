function hpatch = arrow(pstart, pend)
    
    thickness = 1;

    x = [pstart(1) pend(1)];
    y = [pstart(2) pend(2)];
    
    xsize = abs(diff(get(gca, 'XLim')));
    ysize = abs(diff(get(gca, 'YLim')));
    s = ysize/xsize;
    unit_length = sqrt(xsize^2 + ysize^2)/100;
    
    %length = sqrt(sum((pend - pstart).^2));
    
    vlong = (pend - pstart);
    vtrans = [-vlong(2)/s vlong(1)*s];
    
    vlong = vlong/sqrt(sum(vlong.^2));
    vtrans = vtrans/sqrt(sum(vtrans.^2));
        
    L = 2*unit_length*thickness;
    W = 0.5*unit_length*thickness;
    
    p(1,:) = pstart;
    p(2,:) = pend - L*vlong;
    p(3,:) = pend - L*vlong + W*vtrans;
    p(4,:) = pend;
    p(5,:) = pend - L*vlong - W*vtrans;
    p(6,:) = pend - L*vlong;
    p(7,:) = pstart;
    
    x = p(:,1);
    y = p(:,2);
    
    hpatch = patch(x, y, 'k', 'LineWidth', thickness);
    
end

