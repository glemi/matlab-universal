% usage: 
%       listPicker(callback, list, title)
%
%   callback: a function handle @(string, index)
%   list:     a cell array of strings
%   title:    title for the figure
%
function listPicker(callback, list, title)
    if nargin < 1
        callback = @defaultCallback;
    end

    hFig = fig(func2str(callback));
    pos = get(hFig, 'Position');
    set(hFig, 'Position', [pos(1:2) 160 300]);
    set(hFig, 'Toolbar', 'none', 'Menubar', 'none');
    hLst = uicontrol(hFig, 'Style', 'listbox');
    
    set(hLst, 'String', list);
    set(hLst, 'Callback', @(hObj, event)onClick(hObj, event, callback));
    set(hLst, 'Units', 'normalized');
    set(hLst, 'Position', [0 0 1 1]);
    
    if nargin < 2
        title = sprintf(func2str(callback));
    end
    set(hFig, 'NumberTitle', 'off', 'Name', title);
end

function onClick(hObj, ~, callback)
    [index, string] = selectedListItem(hObj);
    callback(index, string);
    hFig = get(hObj, 'Parent');
    figure(hFig);
end

function defaultCallback(string, index)
    disp(file);
end

function [index, string] = selectedListItem(hList)
    indices = get(hList, 'Value');
    strings = get(hList, 'String');
    
    index  = indices(1);
    string = strings{index};
end