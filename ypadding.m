function ypadding( scale )
    opt scale double 0.1
    
    hAx = gca;
    
    upper = hAx.YLim(2);
    lower = hAx.YLim(1);
    
    range = upper - lower;
    
    if range > 0
        order = round(log10(range));

        upper = upper + scale*10^order;
        lower = lower - scale*10^order;
    end
    
    hAx.YLim = [lower upper];
end

