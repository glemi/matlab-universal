% Plot uval arrays with error bars
% 
% uplot uses errorbar internally for creating the plot. Linespec and
% name-value argument pairs supported by errorbar are also supported by
% uplot.
%   
% usage: 
%           uplot(x, y);
%           uplot(x, y, 'o'); 
%           uplot(x, y, 'CapSize', 5);
%           e = uplot(x, y);
% 
% see also:
%           uval, plot, errorbar
function e = uplot(ux, uy, varargin)
    
    x = double(ux);
    y = double(uy);
    
    xneg = zeros(size(x));
    xpos = zeros(size(x));
    yneg = zeros(size(y));
    ypos = zeros(size(y));
    
    if isa(uy, 'uval') 
        yneg = [uy.Minus];
        ypos = [uy.Plus];
    end
    if isa(ux, 'uval')
        xneg = [ux.Minus];
        xpos = ux.Plus;
    end
    
    e = errorbar(x,y,yneg,ypos,xneg,xpos,varargin{:});
end

