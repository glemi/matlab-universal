function skipcolor   
    ci = get(gca, 'ColorOrderIndex');
    set(gca, 'ColorOrderIndex', max(ci-1, 1));
end