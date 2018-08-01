% Add SI or other units to the axis tick labels, including metric prefixes
% like µ, m, k, M (micro, mili, kilo, Mega) etc. 
% 
% Usage:
% yUnitTicks([handle], unit, [format], [offset])
%
% Examples:
%       zUnitTicks('A');
%
%       zUnitTicks('A', '%0.2f');
%
%       zUnitTicks('A', '%0.2f', -3);
%
%       zUnitTicks(gcf, 'A', '%0.2f'); 
%
% Offset is to compensate if plotted data is already scaled
% by a factor that is a multiple of 10
function zUnitTicks(varargin)
    
    handle = arg(1, 'numeric', gca);
    unit   = arg(2, 'char', '');
    format = arg(3, 'char', '%3.*f');
    offset = arg(4, 'numeric', 0);
    
    unitTicks(handle, 'Z', unit, format, offset);
    
end