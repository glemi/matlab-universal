% function adaptPaper(setwidth)
function adaptPaper(setwidth, margin)
    opt margin double 5;

    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'Units', 'Centimeters');
    pos = get(gcf, 'Position');
    
    width = pos(3);
    height = pos(4);
    
    if nargin < 1 || isempty(setwidth)
        %scale = 25/max(width, height);
        scale = 1;
    else 
        scale = setwidth/width;
    end
    
    width = width*scale;
    height = height*scale;
    
    left = width*margin/100;
    bottom = height*margin/100;
    
    paperwidth = width + 2*left;
    paperheight = height + 2*bottom;
    papersize = [paperwidth paperheight];
        
    display(sprintf('Paper size: %1.1f x %1.1f', paperwidth, paperheight));
    
    pos = [left bottom width height];
    
    set(gcf, 'PaperSize', papersize);
    set(gcf, 'PaperPosition', pos);
    
    fontsize = 0.4*max(width, height);
    %allfonts('Bookman', fontsize);
    display(sprintf('Fontsize: %1.1f', fontsize));
end
    