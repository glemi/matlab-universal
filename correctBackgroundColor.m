function [ output_args ] = correctBackgroundColor(h)
    if nargin > 0
        set(h, 'Color', [237 233 227]/255);    
    else
        set(gcf, 'Color', [237 233 227]/255);
    end
end

