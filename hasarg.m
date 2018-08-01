function [yes position] = hasarg(args, argname)
    if length(args) < 2
        yes = false;
        position = 0;
        return;
    end
    
    n = length(args);
    argnames = args(1:2:n-1);
    argvalues = args(2:2:n);
    
    i = strcmp(argname, argnames);
    
    if any(i)
        i = find(i, 1);
        yes = true;
        position = i;
    else
        yes = false;
        position = 0;
    end
end