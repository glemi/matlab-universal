% assign values to multiple variables
% usage: 
%       [x y z] = assign([a b c]);
function varargout = assign(matrix)
    varargout = num2cell(matrix); 
end