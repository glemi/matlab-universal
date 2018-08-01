function [xdt, ydt] = px2dt(hAx, xpx, ypx)
    
    uBefore = hAx.Units;
    hAx.Units = 'pixels';
    pxrect = hAx.Position;
    hAx.Units = uBefore;
    
    dtwidth = diff(hAx.XLim);
    dtheight = diff(hAx.YLim);
    dtX0 = hAx.XLim(1);
    dtY0 = hAx.YLim(1);
    
    pxwidth = pxrect(3);
    pxheight = pxrect(4);
    
    pxX0 = pxrect(1);
    pxY0 = pxrect(2);
    
    xscale = dtwidth/pxwidth;
    yscale = dtheight/pxheight;

    xdt = (xpx - pxX0)*xscale + dtX0;
    ydt = (ypx - pxY0)*yscale + dtY0;
end
