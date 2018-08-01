function fixBackgroundColors( hParent )
    grey = get(0, 'DefaultUiControlBackgroundColor');
    
    handles = findobj('-property', 'BackgroundColor');
    
    %handles = findobj(handles, '-not',  'BackgroundColor', [1 1 1]);
    
    color = get(handles, 'BackgroundColor');
    white = repmat({[1 1 1]}, size(color));
    
    
    handles = handles(~cellfun(@isequal, color, white));
    
    set(handles, 'BackgroundColor', grey);
    
end

