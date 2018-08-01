function setGlobal(varname, value)
    eval(sprintf('global %s;', varname));
    eval(sprintf('%s = value;', varname));
end