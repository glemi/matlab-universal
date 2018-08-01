% function [number, unit] = siParse(text)
function [number, unit] = siParse(text)
    
    expr = '([+-]?\d*(\.\d*)?)\s*([yzafpnuµmkMGTPEZY]?)(\S*)';
    tokens = regexp(text, expr, 'tokens');
    tokens = tokens{:};
    
    if length(tokens) == 3
        number = tokens{1};
        prefix = tokens{2};
        unit   = tokens{3};
        
        if isempty(prefix)
            level = 0;
        else
            prefixes = 'yzafpnµumkMGTPEZY';
            levels   = [-24:3:-6 -6 3:3:24];
            ilevel   = strfind(prefixes, prefix);
            level    = levels(ilevel); 
        end
            
        number   = str2double(number) * 10^level;
    else
        number   = [];
        unit     = '';
    end
end