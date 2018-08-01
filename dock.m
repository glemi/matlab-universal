% Sets the figure's 'WindowStyle' property
% 
% usege:
%       dock;      % dock the current figure
%       dock on;   % same as dock
%       dock off;  % undock the current figure
%       dock all;  % dock all open figures
%
function dock(option)
    if nargin < 1 || strcmpi(option, 'on')
        if strcmpi(get(gcf, 'WindowStyle'), 'normal')
            set(gcf, 'WindowStyle', 'docked');
        end
    elseif strcmpi(option, 'off')
        set(gcf, 'WindowStyle', 'normal');
    elseif strcmpi(option, 'all')
        handles = findobj('Type', 'figure');
        for hFig = handles'
            if strcmpi(get(hFig, 'WindowStyle'), 'normal')
                set(hFig, 'WindowStyle', 'docked');
            end
        end
    end
end

