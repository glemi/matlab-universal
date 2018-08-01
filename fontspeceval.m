% fontspeceval(fontspec)
%
% Translates fontspec into name-value parameter pairs that can be supplied
% to a text object.
%
% A 'fontspec' is an array of characters specifying text format in a
% condensed form, similar to how the familiar 'linespec' specifies line
% formatting in a plot.  
%
% 
function params = fontspeceval(fontspec)
    
    pattern = '(?<left><?)(?<font>[a-zA-Z]+)(?<size>\d+)(?<style>[biBI]*)(?<right>>?)'; 
    items = regexp(fontspec, pattern, 'names');
    
    if isempty(items)
        error 'Invalid Fontspec!';
    end
    
    params = {};
    
    check = @(item)~isempty(items.(item));
    has   = @(str, substr)~isempty(strfind(lower(str), lower(substr)));
    function add(name, value)
        params = [params {name value}];
    end
    
    if check('left')
        add('HorizontalAlignment', 'left');
    end
    if check('right')
        add('HorizontalAlignment', 'right');
    end
    if check('font')
        add('FontName', items.font);
    else
        error 'Invalid Fontspec!';
    end
    if check('size')
        add('FontSize', str2double(items.size));
    else
        error 'Invalid Fontspec!';
    end
    
    %if check('style')
        if has(items.style, 'i')
            add('FontAngle', 'italic');
        else
            add('FontAngle', 'normal');
        end
        if has(items.style, 'b')
            add('FontWeight', 'bold');
        else
            add('fontWeight', 'normal');
        end 
    %end

end