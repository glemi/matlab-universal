function array = structInit(type, varargin)
    if nargin == 1
        array = type;
    elseif nargin == 2
        % second argument is the array size
        if isempty(varargin{1})
            size = 0;
        elseif isnumeric(varargin{1})
            size = varargin{1};
        else
            size = 1;
        end
        if isequal(size, 0) 
            % size = 0 ... make array empty
            array = type;
            array(:,:) = [];
            array(:) = [];
        elseif length(size) == 1
            % size is one-dimensional, make n x 1 array
            array = repmat(type, size, 1);
        elseif length(size) > 1
            % size is 2-dim or more, make n x m x .. array
            array = repmat(type, size);
        end
    elseif nargin > 2 && mod(nargin-1, 2) == 0
        array = type;
        n = (nargin-1)/2;
        names  = varargin(1:2:2*n-1);
        values = varargin(2:2:2*n);
        for k = 1:n
            array.(names{k}) = values{k};
        end
    elseif nargin > 2 
        n = (nargin-2)/2;
        
        size   = varargin(1);
        names  = varargin(2:2:2*n-1);
        values = varargin(3:2:2*n);
        for k = 1:n
            array.(names{k}) = values{k};
        end
        array  = repmat(array, size, 1);
    end
end
