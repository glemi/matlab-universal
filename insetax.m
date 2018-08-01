% function ax = insetax(relpos, size, nudge)
%  usage: 
%           insetax southwest normal;
%           insetax('southwest', 'normal', [0.1 0.2 0 0]);
%
%  
%


function ax = insetax(relpos, size, nudge)
    opt size char normal;
    opt nudge double [0 0 0 0];

    parentAx = gca;
    parentpos = parentAx.Position;

    if nargin < 1
        relpos = positions('SouthEast', 'normal');
    elseif ischar(relpos)
        relpos = positions(relpos, size);
    end
    
    [xr, yr, wr, hr] = assign(relpos(:));
    [xp, yp, wp, hp] = assign(parentpos(:));
    
    xa = xp + wp*xr;
    ya = yp + hp*yr;
    wa = wp*wr;
    ha = hp*hr;
    
    ax = axes;
    ax.Position = [xa ya wa ha] + nudge;    
end

function pos = positions(posname, sizename)
    switch lower(sizename)
        case 'tiny',       width = 0.30; height = 0.30;
        case 'normal',     width = 0.35; height = 0.35;
        case 'large',      width = 0.42; height = 0.42;
        case 'huge',       width = 0.50; height = 0.50;
        otherwise,         width = 0.35; height = 0.35;
    end
    
    
    xwest  = 0.05; ysouth = 0.05;
    xcntr  = (1 - width)/2;
    ycntr  = (1 - height)/2;    
    xeast  = 1 - width - xwest;    
    ynorth = 1 - height - ysouth;
    
    switch lower(posname)
        case 'north',      pos =  [xcntr ynorth width height];
        case 'south',      pos =  [xcntr ysouth width height];
        case 'east',       pos =  [xeast ycntr  width height];
        case 'west',       pos =  [xwest ycntr  width height];
        case 'northeast',  pos =  [xeast ynorth width height];
        case 'northwest',  pos =  [xwest ynorth width height];
        case 'southeast',  pos =  [xeast ysouth width height];
        case 'southwest',  pos =  [xwest ysouth width height];
    end
end