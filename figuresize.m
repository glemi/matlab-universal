function figuresize(width, height)
    pos = get(gcf, 'Position');
    pos(3) = width;
    pos(4) = height;
    set(gcf, 'Position', pos);
end
