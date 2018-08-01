function hAx2 = addaxes(hAx1)
    if nargin < 1 
        hAx1 = gca;
    end
    
    properties = {'Position' 'Xlim' 'XScale'};
    
    values = get(hAx1, properties);
    
    args = makeNameValuePairs(properties, values);
    
    hAx2 = axes(args{:});
    
    cindex = get(hAx1, 'ColorOrderIndex');
    colors = get(hAx2, 'ColorOrder');
    color1 = colors(1,:);
    color2 = colors(cindex+1, :);
    
    set(hAx2, 'Color', 'none');
    set(hAx2, 'YAxisLocation', 'right');
    set(hAx2, 'XTick', []);
    set(hAx2, 'Box', 'off');
    set(hAx2, 'ColorOrderIndex', cindex+1);
    
    set(hAx1, 'YColor', color1);
    set(hAx2, 'YColor', color2);
end

function pairs = makeNameValuePairs(names, values)
    cell2d = {names{:}; values{:}}; 
    cellflat = {cell2d{:}};
    pairs = cellflat;
end