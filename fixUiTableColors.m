function fixUiTableColors(htable)
    jscrollpane = findjobj(htable, 'class', 'UIScrollPane');
	jviewport = jscrollpane.getViewport;
	jtable = jviewport.getView;
    
    color = get(0, 'DefaultUiControlBackgroundColor');
    jcolor = java.awt.Color(color(1), color(2), color(3));
    
    colheader = jtable.getTableHeader();
    %colheader = jscrollpane.getColumnHeader(); % does't work??
    rowheader = jscrollpane.getRowHeader();
    
    jviewport.setBackground(jcolor);
    colheader.setBackground(jcolor);
    rowheader.setBackground(jcolor);
end

