function tableDisp(mode, columns, format, outputFunction)
    persistent tableData;
    
    if nargin < 4
        outputFunction = @disp;
    end
    
    switch mode
        case 'header'
            for q = 1:length(tableData)
               if length(tableData(q).header) == length(columns)
                   tableData(q) = [];
                   break;
               end
            end
            
            t.colWidths = cellfun('length', columns);
            t.header = columns;
            t.lineNumber = 0;
            
            if isempty(tableData)
                tableData = t;
            else
                tableData(end+1) = t;
            end
            
        case 'line'
            n = length(columns);
            t = [];
            for q = 1:length(tableData)
               if length(tableData(q).colWidths) == n
                   t = tableData(q);
                   break;
               end
            end
            if isempty(t)
                error('fuck');
            end
            if t.lineNumber == 0
                for k = 1:n
                    if iscell(columns{k})
                        h = sprintf(format{k}, columns{k}{:});
                    else
                        h = sprintf(format{k}, columns{k});
                    end
                    %h = sprintf(format{k}, columns{k});
                    t.colWidths(k) = max(t.colWidths(k), length(h)) + 2;
                end
                lineDisp(t.header, {}, t.colWidths, outputFunction);
                line = repmat('-', 1, sum(t.colWidths));
                outputFunction(line);
            end
            lineDisp(columns, format, t.colWidths, outputFunction);
            t.lineNumber = t.lineNumber + 1;
            tableData(q) = t;
    end
    
end

function lineDisp(columns, format, colWidths, outputFunction)
    line = '';
    n = length(columns);
    for k = 1:n
        width = colWidths(k);        
        
        str = '';
        if length(format) == n
            if iscell(columns{k})
                if ~all(cellfun('isempty', columns{k})) 
                     str = sprintf(format{k}, columns{k}{:});
                end
            else
                if ~isempty(columns{k})
                    str = sprintf(format{k}, columns{k});
                end
            end
        else
            str = sprintf('%s', columns{k});
        end

        str = sprintf(['%' num2str(width) 's'] , str);
        if length(str) > width
           str = [str(1:width-3) '...'];
        end
        line = [line str];
    end
    outputFunction(line);
end
