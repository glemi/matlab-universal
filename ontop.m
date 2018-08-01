function ontop(hFig)
    warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
    if nargin < 1
        hFig = gcf;
    end
    % argh not working.
    drawnow expose;
    pause(0.001);
    try 
        frame = get(hFig, 'JavaFrame');
        frame.getWindow.setAlwaysOnTop(true);
    catch 
        frame = get(hFig, 'JavaFrame');
        window = javax.swing.SwingUtilities.getWindowAncestor(frame.getAxisComponent);
        window.setAlwaysOnTop(true);
    end
end

