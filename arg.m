% value = arg(pos, type, default);
function value = arg(pos, type, default)
    persistent index;
    narginchk(2,3);
  
    if isnumeric(pos)
        args = evalin('caller', 'varargin');
        
        if pos == 1
            index = 1;
        end
        if length(args) >= index
            value = args{index};
            typeOk = isa(value, type);
        else
            typeOk = false;
        end 
    elseif ischar(pos)
        try
            value = evalin('caller', pos); 
            typeOk = isa(value, type);
        catch
            typeOk = false;
        end
    end

    if typeOk 
        index = index + 1;
    elseif nargin == 3
        value = default;
    else
        error(['Missing Arguent of Type ' type]);
    end 
end

