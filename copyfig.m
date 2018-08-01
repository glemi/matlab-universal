function hdest = copyfig(hsource, hdest)
    opt hsource matlab.ui.Figure|char|double gcf;
    opt hdest matlab.ui.Figure|char|double figure; 

    if ischar(hsource)
        hsource = fig(hsource);
    elseif isnumeric(hsource)
        hsource = figure(hsource);
    end
    
    if ischar(hdest)
        hdest = fig(hdest); clf;
    elseif isnumeric(hdest)
        hdest = figure(hdest); clf;
    end
    
    set(hdest, 'Color', get(0,'factoryUicontrolBackgroundColor'));
    copyobj(get(hsource,'children'), hdest);
    hdest.Units = hsource.Units;
    hdest.Position = hsource.Position;
end

