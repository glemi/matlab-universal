function h = multiplot(group, plotfun, varargin)
    index = 0;
    for data = varargin
       hFig = fig([group ':' num2str(index)]);
      % hFig = figure(index);
       clf;
       h = plotfun(data{:});
       set(hFig, 'WindowStyle', 'docked');
       
       index = index + 1;
    end
end

