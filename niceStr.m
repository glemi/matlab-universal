function nice = niceStr(string)
	% Changes a string by 
	% 1) replacing underscores by spaces
	% 2) inserting a space between a sequence of a lower
	%    case followed by an upper case letter
	% 3) capitalizing the fist letter of the string and 
	%    of each sequence of letters seperated by 
	%    whitespace, i.e. of every "words"

    % make first letter capital
    nice(1) = upper(string(1));
    
    % replace underscores
    string = strrep(string, '_', ' ');
    
    % insert space before capital letters
    cap = lower(string) ~= string;
    for n = 2:numel(string)
        if string(n-1) == ' '
            nice = [nice upper(string(n))];
        elseif cap(n)
            if cap(n-1)
                nice = [nice lower(string(n))];
            else
                nice = [nice ' ' upper(string(n))];
            end;
        else
            nice = [nice string(n)];
        end;
    end;
end