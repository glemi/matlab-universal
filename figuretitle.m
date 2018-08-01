% Create a large title on top of the current figure
% 
% usage: 
%           hTxt = figuretitle(string);
%           hTxt = figuretitle(string, 'PropertyName', value, ...);
% 
% Next to the string argument a number of name-value pairs can be passed to
% this function to control the title's appearance. The name-value pairs
% must correspond to valid <a href="matlab:web([matlabroot '\help\matlab\ref\text-properties.html'], '-helpbrowser')">Text Properties</a>
% 
% For example: FontName, FontSize, FontWeight ('normal' | 'bold'), Color 
%
% Note that figuretitle will slightly change the position of all axes
% contained inside the figure. The height that is reserved to accomodate
% the title is 50 pixels. 
%
% see also text, listfonts
function hTxt = figuretitle(string, varargin)
    
    hFig = gcf;
    haxes = get(hFig, 'Children');
    
    % Figure position
    fpos = get(hFig, 'Position');
    fwidth  = fpos(3); fheight = fpos(4);
    
    % Title position : Height is 50px!
    twidth  = fwidth*0.9;   theight = 50;
    txpos   = fwidth*0.1;  typos   = fheight-theight;
    tpos = [txpos typos twidth theight];
    
    % Shrink all axes by this factor to accomodate the title
    shrink = 1- theight/fpos(4);
    
    for h = haxes'
        pos = get(h, 'Position');
        
        xpos  = pos(1); ypos   = pos(2);
        width = pos(3); height = pos(4);
        
        ypos   = ypos*shrink;
        height = height*shrink;
        
        pos = [xpos ypos width height];
        set (h, 'Position', pos);
    end
    
    hAx = axes('Parent', hFig, 'Units', 'Pixels', 'Position', tpos);
    set(hAx, 'Visible', 'off');
    
    parnames  = lower(varargin(1:2:end-1));
    parvalues =       varargin(2:2:end);
    params    = cell2struct(parvalues, parnames, 2);
    
    if ~isfield(params, 'fontsize')
        params.fontsize = 16;
    end
    if ~isfield(params, 'fontweight')
        params.fontweight = 'bold';
    end
    
    parnames  = fieldnames(params);
    parvalues = struct2cell(params); 
    pairs = {parnames{:}; parvalues{:}};

    hTxt = text('Parent', hAx, 'Position', [0.5 0.5]); 
    set(hTxt, 'HorizontalAlignment', 'center', 'String', string);
    set(hTxt, pairs{:});
end

