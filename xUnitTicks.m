% Add SI or other units to the axis tick labels, including metric prefixes
% like µ, m, k, M (micro, mili, kilo, Mega) etc. 
% 
% Usage:
% yUnitTicks([handle], unit, [format], [offset])
%
% Examples:
%       yUnitTicks('A');
%
%       yUnitTicks('A', '%0.2f');
%
%       yUnitTicks('A', '%0.2f', -3);
%
%       yUnitTicks(gcf, 'A', '%0.2f'); 
%
% Offset is to compensate if plotted data is already scaled
% by a factor that is a multiple of 10

function xUnitTicks(varargin)
    
    handle = arg(1, 'numeric', gca);
    unit   = arg(2, 'char', '');
    format = arg(3, 'char', '%3.*f');
    offset = arg(4, 'numeric', 0);
    
    unitTicks(handle, 'X', unit, format, offset);
    
end


% function xUnitTicks(handles, unit, format, offset)
% 
%     if nargin < 4
%         offset = 0;
%     end
%     if nargin < 3 || isempty(format) || length(format) == 0
%         format = '%3.0f';
%     end
%     if nargin < 2
%         unit = '';
%     end
%     
%     ticks = get(handles(1), 'XTick');
%     scale = get(handles(1), 'XScale');
%     
%     ticks = ticks - offset;
%     nTicks = numel(ticks);
%     
%     prefixes = ['y' 'z' 'a' 'f' 'p' 'n' 'µ' 'm' ' ' 'k' 'M' 'G' 'T' 'P' 'E' 'Z' 'Y'];
%     warning off MATLAB:log:logOfZero
%     levels = floor(log10(abs(ticks))/3);
%     warning on MATLAB:log:logOfZero
%     
%     for k = 1:numel(ticks)
%         level = levels(k);
%         tick  = ticks(k);
%         if level == -inf
%             number = '0';
%             letter = '';
%         elseif level > 8
%             number = num2str(tick/1e24, format);
%             letter = 'Y';
%         elseif level < -8
%             number = num2str(tick*1e24, format);
%             letter = 'y';
%         else
%             number  = num2str(tick/10^(level*3), format);
%             letter  = prefixes(level + 9);
%         end
%         labels{k} = [number ' ' letter unit];
%     end
%     
%     if ~isempty(ticks)
%         set(handles, 'XTickLabel', labels);
%     end
%     
%     for handle = handles
%         hfig = get(handle, 'Parent');
%         retrieve(hfig, handle, unit, format, offset);
%     end
% end
% 
% function records = retrieve(hFig, hAx, unit, format, offset)
%     persistent figures;
%     
%     if ~isempty(figures)
%         n = find([figures(:).hFig] == hFig);
%     else
%         figures = struct('hFig', {}, 'axes', {});
%         n = [];
%     end
% 
%     if nargin >= 5
%         if isempty(n)
%             fig.hFig = hFig;
%             fig.axes = struct('hAx', {}, 'options', {}, 'other', {});
%             n = length(figures) + 1;
%         else
%             fig = figures(n);
%         end
%         if ~isempty(fig.axes)
%             m = find([fig.axes(:).hAx] == hAx);
%         else
%             m = [];
%         end
%         if isempty(m)
%             opt.unit    = unit;
%             opt.format  = format;
%             opt.offset  = offset;
%             
%             ax.hAx     = hAx;
%             ax.options = opt;
%             ax.other   = hook(hFig);
%             
%             fig.axes(end+1) = ax;
%         else
%             ax = fig.axes(m);
%         end
%         figures(n) = fig;
%         records = fig.axes;
%     else
%         if isempty(n)
%             records = [];
%         else
%             records = figures(n).axes;
%         end
%     end
% end
% 
% function other = hook(hFig)
%     other = get(hFig, 'ResizeFcn');
%     %set(hFig, 'ResizeFcn', @callback);
% end
% 
% function callback(src, evt)
%     records = retrieve(src);
%     
%     %display('XTicks Callback'); tic;
%     records
%     for ax = records
%         if ~isempty(ax.hAx) && ishandle(ax.hAx)
%             unit   = ax.options.unit;
%             format = ax.options.format;
%             offset = ax.options.offset;
% 
%             xUnitTicks(ax.hAx, unit, format, offset);
% %             if isa(ax.other, 'function_handle')
% %                ax.other(src, evt);
% %             end
%         end
%     end
%     %toc;
% end
% 
% function ticks = extendTicks(ticks)
%     level = 24;
%     
%     delta = log10(ticks(end) - ticks(end-1));
%     upper = round(log10(ticks(end)));
%     numbr = (level - upper)/delta + 1;
%     above = logspace(upper, maxLevel, maxLevel - upper + 1);
%     
%     
%     delta = log10(ticks(2) - ticks(1));
%     lower = round(log10(ticks(1)));
%     numbr = (lower - level)/delta + 1;
%     below = logspace(lower, -level, numbr);
%     
%     ticks = [below ticks above];
% end
% 
