% Make all fields of the given struct available as local variables in the
% caller's workspace. 
%
% usage: dissolve(someStruct)
% 
function dissolve(someStruct)
    
    fields = fieldnames(someStruct);
    
    for field = fields'
        field = field{:};
        assignin('caller', field, someStruct.(field));
    end
end