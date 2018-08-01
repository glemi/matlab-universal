% Reduce the number of ticks in a plot for publishing
% usage:
%       reduceTicks(5, 4); 
%       % will reduce the number of ticks to 5 on the
%       % x axis and 4 on the y axis
%
function nticks(nx, ny)
    x = get(gca, 'XTick');
    y = get(gca, 'YTick');
    
    xl = xlim;
    yl = ylim;
    
    
    sp = diff(xlim) / (nx-1);
    xt = xl(1):sp:xl(2);
    set(gca, 'XTick', xt);
    
    sp = diff(ylim) / (ny-1);
    yt = yl(1):sp:yl(2);
    set(gca, 'YTick', yt);
    
end
