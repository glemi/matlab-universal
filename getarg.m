function arg = getarg(args, argname, default)
    if length(args) < 2
        arg = default;
        return;
    end
    
    n = length(args);
    argnames = args(1:2:n-1);
    argvalues = args(2:2:n);
    
    i = strcmp(argname, argnames);
    
    if any(i)
        i = find(i, 1);
        arg = argvalues{i};
    elseif nargin >= 3
        arg = default;
    else
        arg = [];
    end
end