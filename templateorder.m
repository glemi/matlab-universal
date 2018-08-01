% [sorted, indices] = templateorder(strings, template)
%
% Re-orders elements in a cell array of strings 'strings' according to 
% the order defiend in another cell array of strings 'template'. 
%
% inputs: 
%           strings : cell array of strings to be sorted
%           template: cell array of strings defining the order of elements
%
% outputs:  
%           sorted  : resulting sorted cell array of strings
%           indices : indices mapping the elements of 'strings' to the
%                     elements of 'sorted', such that 
%                     sorted = strings(indices)
%
% templateorder finds all elements in strings that correspond to an element
% in template and sorts them in that order. The elements in strings not
% found in template remain in their order but are placed at the end of the
% resulting cell array of strings. 
%
function [sorted, indices] = templateorder(strings, template)  
    n = length(strings);
    m = length(template);   
    
    strings = strings(:);
    template = template(:);

    matches = zeros(n, m);
    
    for k = 1:n
        item = strings{k};
        matches(k,:) = strcmp(item, template);
    end
    
    [i, ~] = find(matches);
    j = find(~any(matches, 2));
    
    sorted = [strings(i); strings(j)];
    indices = [i; j];
end

