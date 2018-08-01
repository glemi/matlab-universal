function  baseclasses(someclass)
%Display the type hierarchy of a given class. The argument can
%be either the meta class object of the class or an instance of the class. 
%   usage:
%           baseclasses(?myclass);
%           baseclasses(gca);
%   
%   see also:
%           metaclass
%
    
    if strcmp(class(someclass), 'meta.class')
        meta = someclass;
    else
        meta = metaclass(someclass);
    end
    
    fprintf('\nbase classes of %s: \n', meta.Name);
    recurse(meta, 0);
end

function recurse(meta, level)
    indent = repmat('  ', 1, level);
    
    for super = meta.SuperclassList'
        fprintf('%s %s\n', indent, super.Name);
        
        if ~isempty(super.SuperclassList)
            recurse(super, level+1);
        end
    end
end