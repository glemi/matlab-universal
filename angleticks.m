% [ticks] = angleticks(ax)
%
% Creates y-axis ticks that are multiples of 90deg.  
%
% usage: 
%           angleticks;
%           angleticks(ax);         % specify axis other than gca
%           [ticks] = angleticks;   % return new tick positions
% 
function [ticks] = angleticks(ax)
    if nargin > 1
        ax = axes;
    else
        ax = gca;
    end
    
    ticks = [-180 -90 0 90 180];
    keep = ax.YLim(1) < ticks & ticks < ax.YLim(2);
    
    if sum(keep) == 0
        ticks = [ceil(ax.YLim(1)) floor(ax.YLim(2))];
    elseif sum(keep) == 1
        if ticks(keep) - ax.YLim(1) < ax.YLim(2) - ticks(keep)
            ticks = [ticks(keep) floor(ax.YLim(2))];
        else
            ticks = [ceil(ax.YLim(1)) ticks(keep)];
        end
    else
        ticks = ticks(keep);
    end
    
    ax.YTick = ticks;
end

