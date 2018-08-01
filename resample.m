function [x1, y1, i] = resample(x, y, limits)
    n = length(x);

    dx = diff(x); dx = [dx(1); dx(:)];
    dy = diff(y); dy = [dy(1); dy(:)];
    Dy = dy./dx;
    
    ddy = diff(Dy); ddy = [ddy(1); ddy(:)];
    DDy = ddy./dx.^2;
    
    
    if nargin < 3
        limits = min(dx)*1000;
    end
    if length(limits) == 2
        minstep = min(limits);
        maxstep = max(limits);
    else
        minstep = min(dx);
        maxstep = limits;
    end
    
    
    curvature = abs(DDy)./(1 + Dy.^2).^(3/2);
    
    r = scale(((abs(dy./dx))));
    r1 = scale((abs(dx).*abs(dy)));
    u = scale(((abs(dx./dy))));
        
%     fig resample:original; clf;
%     dualax left;
%     plot(x, y, '.');
%     xscale lin;
%     dualax right;
%     plot(x, dy./dx);
%     xscale lin;
    
    u = ((1-r));
    %u = r1;
    
%     fig resample:r; clf;
%     plot(x, scale(curvature), 'DisplayName', 'curvature');
%     plot(x, r, 'DisplayName', 'derivative');
%     plot(x, r1, 'DisplayName', 'multiplication');
%     xscale lin;
%     legend show; legend location best; 
%     
%     fig resample:distribution; clf;
%     N = length(u);
%     distplot(u);
    
    N = length(u);
    cumdist = sort(u)';
    upper = cumdist(round(N*0.99));
    lower = cumdist(round(N*0.03));
    
    u1 = u;
    u1(u > upper ) = upper;
    u1(u < lower ) = lower;
    
%     distplot(u1);

    u2 = 1./(1+ exp(-u1+0.5));
    delta = minstep + (maxstep-minstep)*scale(u1);
    
%     distplot(u2);
    
%     fig resample:delta; clf;
%     plot(x, delta);
%     yscale lin;
%     xscale lin;
%     set(gca, 'YGrid', 'on');
%     crosshair;
    
    cr = scale(cumsum((u2)));
    i = round(1+ scale(cr)*(n-1));
    
    i = zeros(size(x)); i(1) = 1;
    X = x(1);
    for k = 1:n;
        if x(k) - X >= delta(k);
            i(k) = 1;
            X = x(k);
        end
    end    

%     fig resample:indices; clf;
%     plot(1:n, i, '.');
%     ylim([-0.5 1.5]);
%     xscale lin;
%     
%     fig resample:final; clf;  
%     i = logical(i);
%     plot(x(i), y(i), '.');
%     xscale lin;  
%     
%     fig resample:experiment; clf;
%     plot(x, r1);
%     xscale lin;
%     yscale lin;
    
    i = logical(i);
    x1 = x(i);
    y1 = y(i);
    i = find(i);
end

function [sx] = scale(x)
    xrange = max(x) - min(x);
    sx = (x - min(x))/xrange;
end

function distplot(u)
    cumdist = sort(u)';

    i = abs(diff([cumdist(1); cumdist(:)])) > 0;
    %plot(i');
    cumdist = cumdist(i);
    N = length(cumdist);
    
    percent = (1:N)/N*100;
    
    plot(cumdist, percent);
    xscale lin;
end