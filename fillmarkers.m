function fillmarkers
    try
    lines = findobj(gca, '-property', 'MarkerFaceColor');
    colors = {lines.Color};
    [lines.MarkerFaceColor] = deal(colors{:});
    end
end
