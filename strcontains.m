function yes = strcontains(string, substring)
    yes = ~isempty(strfind(string, substring));
end