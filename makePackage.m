function makePackage(fname, filter)

    folder = uigetdir(pwd, 'Select a folder where the package is to be stored');
    if isnumeric(folder)
        return;
    end
    
    list = depfun(fname, '-quiet');
    files = {};
    
    for k = 1:numel(list)
        item = list{k};
        if strfind(item, filter)
            files{end+1} = item;
            display(item);
        end
    end

    zipname = [folder filesep fname '.zip'];
    zip(zipname, files);    
end