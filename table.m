function table(varargin)
    persistent columns;
    
    if nargin == 1
        mode = varargin{1};
        switch lower(mode)
            case 'clear'
                columns = struct('title', '', 'data', {});
            case 'flush'
                flush(columns);
        end
    else
        title     = varargin{1};
        data      = varargin{2};
        formatter = varargin{3};

        celldata = num2cell(data(:));
        formatter = @(x){formatter(x)};
        n = length(columns) + 1;

        columns(n).title = title;
        columns(n).data = cellfun(formatter, celldata);
    end
end

function flush(columns)
    if isempty(columns)
        return;
    end

    m = max(cellfun(@length, {columns.data}));
    n = length(columns);
    
    cellmatr = cell(m,n);
    widths = cellfun(@length, {columns.title});
    
    for i = 1:m % rows
        for j = 1:n % columns
            string = columns(j).data{i};
            cellmatr(i,j) = {string};
            widths(j) = max(widths(j), length(string));
        end
    end

    pattern = sprintf('  %%%ds', widths);
    
    header = sprintf(pattern, columns.title);
    disp(['    ' header]);
    disp(' ');
    
    pattern = ['%3d' pattern];
    for i = 1:m % rows
        line = sprintf(pattern, i, cellmatr{i,:});
        disp(line);
    end
end


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
