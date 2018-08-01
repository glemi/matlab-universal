function d = derv(y, x)
% d = derv(y, x)
% Derivative of y vs x, keeping the number of points
% usage:
%         Y = f(x);
%         y = derv(Y, x); % y = dY/dx
%
%         plot(x, Y);
%         plot(x, y); 

    xhead = x(1)   - diff(x(1:2));
    xtail = x(end) + diff(x(end-1:end));
    
    yhead = y(1)   - diff(y(1:2));
    ytail = y(end) + diff(y(end-1:end));
    
    dx = diff([xhead x]) + diff([x xtail]);
    dy = diff([yhead y]) + diff([y ytail]);
    
    d = dy./dx;
end

