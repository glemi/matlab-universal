%function [struct order] = structSort(struct, field, pattern)
%
% Sort elements of an struct array by the values of a specific field.
%
function [struct order] = structSort(struct, field, pattern)
    values = [struct.(field)]; 
    [junk order] = sort(values);
    struct = struct(order);
    
    if nargin > 2
        [junk order] = sort(pattern);
        [junk order] = sort(order);
        struct = struct(order);
    end
end