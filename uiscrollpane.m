function [container, panel] = uiscrollpane(varargin)
    box = uix.HBox(varargin{:});
    
    panel      = uix.HBox('Parent', box);
    scrollbar  = uicontrol('Parent', box, 'Style', 'Slider');
    box.Widths = [-1 18];
   
    scrollbar.Min = 0;
    scrollbar.Max = 500;
    
    container = uipanel('Parent', panel, 'BorderType', 'none');
    container.Units = 'pixels';
    container.Position(3:4) = panel.Position(3:4);
    
    panel.SizeChangedFcn = @(varargin)resize(scrollbar, container);
    addlistener(scrollbar, 'ContinuousValueChange', @(varargin)scroll(scrollbar, container));
    %childObserver = uix.ChildObserver(container);
    %addlistener(childObserver, 'ChildAdded', @(varargin)onChildAdded(scrollbar, container));
    
    resize(scrollbar, container);
end

function scroll(scrollbar, container)
    scroll = scrollbar.Value;
    move(container, -scroll);
end

function resize(scrollbar, container)
    updateScrollbar(scrollbar, container);
    
    scroll = scrollbar.Value;
    move(container, -scroll);
end

function onChildAdded(scrollbar, container)
    updateScrollbar(scrollbar, container);
end

function move(container, scroll)
    initial = container.UserData;
    height = container.Position(4);

    if ~isempty(container.Children)
        children = container.Children;
        n = length(children);
        
        current = vertcat(children.Position);
        current = current(:,2) ;
        if isempty(initial) || n > length(initial)
            initial = current - height;
            container.UserData = initial;
        end

        new = initial;
        new = new + scroll + height; 

        for k = 1:n
            children(k).Position(2) = new(k,:);
        end
    end
end

function updateScrollbar(scrollbar, container)
    innerheight = getContentHeight(container);
    outerheight = container.Parent.Position(4);
    
    range = innerheight - outerheight;
    scrollbar.Visible = onoff(range > 0);

    scale = innerheight/range;
    scrollbar.SliderStep = [0.1, max(scale, 0.1)];

    scrollbar.Min = -range;
    scrollbar.Max = 0;
    
    scrollbar.Visible = onoff(range > 0);
end

function height = getContentHeight(container)
    children = container.Children;
    if ~isempty(children)
        pos = vertcat(children.Position);
        y = pos(:,2);
        [y0, i0] = min(y);
        [y1, i1] = max(y);

        y1 = y1 + children(i1).Position(4); % height 
        height = y1 - y0 + 50;
    else
        height = container.Position(4);
    end
end


