function annotArrow(hlines, x0)
    
    n = length(hlines);
    
    xdata = get(hlines, 'Xdata');
    ydata = get(hlines, 'Ydata');
    
    %x = vertcat(x{:});
    %y = vertcat(y{:});
    
    k = ceil(n/2);
    
    x = xdata{k};
    y = ydata{k};
    
    l = getPerpLine(hlines(k), x0);
    
    [u, v] = l([-100 100]);
    
    
    p1 = [u(1) v(1)];
    p2 = [u(2) v(2)];
    arrow(p1, p2);
    
    line(u, v);
    
    %annotation('arrow', u, v);
    %plot(u, v);
end

function fun = getPerpLine(hline, x0)
    xcurve = get(hline, 'Xdata');
    ycurve = get(hline, 'Ydata');

    hAx = ancestor(hline, 'axes');
    
    xlim = get(hAx, 'XLim');    
    ylim = get(hAx, 'YLim');
    
    s = abs(diff(ylim)./diff(xlim)); 
    
    px = diff(xcurve); 
    py = diff(ycurve);

    [~, i] = min(abs(xcurve - x0));
    
    x0 = xcurve(i);
    y0 = ycurve(i);
    
    %plot(x0, y0, 'o', 'LineWidth', 10);
    
    vx = -py(i)/s;
    vy = px(i)*s;
    
    function  [x, y] = straightline(t)
        x = x0 + t*vx;
        y = y0 + t*vy;
    end

    fun = @straightline;
end

function [x, y] = intersect(curvex, curvey, secant)
    function d = distance(t)
        [secx, secy] = secant(t);
        
        dx = secx - curvex;
        dy = secy - curvey;
        
        d = min(dx.^2 + dy.^2);
    end

    t = fminsearch(@distance, t0);
    [x, y] = secant(t);
end