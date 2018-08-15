% Provides a number formatted as text string with SI-prefixes, using the
% specified format, and adding a specified unit Symbol. 
% 
% Usage:
% strings = siPrefix(data, unit, format)
%
% Example:
% siPrefix(1.2345E-4, 'A')
% ans = 123µA
% 
% siPrefix(1.2345E-4, 'A', '%3.2f')
% ans = 123.45µA
%
% strings is a cell array if data is a vector, otherwise it is a char
% array.
%
% See also:
%       uprefix
%
function strings = siPrefix(data, unit, format)
    if nargin < 3 || isempty(format) || length(format) == 0
        format = '%3.*f';
    end
    if nargin < 2
        unit = '';
    end
    
    if ~isnumeric(data) || isempty(data)
        strings = '';
        return;
    end
    if isnan(data)
        strings = 'NaN';
        return;
    end
    
    prefixes = ['y' 'z' 'a' 'f' 'p' 'n' 'µ' 'm' ' ' 'k' 'M' 'G' 'T' 'P' 'E' 'Z' 'Y'];
    warning off MATLAB:log:logOfZero
    levels = floor(log10(abs(data))/3);
    warning on MATLAB:log:logOfZero
    
    for k = 1:numel(data)
        level = levels(k);
        number  = data(k);
        if level == -inf
            digits = '0';
            letter = '';
        elseif level > 8
            digits = applyFormat(number/1e24, format);
            letter = 'Y';
        elseif level < -8
            digits = applyFormat(number*1e24, format);
            letter = 'y';
        else
            digits  = applyFormat(number/10^(level*3), format);
            letter  = strtrim(prefixes(level + 9));
        end
        if length(unit) > 0 && unit(1) == ' '
            unit(1) = [];
            letter = [' ' letter];
        end
        strings{k} = [digits ' ' letter unit];
    end
    
    if k == 1
        strings = char(strings);
    end
end

function string = applyFormat(number, format)
    if ~isempty(strfind(format, '*'))
        if floor(log10(number)) < 1
            string = sprintf(format, 1, number);
        else
            string = sprintf(format, 0, number);
        end
        %n = 3-ceil(log10(number));
        %string = sprintf(format, n, number);
    else
        string = sprintf(format, number);
    end
end
