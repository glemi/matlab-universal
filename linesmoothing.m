function linesmoothing(action)
    h = findall(gca, 'Type', 'Line');

    switch action
        case 'on'
            set(0,'DefaultLineLineSmoothing','on');
            set(0,'DefaultPatchLineSmoothing','on');
            set(h, 'LineSmoothing', 'on');
            
        case 'off'
            set(0,'DefaultLineLineSmoothing','off');
            set(0,'DefaultPatchLineSmoothing','off');
            set(h, 'LineSmoothing', 'off');
    end
end

