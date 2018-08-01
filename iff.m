% Ternary operator for matlab
% 
%  output = iff(condition, whentrue, whenfalse)
%  
% 
%
function output = iff(condition, whentrue, whenfalse)
    narginchk(3,3);
    
    nc = length(condition);
    nt = length(whentrue);
    nf = length(whenfalse);
    
    condition = logical(condition);
    
    if nc == 1
        if condition
            output = whentrue;
        else
            output = whenfalse;
        end
    elseif nc == nt && nc == nf
        output(condition) = whentrue(condition);
        output(~condition) = whenfalse(~condition);
    else
        error('if condition is nonscalar, all arguments must be of same size');
    end
end

