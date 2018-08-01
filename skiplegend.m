% skiplegend
%
% Hides the current or specified plot object in the legend. 
%
% usage: 
%           % hide last object plotted
%           plot(something);
%           skiplegend;
%
%           % specify plot object as argument
%           hline = plot(something);
%           skiplegend(hline);          
% 
function skiplegend( varargin )
    n = nargin;
    
    if n > 0
        for k = 1:n
            changeProperty(varargin{k});
        end
    else
        if nargin < 1
            hline = findobj(gca, '-property','Annotation');
            changeProperty(hline(1));
        end
    end
end

function changeProperty(hline)
    set(get(get(hline,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
end

