% Font Adjust
% usage: 
%       fontadj +			% grow font size
%       fontadj -			% shrink font size
%       fontadj set 12		% set font size to 12pt
%       fontadj				% default action is grow font
%		fontadj name Times	% set font name
%
function fontadj(action, param) 
    hfig = gcf;
    h = get(hfig, 'children');    
    
    switch action
        case {'+' 'grow'}
            recur(h, @grow);
        case {'-' 'shrink'}
            recur(h, @shrink);
        case 'set'
            recur(h, @(h)setsize(h, param));
		case 'name' 
			recur(h, @(h)setfont(h, param));
        otherwise
            recur(h, @grow);
    end
end

function setsize(h, size)
    if isprop(h, 'FontSize') 
        if ischar(size)
            size = str2double(size);
        end
        set(h, 'FontSize', size);
    end
end

function setfont(h, name)
    if isprop(h, 'FontName') 
        set(h, 'FontName', name);
    end
end

function grow(h) 
    if isprop(h, 'FontSize') 
        x = get(h, 'FontSize');
        set(h, 'FontSize', x+1);
    end
end

function shrink(h) 
    if isprop(h, 'FontSize') 
        x = get(h, 'FontSize');
        set(h, 'FontSize', x-1);
    end
end

function recur(handles, change)
    for h = handles(:)'
        change(h);
		
		hch = get(h, 'Children');
		if ~isempty(hch)
			recur(hch, change);
		end
		if strcmp(get(h, 'type'), 'axes')
			hch = get(h, {'title', 'xlabel', 'ylabel'});
			recur([hch{:}], change);
		end
	end
end

