function strparts = splitstr(str, delim)
    strparts = {};
    
    n = length(delim);
    str = [delim str];
    
    while length(str) > n
        str = str(n+1:end);
        [part str] = strtok(str, delim);
        strparts(end+1) = {part};
    end    
end