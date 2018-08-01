% function str = toString(data)
function str = toString(data)
    if isempty(data)
        str = '[]';
    elseif isnumeric(data)
        if size(data,1) == 1 && size(data,2) == 1
            str = num2str(data);
        elseif size(data, 1) == 1 && size(data,2) <=4
            str = arrayStr(data);
        else
            str = sprintf('%dx%d matrix', size(data));
        end
    elseif iscell(data)
        if size(data, 1) == 1 && size(data,2) == 1
            str = sprintf('{ %s }', toString(data{:}));
        else
            str = sprintf('%dx%d cell', size(data));
        end
    elseif isstruct(data)
        str = sprintf('%dx%d struct', size(data));
    elseif islogical(data)
        if size(data,1) == 1 && size(data,2) == 1
            if data 
                str = 'true';
            else
                str = 'false';
            end
        else
            str = sprintf('%dx%d bool', size(data));
        end
    elseif ischar(data)
        str = data;
    else
        str = sprintf('%dx%d %s', size(data), class(data));
    end
end

function str = arrayStr(arr)
    
    if max(arr) < 100 && min(arr) > 0.01
        str = ['[' num2str(arr, '%2.2f ') ']'];
    elseif max(arr) < 10e6 && min(arr) > 1
        str = ['[' num2str(arr, '%6.0f ') ']'];
    else
        str = ['[' num2str(arr, '%3.2g ') ']'];
    end
    
end
