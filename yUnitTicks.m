% Add SI or other units to the axis tick labels, including metric prefixes
% like µ, m, k, M (micro, mili, kilo, Mega) etc. 
% 
% Usage:
% yUnitTicks(unit, [format], [offset])
%
% Examples:
%       yUnitTicks('A');
%
%       yUnitTicks('A', '%0.2f');
%
%       yUnitTicks('A', '%0.2f', -3);
%
% Offset is to compensate if plotted data is already scaled
% by a factor that is a multiple of 10
function yUnitTicks(unit, format, offset)
    arg unit char;
    opt format char '%3.*f';
    opt offset double 0;
    
    handle = gca;
    unitTicks(handle, 'Y', unit, format, offset);
end