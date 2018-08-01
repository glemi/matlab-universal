% blah
function varargout = equalize(varargin)
    
    if nargin ~= nargout
        error('number of input and output arguments need to be equal');
    end

    N = length(varargin);
    n = +inf;
    for k = 1:N
        array = varargin{k};
        n = min(n, length(array));
    end
    
    for k = 1:N
        array = varargin{k};
        array = array(1:n);
        varargout{k} = array;
    end
end