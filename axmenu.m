function axmenu( handles )

    if nargin == 0
        handles = findobj(gcf, 'type', 'axes');
    end

    menu = uicontextmenu;
    % Define the context menu items
    %scalemnenu = uimenu(menu, 'Label', 'Scale');

    % Type of line
    uimenu(menu, 'Label', 'Lin', 'Callback', @(~,~)set(gco, 'YScale', 'lin'));
    uimenu(menu, 'Label', 'Log', 'Callback', @(~,~)set(gco, 'YScale', 'log'));
    
    uimenu(menu, 'Label', 'Left Axes', 'Callback', @(~,~)dualax('left'), 'Separator', 'on');
    uimenu(menu, 'Label', 'Right Axes', 'Callback', @(~,~)dualax('right'));
    
    uimenu(menu, 'Label', 'Inspect', 'Callback', @(~,~)inspect(gco), 'Separator', 'on');

    % Set UIcontextmenu
    set(handles, 'UIContextMenu', menu);
end

