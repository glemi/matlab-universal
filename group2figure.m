function group2figure(group)    
    if nargin == 0
        group = gcf;
    end
    
    if isnumeric(group) || isa(group, 'matlab.ui.Figure')
        tag = get(group, 'Tag');
        parts = strsplit(tag, ':');
        group = parts{1};
    end 
    
    handles = findFigures(group);
    
	pos = getGroupWindowSize(group);
    if isempty(pos) 
        return;
    end
    hNew = figure('Position', pos);
    set(hNew, 'Color', get(0,'factoryUicontrolBackgroundColor'));
    
    for hFig = [handles(:)]'
        try
        objects = findobj(hFig.Children, 'Type', 'Axes');
        set(objects, 'Units', 'Pixels');
        outerPos = get(hFig, 'Position');
        
        newobjs = copyobj(objects, hNew);
        
        for newobj = [newobjs(:)]'
            innerPos = get(newobj, 'Position');
            newPos = [outerPos([1 2]) 0 0] + innerPos;
            set(newobj, 'Position', newPos);
        end
        set(newobjs, 'Units', 'Normalized');
        set(objects, 'Units', 'Normalized');
        end
        
        %annotation objects
        try
        objects = findall(hFig, '-property', 'Type', 'Type', 'textboxshape');
        set(objects, 'Units', 'Pixels');
        outerPos = get(hFig, 'Position');
        
        newobjs = copyobj(objects, hNew);
        
        for newobj = [newobjs(:)]'
            innerPos = get(newobj, 'Position');
            newPos = [outerPos([1 2]) 0 0] + innerPos;
            set(newobj, 'Position', newPos);
        end
        set(newobjs, 'Units', 'Normalized');
        set(objects, 'Units', 'Normalized');
        end
    end
end

function handles = findFigures(group)
    handles = findobj('Type', 'figure', 'WindowStyle', 'docked'); 
    tags = get(handles, 'Tag');
    indices = strfind(tags, [group ':']);
    indices = cellfun(@(x)(~isempty(x) && x == 1), indices);
    handles = handles(indices);
end

function pos = getGroupWindowSize(group)
    desktop = com.mathworks.mde.desk.MLDesktop.getInstance;
    container = desktop.getGroupContainer(group);
    pos = get(container, 'VisibleRect');
    
    if isa(pos, 'java.awt.Rectangle')
        x = pos.getX;
        y = pos.getY;
        w = pos.getWidth;
        h = pos.getHeight;
        pos = [x y w h];
    end
end

function pos = getPosPixels(h)
    units = get(h, 'Units');
    set(h, 'Units', 'Pixels');
    pos = get(h, 'Position');
    set(h, 'Units', units);
end