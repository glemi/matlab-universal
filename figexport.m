function figexport(filename, size, plotscale, fontscale, linescale)

    if(nargin < 2)
        size = 1024;
    end
    if(nargin < 3)
        plotscale = 3;
    end
    if(nargin < 4)
        fontscale = plotscale/1.5;
    end
    if(nargin < 5)
        linescale = plotscale/2.5;
    end

	set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'inches');
    pos = get(gcf, 'PaperPosition');

    pos1 = pos*plotscale;
    set(gcf, 'PaperPosition', pos1);

    inches = pos1(3);
    dpi = size/inches;
    
    display(sprintf('width: %d', inches));
    display(sprintf('DPI: %d', dpi));
    
    htext = findall(gcf, '-property', 'FontSize');
    hline = findall(gcf, '-property', 'LineWidth');
    
    for i = 1:length(htext)
        fontsize(i) = get(htext(i), 'FontSize');
        set(htext(i), 'FontSize', fontsize(i)*fontscale);
    end
    for i = 1:length(hline)
        linewidth(i) = get(hline(i), 'LineWidth');
        set(hline(i), 'LineWidth', linewidth(i)*linescale);
    end
    
    drawnow;
    print('-dpng', sprintf('-r%d', dpi), filename);
    set(gcf, 'PaperPosition', pos);
    display('fertig');
    
    for i = 1:length(htext)
        set(htext(i), 'FontSize', fontsize(i));
    end
    for i = 1:length(hline)
        set(hline(i), 'LineWidth', linewidth(i));
    end
    drawnow;
end