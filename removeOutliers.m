% function data = removeOutliers(data, tol,  wndSize)
%
% Uses a moving window w of width n (total length of data is N). The window
% is moved in steps of 1 data point at a time inside a loop. 
% 
% At every iteration of the loop, the median of the window m = median(w) 
% and the median of the diffs in the window md ~= median(diff(w)) are
% computed. 
% 
% Inside the window, every point is marked that differs from the median by
% more than a tolerance threshold is marked. The tolerance depends on md.
% In other words if a datapoint differs from the m by much more than the
% median difference between data points it is marked. 
%
%
function data = removeOutliers(data, tol,  wndSize)
    if nargin < 2
        tol = 2;
    end
    
    if nargin < 3
        wndSize = 10;
    end

    head = median(data(1:5));
    tail = median(data(end-5:end));
    data = [head data(:)' tail];
    
    N = length(data);
    n = wndSize;
    
%     blur = [head data] + [data tail];
%     blur = blur/2;
%     blur = blur(2:end-1);
   % fig('removeoutliersdebug');cla;
    
    for k = 2:N-n-1
        w = data(k:k+n);
        w1 = (data(k-1:k+n-1) + data(k+1:k+n+1))/2;
        
        m = median(w);
        md = median(unique(abs(diff(w))));
        
        i = ones(1, n);
        t = tol;
        while sum(i)/n > 0.2
            t = t + 1; 
            i = (abs(w-m) > t*md);
            if t > 20 
                md = md +  median(abs(unique(diff(data))));
                t = 2;
            end
        end
        
        w(i) = w1(i);
        %debugplot(k:k+n, w, data(k:k+n));
        data(k:k+n) = w;
    end
    
    data = data(2:end-1);
end

function debugplot(x, filtered, original)
    fig('removeoutliersdebug');
    h1 = plot(x, original, 'o'); hold on;
    h2 = plot(x, original, '-');
    
    set(h1, 'MarkerSize', 4, 'MarkerFaceColor', 'k');
end