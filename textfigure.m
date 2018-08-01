% usage: 
%       figure;
%       hFile = textfigure();
%       fprintf(hFile, 'sample text\n');
%       textfigure('update');
function hFile = textfigure(varargin)
    if nargin == 0
        [hCtl, hFile] = create();
    elseif ishandle(varargin{1})
        hFig = varargin{1};
        update(hFig);
    elseif ischar(varargin{1})
        option = varargin{1};
        switch lower(option)
            case 'update'
                update(gcf);
            case 'close' 
                closefile(gcf);
            case 'clear'
                cleartext(gcf);
        end
    end
    %hFile = @()smartHandle(hFile, gcf);
end

function[hCtl, hFile] = create()
    clf;    
    hCtl = uicontrol('Style', 'Edit');
    set(hCtl, 'Units', 'normalized');
    set(hCtl, 'Position', [0 0 1 1]);
    set(hCtl, 'FontName', 'Courier');
    set(hCtl, 'HorizontalAlignment', 'Left');
    set(hCtl, 'Max', 1000);
    hFile = fopen(tempname, 'w+');
    set(gcf, 'UserData', hFile);
    set(gcf, 'DeleteFcn', @onClose);
    set(gcf, 'Toolbar', 'figure');
end

function update(hFig)
    hCtl = findobj(hFig, 'Type', 'uicontrol');
    hFile = get(hFig, 'UserData');

    frewind(hFile);
    text{1} = fgetl(hFile);
    tline = text{1};
    while ischar(tline)
        tline = fgetl(hFile);
        text{end+1} = tline; %#ok<AGROW>
    end
    set(hCtl, 'Max', length(text));
    set(hCtl, 'String', text(1:end-1));
end

function cleartext(hFig)
    hCtl = findobj(hFig, 'Type', 'uicontrol');
    set(hCtl, 'String', '');
end

function closefile(hFig)
    hFile = get(hFig, 'UserData');
    fclose(hFile);
end

function onClose(hFig, ~)
    closefile(hFig);
end

function hFile = smartHandle(hFile, hFig)
    update(hFig);
end