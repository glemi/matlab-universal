% [value, index] = closest(x, x0, y)
% 
% find the data point in array that is closest to value. 
% 
% output: 
%       value   actual value of the closest data point
%       index   position at which value was found
%       delta   difference between input and output values
% 
function [value, index, delta] = closest(x, x0, y)
    
    delta = abs(x - x0);
    [delta, index] = min(delta);

    if nargin == 3
        value = y(index);
    elseif nargin == 2
        value = x(index);
    end
end

