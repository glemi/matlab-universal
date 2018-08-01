function [container, panel] = uiscrollpane(varargin)
    box = uix.HBox(varargin{:});
    
    panel      = uipanel('Parent', box, 'BorderType', 'none');
    scrollbar  = uicontrol('Parent', box, 'Style', 'Slider');
    box.Widths = [-1 18];
   
    scrollbar.Min = 0;
    scrollbar.Max = 500;
    
    container = uipanel('Parent', panel, 'BorderType', 'none');
    container.Units = 'pixels';
    container.Position(3:4) = panel.Position(3:4);
    
    panel.SizeChangedFcn = @(varargin)resize(scrollbar, container);
    addlistener(scrollbar, 'ContinuousValueChange', @(varargin)scroll(scrollbar, container));
    
    resize(scrollbar, container);
end

function scroll(scrollbar, container)
    scroll = scrollbar.Value;
    container.Position(2) = - scroll;
end

function resize(scrollbar, container)
    innerheight = container.Position(4);
    outerheight = container.Parent.Position(4);
    
    range = innerheight - outerheight;
    scrollbar.Visible = onoff(range > 0);

    scale = innerheight/range;
    scrollbar.SliderStep = [0.1, max(scale, 0.1)];
    scrollbar.Value = range;
    scrollbar.Max = range;
    container.Position(2) = - range;
end
