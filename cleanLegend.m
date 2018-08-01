function cleanLegend()
    [hLegend junk hGraph text] = legend();

    n = length(hGraph);
    i = logical(ones(1,n));
    for k = 1:n
        if isempty(text{k}) || strcmp(text{k}(1:4), 'data')
            i(k) = 0;
        end     
    end
    hGraph = hGraph(i);
    text   = text(i);

    legend(hGraph, text{:});
end