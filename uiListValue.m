% 
% function [value, index] = uiListValue(hList, property)
% 
% usage:
%   [value, index] = uiListValue(hList); 
%	[value, index] = uiListValue(hList, 'UserData');
%    
%	default property is 'String'
% 
%
function [value, index] = uiListValue(hList, property)
	if nargin < 2
		property = 'String';
	end

	index = get(hList, 'Value');
	
	if isempty(index)
		value = [];
	else
		values = get(hList, property);
		value = values{index};
	end
end

