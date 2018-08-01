function filename = quickPdf(varargin)
    %handle = arg(1, 'numeric', gcf);
    if nargin < 1
        handle = gcf;
    else
        handle = varargin{1};
    end
    
    figure(handle);
    filename = tempname;
    
    %adaptPaper;
    %% new code: replaces adaptPaper {
    fig = gcf;
    fig.Units = 'centimeters';
    fig.PaperUnits = 'centimeters';
    fig.PaperPosition = fig.Position;
    fig.PaperSize = fig.Position(3:4);
    %% } end new code
    
    print(handle, '-dpdf', sprintf('-r%d', 300), filename);
    open([filename '.pdf']);
end

