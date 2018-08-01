function pxrect = pxrect2dt(hAx, dtrect)
    x = [dtrect(1) dtrect(1)+dtrect(3)];
    y = [dtrect(2) dtrect(2)+dtrect(4)];
    
    [x, y] = px2dt(hAx, x, y);
    
    pxrect = [min(x) min(y) abs(diff(x)) abs(diff(y))];
end