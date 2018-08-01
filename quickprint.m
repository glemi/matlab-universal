% function quickprint(filename, outdir)
%
% Saves the current figure as PDF file.
function quickprint(filename, outdir, width, margin)
    opt filename char tempname;
    opt outdir char '';
    opt width double [];
    opt margin double 5;
    
    %adaptPaper(width, margin);
    
    %% new code
    fig = gcf;
    fig.Units = 'centimeters';
    fig.PaperUnits = 'centimeters';
    fig.PaperPosition = fig.Position;
    fig.PaperSize = fig.Position(3:4);
    
    %% end new code
    
    %dualax update;
    printok = false;
    
    filename = fullfile(outdir, filename);
    
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


