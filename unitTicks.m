% Usage:
% unitTicks(handle, axis, unit, format, offset)
% 
% Example:
% yUnitTicks(gcf, 'Y', 'A', '%0.2f'); 
%
% Offset is to compensate if plotted data is already scaled
% by a factor that is a multiple of 10
function unitTicks(handle, axis, unit, format, offset)
    
    if length(handle) > 1
        for h = handle
            unitTicks(h, axis, unit, format, offset)
        end
        return;
    end

    ticks = get(handle, [axis 'Tick']);
    scale = get(handle, [axis 'Scale']);
    
    ticks = ticks - offset;
    nTicks = numel(ticks);
    
    prefixes = ['y' 'z' 'a' 'f' 'p' 'n' 'µ' 'm' ' ' 'k' 'M' 'G' 'T' 'P' 'E' 'Z' 'Y'];
    warning off MATLAB:log:logOfZero
    levels = floor(log10(abs(ticks))/3); % 1 level = 3 digits!
    warning on MATLAB:log:logOfZero
    
    for k = 1:numel(ticks)
        level = levels(k);
        tick  = ticks(k);
        if level == -inf
            digits = '0';
            letter = '';
%         elseif level > 8
%             digits = applyFormat(tick/1e24, format);
%             letter = 'Y';
%         elseif level < -8
%             digits = applyFormat(tick*1e24, format);
%             letter = 'y';
        elseif level > 8
            digits = sprintf('%g', tick);
            letter = '';
        elseif level < -8
            digits = sprintf('%g', tick);
            letter = '';
        else
            digits  = applyFormat(tick/10^(level*3), format);
            letter  = prefixes(level + 9);
        end
        labels{k} = [digits ' ' letter unit];
    end
    
    if length(ticks) > 0
        set(handle, [axis 'TickLabel'], labels);
    end
    
    hfig = get(handle, 'Parent');
    retrieve(hfig, handle, unit, format, offset);
end

function string = applyFormat(number, format)
    if ~isempty(strfind(format, '*'))
        if floor(log10(number)) < 1
            string = sprintf(format, 1, number);
        else
            string = sprintf(format, 0, number);
        end
        %n = 1-floor(log10(number));
        %string = sprintf(format, n, number);
    else
        string = sprintf(format, number);
    end
end

function records = retrieve(hFig, hAx, unit, format, offset)
    persistent figures;
    
    if ~isempty(figures)
        n = find([figures(:).hFig] == hFig);
    else
        figures = struct('hFig', {}, 'axes', {});
        n = [];
    end

    if nargin >= 5
        if isempty(n)
            fig.hFig = hFig;
            fig.axes = struct('hAx', {}, 'options', {}, 'other', {});
            n = length(figures) + 1;
        else
            fig = figures(n);
        end
        if ~isempty(fig.axes)
            m = find([fig.axes(:).hAx] == hAx);
        else
            m = [];
        end
        if isempty(m)
            opt.unit    = unit;
            opt.format  = format;
            opt.offset  = offset;
            
            ax.hAx     = hAx;
            ax.options = opt;
            ax.other   = hook(hFig);
            
            fig.axes(end+1) = ax;
        else
            ax = fig.axes(m);
        end
        figures(n) = fig;
        records = fig.axes;
    else
        if isempty(n)
            records = [];
        else
            records = figures(n).axes;
        end
    end
end

function other = hook(hFig)
    other = get(hFig, 'ResizeFcn');
    %set(hFig, 'ResizeFcn', @callback);
end
