function value = getGlobal(varname, default)
    if nargin < 2
        default = [];
    end
    try
        eval(sprintf('global %s;', varname));
        eval(sprintf('value = %s;', varname));
        
        if isempty(value)
            value = default;
        end
    catch exception
        value = default;
    end 
        
end