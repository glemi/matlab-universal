function hax = dualax(action)
    if nargin == 0 && nargout == 0;
        action = 'left';
%     elseif nargout > 0
%         return;
    end
    
    contains = @(str)~isempty(strfind(action, str));
    if contains('left')
        activate = 'left';
    elseif contains('right');
        activate = 'right';
    else
        activate = action;
    end
    
    [aleft, aright, aback] = findBoth(activate);
        
    switch action
        case 'left'
            if ~isempty(aright)
                icolr = aright.ColorOrderIndex;
                aleft.ColorOrderIndex = icolr;
                if ~strcmp(aleft.XAxisLocation, aright.XAxisLocation) && isempty(aleft.XTick);
                    %aleft.XTickMode = 'auto';
                end
            end
            hax = aleft;

        case 'right'
            if ~isempty(aleft)
                icolr = aleft.ColorOrderIndex;
                aright.ColorOrderIndex = icolr;
                if ~strcmp(aleft.XAxisLocation, aright.XAxisLocation) && isempty(aright.XTick);
                    %aright.XTickMode = 'auto';
                end
            end
            hax = aright;
        
        case 'bottomleft'
            aleft.XAxisLocation = 'bottom'; 
            aleft.XTickMode = 'auto';
            if ~isempty(aright)
                icolr = aright.ColorOrderIndex;
                aleft.ColorOrderIndex = icolr;
%                 aright.XAxisLocation = 'top';
%                 aright.XTick = 'auto';
            end
            hax = aleft;

        case 'bottomright'
            aright.XAxisLocation = 'bottom';
            aright.XTickMode = 'auto';
            if ~isempty(aleft)
                icolr = aleft.ColorOrderIndex;
                aright.ColorOrderIndex = icolr;
%                 aleft.XAxisLocation = 'top';  
%                 aleft.XTick = 'auto';
            end
            hax = aright;
            
        case 'topleft'
            aleft.XAxisLocation = 'top';            
            if ~isempty(aright)
                icolr = aright.ColorOrderIndex;
                aleft.ColorOrderIndex = icolr;
%                 aright.XAxisLocation = 'bottom';
%                 aright.XTick = 'auto';
            end
            hax = aleft;
            
        case 'topright'
            aright.XAxisLocation = 'top';
            if ~isempty(aleft)
                icolr = aleft.ColorOrderIndex;
                aright.ColorOrderIndex = icolr;
%                 aleft.XAxisLocation = 'bottom';  
%                 aleft.XTick = 'auto';
            end
            hax = aleft;
           
        case 'update';
            if ~(isempty(aleft) || isempty(aright) || isempty(aback))
                update(aleft, aright, aback);
            end
    end
end

function [aleft, aright, aback] = findBoth(action)
    ax = gca;
    parent = ax.Parent;
    
    aleft  = findobj(parent, 'Tag', 'Left', 'Position', ax.Position);
    aright = findobj(parent, 'Tag', 'Right', 'Position', ax.Position);
    aback  = findobj(parent, 'Tag', 'Background', 'Position', ax.Position);
    
    switch lower(action)
        case 'left'
            if isempty(aright)
                aleft = ax;
                ax.Tag = 'Left';
                ax.YAxisLocation = 'Left';
            elseif isempty(aleft)
                createBackground;
                axes(aright);
                aleft = create2nd('Left');
            else
                axes(aback); axes(aright); axes(aleft);
            end
            
        case 'right'
            if isempty(aleft)
                aright = ax;
                ax.Tag = 'Right';
                ax.YAxisLocation = 'Right';
            elseif isempty(aright)
                createBackground;
                axes(aleft);
                aright = create2nd('Right');
            else
                axes(aback); axes(aleft); axes(aright); 
            end
    end

end

function asecnd = create2nd(side)
    afirst = gca;
    asecnd = axes;
    
    afirst.Box = 'off';
    afirst.Color = 'none';
    
    asecnd.Position = afirst.Position;
    asecnd.YAxisLocation = lower(side);
    asecnd.XAxisLocation = 'top';
    asecnd.XTick = [];
    asecnd.Color = 'none'; 
    asecnd.Box = 'off';
    asecnd.Tag = side;
end

function update(aleft, aright, aback)
    %aright.XTickMode = 'auto';
    %aleft.XTickMode = 'auto';

    if strcmp(aleft.XAxisLocation, aright.XAxisLocation)
        limleft = aleft.XLim;
        limright = aright.XLim;
        limboth = [min([limleft, limright]) max([limleft, limright])];
        aleft.XLim = limboth;
        aright.XLim = limboth;
        aright.XTick = [];
    end
    
    posleft = aleft.Position;
    posright = aright.Position;
    posback = aback.Position;
    
    posall = [posleft;posright;posback];
    posmin = min(posall, [], 1);
    posmax = max(posall, [], 1);
    
    posnew = [posmin(1:2) posmax(3:4)];
    
    aback.Position = posnew;
    aleft.Position = posnew;
    aright.Position = posnew;
end

function bgax = createBackground()
    afirst = gca;
    bgax = findobj(gcf, 'Tag', 'Background', 'Position', afirst.Position);
    
    if isempty(bgax)
        bgax = axes;
        
        bgax.Position = afirst.Position;
        bgax.XTick = [];
        bgax.YTick = [];
        bgax.Color = 'white';
        bgax.Box = 'on';
        bgax.Tag = 'Background';
    end
end