function varinit(~, value)
        
    varname = inputname(1);
    x = evalin('caller', varname);
    if isempty(x)
        assignin('caller', varname, value);
    end
end

