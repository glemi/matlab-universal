function structDisp(structarr)
    
    if isempty(structarr)
        display(structarr);
        return;
    end

    names = fieldnames(structarr);
    m = length(structarr);
    n = length(names);
    
    cellmatr = cell(m,n);
    widthmatr = ones(m,n);
    headerwidths = cellfun('length', names);
    
    for i = 1:m % rows
        for j = 1:n % columns
            data = structarr(i).(names{j});
            str = toString(data);
            cellmatr(i,j)  = {str};
            widthmatr(i,j) = length(str);
        end
    end
    
    widths = max(max(widthmatr, [], 1), headerwidths');
    pattern = sprintf('  %%%ds', widths);
    
    header = sprintf(pattern, names{:});
    disp(['    ' header]);
    disp(' ');
    
    pattern = ['%3d' pattern];
    for i = 1:m % rows
        line = sprintf(pattern, i, cellmatr{i,:});
        disp(line);
    end
    
end
