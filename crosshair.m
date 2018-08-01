% usage:
%   crosshair;              % put a cross through origin
%   crosshair(x0, y0);      % lines through x0, y0
function crosshair(x0, y0) 

    if nargin == 0
        if strcmpi(get(gca, 'XScale'), 'log')
            x0 = 1;
        else
            x0 = 0;
        end
        
        if strcmpi(get(gca, 'YScale'), 'log')
            y0 = 1;
        else
            y0 = 0;
        end
    end
    
    if y0 > min(ylim) && y0 < max(ylim)
        h = line(xlim, [y0 y0], 'Color', 0.6*[1 1 1], 'LineWidth', 0.5);
        set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        set(h, 'Tag', 'xcrosshair');
    end
    
    if x0 > min(xlim) && x0 < max(xlim)
        h = line([x0 x0], ylim, 'Color', 0.6*[1 1 1], 'LineWidth', 0.5); 
        set(get(get(h,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
        set(h, 'Tag', 'ycrosshair');
    end
end