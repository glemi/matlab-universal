% function out = structcat(varargin)
%
% usage: 
%           merged = structmerge(struct1, struct2);
%           merged = structmerge(struct1, struct2, struct3, ...);
%
% Concatenates struct arrays regardless if they have the same fields or
% not. 
%  
function outstruct = structcat(varargin)
	nStructArrays = nargin;
	
    totalLength = 0;
    allfields = {};
    for k = 1:nStructArrays
        instruct = varargin{k};
        lengths(k) = length(instruct);
        allfields = [allfields; fieldnames(instruct)];
    end
    
    totalLength = sum(lengths);
    allfields = unique(allfields);
    
    nFields = length(allfields);
    cellarr = cell(1,2*nFields);
    cellarr(1:2:2*nFields) = allfields;
    
    outstruct = struct(cellarr{:});
    outstruct = repmat(outstruct, 1, totalLength);
    
    index = 0;
    for k = 1:nStructArrays
		structArray = varargin{k};
        
		if ~isempty(structArray)
            fields  = fieldnames(structArray);
            nItems  = length(structArray);
            nFields = length(fields);

            for j = 1:nItems
                index = index + 1;
                structItem = structArray(j);

                for i = 1:nFields
                    field = fields{i};
                    outstruct(index).(field) = structItem.(field);
                end
            end
        end
    end
end

