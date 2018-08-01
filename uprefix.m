% Provides a number formatted as text string with SI-prefixes, using the
% specified format, and adding a specified unit Symbol. 
% 
% Usage:
% strings = uprefix(data, unit, format)
%
% Example:
% siPrefix(1.2345E-4, 'A')
% ans = 123?A
% 
% siPrefix(1.2345E-4, 'A', '%3.2f')
% ans = 123.45?A
%
% strings is a cell array if data is a vector, otherwise it is a char
% array.
function strings = uprefix(data, unit, varargin)
    opt format char '%3.*f';
    opt unit char '';
    
    if strfind(varargin{1}, '%')
        format = varargin{1};
    end
    options = varargin;
    
    if ~isnumeric(data) || isempty(data)
        strings = '';
        return;
    end
    if isnan(data)
        strings = 'NaN';
        return;
    end
    
    micro = char(181);
    prefixes = {'y' 'z' 'a' 'f' 'p' 'n' micro 'm' '' 'k' 'M' 'G' 'T' 'P' 'E' 'Z' 'Y'};
    warning off MATLAB:log:logOfZero
    levels = floor(log10(abs(data))/3);
    warning on MATLAB:log:logOfZero
    
    for k = 1:numel(data)
        level = levels(k);
        number  = data(k);
        if level == -inf
            digits = '0';
            prefix = '';
        elseif level > 8
            digits = applyFormat(number/1e24, format);
            prefix = 'Y';
        elseif level < -8
            digits = applyFormat(number*1e24, format);
            prefix = 'y';
        else
            digits  = applyFormat(number/10^(level*3), format);
            prefix  = prefixes{level + 9};
        end
        
        str = [digits ' ' prefix unit];
        if ismember('latex', options)
            str = [digits '\,' prefix unit];
            str = strrep(str, micro, '\mu{}');
        else
            str = strrep(str, micro, '\mu{}');
        end
        if ismember('excape', options)
            str = strrep('\', '\\');
        end
        
        strings{k} = str;
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
