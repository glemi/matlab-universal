function syncAxis( hAx )
    
    n = length(hAx);
    for k = 1:n
        xlim(k, :) = get(hAx(k), 'Xlim');
    end
    
    xmin = min(xlim(:, 1));
    xmax = max(xlim(:, 2));
    
    set(hAx, 'Xlim', [xmin xmax]);
    
end

