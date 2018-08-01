function rgb = getSystemColor(item)
    
    import java.awt.*;
    
    switch item
        case 'activeCaption',        color = SystemColor.activeCaption;
        case 'activeCaptionBorder',  color = SystemColor.activeCaptionBorder;
        case 'activeCaptionText',    color = SystemColor.activeCaptionText;
        case 'control',              color = SystemColor.control;
        case 'controlDkShadow',      color = SystemColor.controlDkShadow;
        case 'controlHighlight',     color = SystemColor.controlHighlight;
        case 'controlLtHighlight',   color = SystemColor.controlLtHighlight;
        case 'controlShadow',        color = SystemColor.controlShadow;
        case 'controlText',          color = SystemColor.controlText;
        case 'desktop',              color = SystemColor.desktop;
        case 'inactiveCaption',      color = SystemColor.inactiveCaption;
        case 'inactiveCaptionBorder',color = SystemColor.inactiveCaptionBorder;
        case 'inactiveCaptionText',  color = SystemColor.inactiveCaptionText;
        case 'info',                 color = SystemColor.info;
        case 'infoText',             color = SystemColor.infoText;
        case 'menu',                 color = SystemColor.menu;
        case 'menuText',             color = SystemColor.menuText;
        case 'scrollbar',            color = SystemColor.scrollbar;
        case 'text',                 color = SystemColor.text;
        case 'textHighlight',        color = SystemColor.textHighlight;
        case 'textHighlightText',    color = SystemColor.textHighlightText;
        case 'textInactiveText',     color = SystemColor.textInactiveText;
        case 'textText',             color = SystemColor.textText;
        case 'window',               color = SystemColor.window;
        case 'windowBorder',         color = SystemColor.windowBorder;
        case 'windowText',           color = SystemColor.windowText;
    end
    
    rgb = [0 0 0];
    rgb(1) = color.getRed;
    rgb(2) = color.getGreen;
    rgb(3) = color.getBlue;
    rgb = rgb./255;
end

