function [item, index] = structFind(strct, field, value)
    
    if ischar(value)
        index = find(strcmp({strct.(field)}, value), 1);
        item = strct(index);
    else
        index = find([strct.(field)] == value, 1);
        item = strct(index);
    end
end

