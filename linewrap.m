function outtext = linewrap(text, linewidth)
    if nargin < 2
        linewidth = 80;
    end
    
    pos = 1;
    n = length(text);
    outtext = '';
    while pos + linewidth < n
        line = text(pos:pos+linewidth);
        spcpos = strfind(line, ' ');
        if ~isempty(spcpos)
            line = line(1:spcpos(end));
        end
        pos = pos + length(line);
        
        outtext = [outtext  line  '\n'];
    end
    if pos < n
        line = text(pos:end);
        outtext = [outtext  line  '\n'];
    end
end
