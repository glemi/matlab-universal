function yes = isValidFilename(filenames)
    
    if iscell(filenames)
        n = length(filenames);
        for k = 1:n
            yes(k) = isempty(regexp(filenames{k}, '[/\\:\*\?"\<\>\|]', 'once'));
        end
    else
        yes = isempty(regexp(filenames, '[/\\:\*\?"\<\>\|]', 'once'));
    end
    
end

