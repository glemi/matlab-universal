function h = growplot(x, y, varargin)

    ax = gca;
    lines = ax.Children;
    n = length(x);
    
    if nargin < 2
        y = x;
        x = [];
    end
    if length(y) ~= n
        error 'x and y values must be of equal length';
    end
    
    if isempty(lines)
        n = length(x);
        for k = 1:n
            if nargin >=3
                plot(x(1), y(1), varargin{:});
            else
                plot(x(1), y(1));
            end
        end
    else
        warning off MATLAB:gui:array:InvalidArrayShape;
        for k = 1:n
            if ~isempty(x)
                lines(k).XData = [lines(k).XData x(k)];
            else
                N = length(lines(k).XData);
                lines(k).XData = [lines(k).XData N+1];
            end
            lines(k).YData = [lines(k).YData y(k)];
        end
    end
end
