function [order1 order2] = matchOrder(data1, data2)
    
    [data1 order1] = sort(data1);
    [data2 order2] = sort(data2);
    
    [junk reverse1] = sort(order1);
    [junk reverse2] = sort(order2);
    
    order1 = order1(reverse2);
    order2 = order2(reverse1);
end
