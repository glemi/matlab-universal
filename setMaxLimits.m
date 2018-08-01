function setMaxLimits( limits )
    
    xlim = get(gca, 'XLim');
    ylim = get(gca, 'YLim');
    
    x0 = xlim(1); x1 = xlim(2);
    y0 = ylim(1); y1 = ylim(2);
    
    x0 = iff(x0 < limits(1), x0, limits(1));
    x1 = iff(x1 > limits(2), x1, limits(2));
    
    y0 = iff(y0 < limits(3), y0, limits(3));
    y1 = iff(y1 > limits(4), y1, limits(4));
    
    set(gca, 'Xlim', [x0 x1], 'Ylim', [y0 y1]);
    
end

