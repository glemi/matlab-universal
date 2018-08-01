% function out = structmerge(varargin)
%  
% Merge two or more structs into a single struct combining the fields of
% all the input structures. 
%
% usage: 
%           merged = structmerge(struct1, struct2);
%           merged = structmerge(struct1, struct2, struct3, ...);
%
% Note: If the any two ore more structures in the argument list have a
% fieldname in common then, in the resulting structure, the value of the
% rightmost argument that has a value stored under this fieldname is
% retained.
%  
function out = structmerge(varargin)
	n = nargin;
	out = struct;
	
	for k = 1:n
		item = varargin{k};
		
		if isempty(item)
			continue;
		end
		
		fields = fieldnames(item);
		values = struct2cell(item);
		
		m = length(fields);
		for i = 1:m
			field = fields{i};
			value = values{i};
			out.(field) = value;
		end
	end
	
end

