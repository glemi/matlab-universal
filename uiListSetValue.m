% 
% function index = uiListSetValue(hList, value, property)
% 
% usage:
%       uiListSetValue(hList, 'item xy');          % uses String property
%       uiListSetValue(hList, 1.75, 'UserData');   % looks for 1.75 in UserData 
%       index = uiListSetValue(hList, 'item xy');  % also returns position of 'item xy'
%
% returns 0 if item could not be found
function index = uiListSetValue(hList, value, property)
	if nargin < 3
		property = 'String';
	end
	
	index = 0;
	values = get(hList, property);
	if ~iscell(values) || isempty(value)
		return;
	end
	
	n = length(values);
	for k = 1:n
		
		if ischar(value)
			if strcmp(value, values{k})
				index = k;
				set(hList, 'Value', index);
				return;
			end
		else
			if value == values{k}
				index = k;
				set(hList, 'Value', index);
				return;
			end
		end
	end
	index = 0;
end

