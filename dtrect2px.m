function dtrect = dtrect2px(hAx, pxrect)
    x = [pxrect(1) pxrect(1)+pxrect(3)];
    y = [pxrect(2) pxrect(2)+pxrect(4)];
    
    [x, y] = dt2px(hAx, x, y);
    
    dtrect = [min(x) min(y) abs(diff(x)) abs(diff(y))];
end