function i = incr(i)
    assignin('caller', inputname(1), i+1);
    i = i + 1;
end

