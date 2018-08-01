% Reduce the number of ticks in a plot for publishing
% usage:
%       reduceTicks(5, 4); 
%       % will reduce the number of ticks to 5 on the
%       % x axis and 4 on the y axis
%
function reduceTicks(nx, ny, nz)
    opt nx double 5
    opt ny double 5
    opt nz double 5

    if ~isempty(nx) 
        calcTicks('X', nx);
    end
    if ~isempty(ny)
        calcTicks('Y', ny);
    end
    if ~isempty(nz) && checkIs3D
        calcTicks('Z', nz);
    end
end

function ticks = calcTicks(axname, nticks)
    lims  = get(gca, [axname 'Lim']);
    scale = get(gca, [axname 'Scale']);
    
    switch scale
        case 'linear'
            sp = diff(lims) / (nticks-1);
            ticks = lims(1):sp:lims(2);
        case 'log'
            ticks = logspace(log10(lims(1)), log10(lims(2)), nticks);
    end

    set(gca, [axname 'Tick'], ticks);
end

function yes = checkIs3D()
    [~,el] = view;
    yes = (el ~= 90);
end

function reduceTicks_backup(nx, ny)
    opt nx double 5
    opt ny double 5

    x = get(gca, 'XTick');
    y = get(gca, 'YTick');
    
    xl = xlim;
    yl = ylim;
    
    if isempty(nx) 
        nx = length(x);
    end
    if isempty(ny) 
        ny = length(y);
    end
    
    switch get(gca, 'XScale')
        case 'linear'
            sp = diff(xlim) / (nx-1);
            xt = xl(1):sp:xl(2);
        case 'log'
            xt = logspace(log10(xl(1)), log10(xl(2)), nx);
    end
    switch get(gca, 'YScale')
        case 'linear'
            sp = diff(ylim) / (ny-1);
            yt = yl(1):sp:yl(2);
        case 'log'
            yt = logspace(log10(yl(1)), log10(yl(2)), ny);
    end
    set(gca, 'XTick', xt);
    set(gca, 'YTick', yt);
end


