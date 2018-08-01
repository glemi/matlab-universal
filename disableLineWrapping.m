function disableLineWrapping(hEdit)
    jScrollPane = findjobj(hEdit);
    
    if ~isempty(jScrollPane)
        jViewPort = jScrollPane.getViewport;
        jEditbox = jViewPort.getComponent(0);
        jEditbox.setWrapping(false); 

        jScrollPane.setHorizontalScrollBarPolicy(30);
    end
end

