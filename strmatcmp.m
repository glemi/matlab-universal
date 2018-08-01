% function tf = strmatcmp(s1, s2)
%
% Compare two cell cell arrays of strings, element by element. The result
% is a matrix with size m x n where m and n are the number of elements in
% s1 and s2 respectively. 
%
% usage: 
%           tf = strmatcmp(s1, s2);
%           
%           % get all elements in s1 that appear in s2:
%           indices = any(tf, 1);
%           
% see also:
%           strcmp, strcmpi
% 
function tf = strmatcmp(s1, s2)
    n = length(s1);
	m = length(s2);
    
    s1 = cellstr(s1); s1 = s1(:)';
    s2 = cellstr(s2); s2 = s2(:);
    
    S1 = repmat(s1, m, 1);
    S2 = repmat(s2, 1, n);
    
    tf = strcmp(S1, S2);
end

