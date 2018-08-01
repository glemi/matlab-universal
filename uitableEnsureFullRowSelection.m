function  uitableEnsureFullRowSelection(htable)
    
    jscrollpane = findjobj(htable, 'class', 'UIScrollPane');
	jviewport = jscrollpane.getViewport;
	jtable = jviewport.getView;
    
    set(jtable, 'MouseClickedCallback', @(par1,par2)callback(par1, par2, jtable, 'Clicked'));
    set(jtable, 'MousePressedCallback', @(par1,par2)callback(par1, par2, jtable, 'Pressed'));
    set(jtable, 'MouseReleasedCallback', @(par1,par2)callback(par1, par2, jtable, 'Released'));
end

function callback(par1, par2, jtable, text)
    
    fprintf('\n\n ************ %s **************** \n', text);
    
    disp(par1)
    disp(par2)
    disp(jtable)
   
end
