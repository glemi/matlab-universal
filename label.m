% Auxilary function for creating text on axes.
% 
% Usage: 
%       tx = label(pos, object)
%
%       % add options for text object
%       tx = label(pos, object, name, value, ...) 
%
% Arguments:
%       pos     Position in normalized units
%       object  Either a string or the handle of a line object, in which
%               case the DisplayName property of the object is used. 
%       
%       tx      returns the text object handle
%
%
function tx = label(pos, object, varargin)
    
    tx = text;
    
    if ischar(object)
        string = object;
        tx.String = string;
    elseif ishandle(object)
        string = get(object, 'DisplayName');
        color = get(object, 'Color');
        tx.String = string;
        tx.Color = color;
    end
    
    tx.FontName = 'Times';
    tx.FontSize = 14;
    tx.Units = 'Normalized';
    tx.Position = pos;
    %tx.BackgroundColor = 'w';
    
    if length(strfind(string, '$')) >= 2
        tx.Interpreter = 'latex';
    else
        tx.FontAngle =  'italic';
    end
    
    try
        params = fontspeceval(varargin{1});
        set(tx, params{:});
        if length(varargin) > 2
            set(tx, varargin{2:end});
        end
    catch
        if length(varargin) >= 2
            set(tx, varargin{:});
        end
    end

end

