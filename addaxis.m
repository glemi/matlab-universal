function hAx = addaxis()

    hAx1 = gca;
    hFig = get(gca, 'Parent');
    hAx2 = copyobj(hAx1, hFig);
    
    names = {'XTick', 'XScale', 'XLim'};
    values = get(hAx1, names);
    set(hAx2, names, values);
    set(hAx2, 'XTickLabel', []);
    
    h = get(hAx2, 'Children');
    delete(h); 
    
    set(hAx2, 'YAxisLocation', 'right', 'Color', 'none');    
    
    set(hAx1, 'Box', 'off');
    set(hAx2, 'Box', 'off');
    axes(hAx2);
end

function addArrow()
    cla;
    angle = 0:0.1:2*pi;
    xEllipse = 1*cos(angle-0.6);
    yEllipse = 2*sin(angle);
    
    line(xEllipse, yEllipse);
    
end