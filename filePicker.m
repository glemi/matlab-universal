function filePicker(callback, datadir, title)
    if nargin < 1
        callback = @defaultCallback;
    end

    if nargin < 2
        defaultdir = 'Z:\Work\Matlab\ProbeStation\Data';
        datadir = getGlobal('ProbeStation_DataPath');

        if isempty(datadir) 
            datadir = uigetdir(defaultdir, 'Pick Result Directory');
            if isnumeric(datadir) && datadir == 0
                return;
            end
        end
    end

    content = dir([datadir '\*.mat']);
    hFig = fig(func2str(callback));
    pos = get(hFig, 'Position');
    set(hFig, 'Position', [pos(1:2) 160 300]);
    set(hFig, 'Toolbar', 'none', 'Menubar', 'none');

    hLst = uicontrol(hFig, 'Style', 'listbox');
    
    n = length(content);
    for k = 1:n
        strings{k} = content(k).name;
        data{k} = fullfile(datadir, content(k).name);
    end
    
    set(hLst, 'String', strings);
    set(hLst, 'UserData', data);
    set(hLst, 'Callback', @(hObj, event)onClick(hObj, event, callback));
    set(hLst, 'Units', 'normalized');
    set(hLst, 'Position', [0 0 1 1]);
    
    foldernames = strsplit(datadir, filesep);
    if nargin < 3
        title = sprintf('%s @ %s', func2str(callback), foldernames{end});
    end
    set(hFig, 'NumberTitle', 'off', 'Name', title);
end

function onClick(hObj, eventdata, callback)
    [value, string] = selectedListItem(hObj);
    callback(string, value);
    hFig = get(hObj, 'Parent');
    figure(hFig);
end


function defaultCallback(filename, fullname)
    disp(file);
end

function [value string] = selectedListItem(hList)
    indices = get(hList, 'Value');
    strings = get(hList, 'String');
    values  = get(hList, 'UserData');
    
    index  = indices(1);
    value  = values{index};
    string = strings{index};
end