function fillmarkers(options)
    if nargin < 1
        options = {'all'};
    end
    
    try
        lines = findobj(gca, '-property', 'MarkerFaceColor');
        if ismember('last', options)
            lines = lines(1);
        end
        colors = {lines.Color};
        [lines.MarkerFaceColor] = deal(colors{:});
    end
end
