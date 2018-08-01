function eqfig(equations, fontsize)
    hFig = fig('latex');cla;
    set(hFig, 'Color', 'white', 'Toolbar', 'none', 'Menubar', 'none');
    set(gca, 'Position', [0 0 1 1]);
    axis off;
    
    if nargin < 2
        fontsize = 20;
    end
    
    if ~iscell(equations)
        equations = fliplr({equations});
    end
    
    n = length(equations);
    
    for k = 1:n
        equation = equations{k};
        t = latex(equation);

        t = strrep(t, '\,', '');
        t = strrep(t, '\mathrm', '');
        t = regexprep(t, '{([RLCGVI])', '$1_{');
        t = strrep(t, '{}', '');
        t = regexprep(t, '{(.)}','$1');
        t = regexprep(t, '_([RLCGVI])_{?(\w+)}?', '_{$1$2}');
        t = ['$' t '$'];

        htxt = text(0.5, k/(n+2)+0.1, t, 'interpreter', 'latex', 'fontsize', fontsize);

        set(htxt, 'HorizontalAlignment', 'Center', 'VerticalAlignment', 'Middle');
    end
    
%     pos = getpixelposition(htxt);
%     pos = get(htxt, 'Extent');
%     height = pos(4);
%     width = pos(3);
%     
%     pos = get(hFig, 'Position');
%     pos(3) = width*1.2;
%     pos(4) = height*1.2;
%     set(hFig, 'Position', pos);
    
   %text(0.1, k/(n+2)+0.1, t, 'interpreter', 'latex', 'fontsize', 18, 'VerticalAlignment', 'top');
    
    
    
    
end

