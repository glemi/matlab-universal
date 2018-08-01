% function mkpdf(filename, size, margins)
% 
% Create an PDF file from a figure, automatically adjusting paper size and
% position on paper. Size and Margins can be specified in centimeters.
% 
% usage: 
%         mkpdf('plot.pdf');            % create pdf in current folder
%         mkpdf('figures\plot.pdf');    % specify relative path
%         mkpdf('C:\figures\plot.pdf'); % specify absolute path
%           
%         mkpdf('plot.pdf', [10 14]);   % resize to 10cm x 14cm 
%         mkpdf('plot.pdf', 10);        % resize to 10cm width, adjusting
%                                            height to keep proportions
%           
%         mkpdf('plot.pdf', [], 2)      % set margins to 2cm on all sides
%         mkpdf('plot.pdf', [], [1.5 1]) % left/right 1.5cm, botton/top 1cm
%         mkpdf('plot.pdf', [], [1 2 3 4])  %  left top right bottom 
%
function mkpdf(filename, size, margins)
    opt filename char tempname;
    opt size double [];
    opt margins double [];
    
    f = gcf;
    f.Units = 'centimeters';
    f.PaperUnits = 'centimeters';
    
    if isempty(size)
        size = f.Position(3:4);
    elseif isscalar(size)
        size = f.Position(3:4).*(size/f.Position(3)*[1 1]);
    end
    
    if isempty(margins)
        margins = [0 0 0 0];
    elseif isscalar(margins) 
        margins = [1 1 1 1]*margin;
    elseif length(margins) == 2
        margins = [margins margins];
    end
    
    f.PaperPosition(1:2) = margins(1:2);           % cneter figure in page
    f.PaperPosition(3:4) = size; % figure size same as on screen
    f.PaperSize = size + margins([1 3]) + margins([2 4]);  % margin: 1cm on each side
    

    printok = false;
    
    while ~printok
        try
            print(gcf, '-dpdf', sprintf('-r%d', 300), filename);
            printok = true;
        catch
            printok = false;
            numeral_pos = regexp(filename, '\d*$');
            if ~isempty(numeral_pos)
                numeral = str2num(filename(numeral_pos:end)) + 1;
                filename = [filename(1:numeral_pos-1) num2str(numeral)];
            else
                filename = [filename '1'];
            end
        end
    end
end


