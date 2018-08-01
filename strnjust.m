function string = strnjust(varargin)
    
    if nargin <= 2
        string = strjust(varargin{:});
    else
        string = varargin{1};
        adjust = varargin{2};
        length = varargin{3};
        
        string = [string repmat(' ', 1, length)];
        string = string(1:length);
        string = strjust(string, adjust);
    end
end