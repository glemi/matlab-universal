function [xpx, ypx] = dt2px(hAx, xdt, ydt)
    
    uBefore = hAx.Units;
    hAx.Units = 'pixels';
    pxrect = hAx.Position;
    hAx.Units = uBefore;
    
    dtwidth = diff(hAx.XLim);
    dtheight = diff(hAx.YLim);
    
    pxwidth = pxrect(3);
    pxheight = pxrect(4);
    
    pxX0 = pxrect(1);
    pxY0 = pxrect(2);
    
    xscale = pxwidth/dtwidth;
    yscale = pxheight/dtheight;

    xpx = xdt.*xscale + pxX0;
    ypx = ydt.*yscale + pxY0;
end
