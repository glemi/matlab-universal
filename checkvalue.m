% function output = checkvalue(input, [default, [range]])
% 
% Checks if a value is within a specified or default range, otherwise
% returns a default value;
%
% usage: 
%			% returns 1 if input is emtpy or not in range [1 inf]
%			output = checkvalue(input); 
%
%			% returns 2 if input is empty or not in range [1 inf]
%			output = checkvalue(input, 2);
%
%			% returns 3 if input is empty or not in range [3 10]
%			output = checkvalue(input, 3, [3 10]);
%
function output = checkvalue(input, default, range)
	if nargin < 3
		range = [1 inf];
	end
	if nargin < 2
		default = 1;
	end
	
	if isempty(input)
		output = default;
	elseif isnumeric(input) 
		inrange = range(1) < input && input < range(2);
		if inrange 
			output = input;
		else
			output = default;
		end
	else
		output = input;
	end

end

