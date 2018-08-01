function H = marker(action, varargin)
    H = findall(gca, 'Type', 'Line');  
    
    marker = get(H, 'Marker');
    i = ~strcmp('none', marker);
    H = H(i);
    
    if nargin == 0
        return;
    end
    
    switch lower(action)
        case 'fill'
            for h = [H(:)]'
                c = get(h, 'Color');
                set(h, 'MarkerFaceColor', c);
            end
        case 'size'
            size = str2num(varargin{1});
            set(H, 'MarkerSize', size);
        case 'color'
            color = varargin{1};
            set(H, 'MarkerFaceColor', color);
            set(H, 'Color', color);
        otherwise
            error('wrong or missing argument');
    end
end

