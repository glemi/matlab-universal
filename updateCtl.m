% Generic Function to update uicontrol with new data
%
% usage: 
%			updateCtl(handle, value);
%
function updateCtl(hCtl, value)
	
	style = get(hCtl, 'Style');
	switch style
		case 'popupmenu'
			data = get(hCtl, 'UserData');
			k = findindex(value, data);
			set(hCtl, 'Value', k);
		case 'checkbox'
			if isempty(value)
				set(hCtl, 'Value', false);
			elseif islogical(value)
				set(hCtl, 'Value', value);
			elseif isnumeric(value)
				set(hCtl, 'Value', logical(value))
			elseif ischar(value) 
				value = ismember(lower(value), {'on' 'yes' 'true' 'check'});
				set(hCtl, 'Value', value);
			end
		otherwise
			error('updateCtl:unsupported', 'Control type is unsupported'); 
	end
	
end

function index = findindex(value, data)
	switch class(value)
		case 'function_handle'
			n = length(data);
			for k = 1:n
				if isequal(data{k}, value)
					index = k;
					break;
				end							
			end
		case 'string'
			index = strcmp(value, data);
		otherwise
			error('updateCtl:unsupported', 'Data type is unsupported'); 
	end
end

