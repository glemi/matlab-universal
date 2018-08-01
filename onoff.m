% char = onoff(boolean)
% use to convert boolean values into 'on' or 'off' strings for handle
% object properties. 
% E.g. 
%       set(h, 'Enable', onoff(x > 0));
% 
% instead of (argh!)
%       
%       if x > 0
%           set(h, 'Enable', 'on');
%       else 
%           set(h, 'Enable', 'off');
%       end
%
function char = onoff(boolean)
    if boolean
        char = 'on';
    else
        char = 'off';
    end
end

