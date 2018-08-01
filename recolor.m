function  recolor(cmap, lines)
%function  recolor(cmapname, lines)
%
% Usage:
%       recolor;                % default colormpa is 'parula'
%       recolor('summer');      % recolor all lines 
%
%       line1 = plot(x, y);
%       line2 = plot(x, z);
%       recolor('jet', [line1 line2]); % recolor only line1 and line2
%
% colormaps:
%       parula      cool        winter      pink            flag
%       jet         spring      gray        lines           white
%       hsv         summer      bone        colorcube
%       hot         autumn      copper      prism
%
% see also: 
%   colormap
%
    defaultlines = findobj(gca, 'Type', 'line');
    opt cmap any parula;
    opt lines handle defaultlines;
    
    if ischar(cmap)
        map = colormap(cmap);
    elseif ismatrix(cmap) && size(cmap, 2) == 3
        map = cmap;
    end
    
    n = length(lines);
    m = size(map,1);
    [i, j] = meshgrid(linspace(1,m,n), 1:3);
    imap = interp2(map, j', i');
     
    lines = flipud(lines);
    for k = 1:n
        lines(k).Color = imap(k, :);
    end
end

