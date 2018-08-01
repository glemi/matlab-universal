% Check if optional function arguments are present and valid, use a default
% value, if specified.
% 
% usage: 
%       arg name type default check_exp;
%
% example:
%       function setupVSweep(vstart, vstop, nsteps, icomp) 
%          arg vstart double 'vstart > -200 && vstart < 200'
%          arg vstop  double 'vstart > vstop && vstart < 200'
%          opt nsteps double 101 'nsteps > 0 && nsteps <= 1001'
%          opt icompl double 10e-3 'icompl > -1 && icomple < 1'
%
%          % ...
%       end
%
% see also:
%       arg
% 
function opt(name, type, default, check_exp)
    narginchk(2,4);
    try
        isvar = evalin('caller', sprintf('exist(''%s'', ''var'')', name));
        if ~isvar
            missing = true;    
        else
            value = evalin('caller', name);
            missing = false;
        end
    catch 
        missing = true;
    end
    
    if nargin > 2 && missing
        try 
            default = evalin('caller', default);
        end
    else
        default = [];
    end
    
    if nargin > 3
        valid = false;
        try check_exp = evalin('caller', check_exp);
            valid = validate(value, check_exp);
        end
    else
        valid = true;
    end
    
    if missing
        assignin('caller', name, default);
    elseif ~checktype(value, type)
        error('Wrong type of argument: %s (%s)', name, class(value));
    elseif ~valid
        error('Bad argument value: %s (%s)', name, strtrim(evalc('disp(value)')));
    else
        assignin('caller', name, value);
    end
end

function ok = checktype(value, type)
    
    if strcmpi(type, 'any')
        ok = true;
    else
        types = strsplit(type, '|');
        for type = types
            type = type{:};
            testfun = ['is' type];
            
            if exist(testfun, 'builtin')
                ok = feval(testfun, value);
            else 
                ok = isa(value, type);
            end
            if ok
                return;
            end
        end
    end
end

function valid = validate(value, check_exp)
    if islogical(check_exp)
        valid = check_exp;
    elseif iscell(check_exp)
        elements = check_exp;
        valuecell = repmat({value}, 1, length(elements));
        valid = any(cellfun(@isequal, elements, valuecell));
    elseif length(check_exp) == 1
        valid = isequal(value, check_exp);
    elseif length(check_exp) == 2
        min = check_exp(1);
        max = check_exp(2);
        valid = value >= min && value <= max;
    elseif length(check_exp) > 2
        valid = any(value == check_exp);
    else
        valid = false;
    end
end
