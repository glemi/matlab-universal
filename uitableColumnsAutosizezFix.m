function  uitableColumnsAutosizezFix(htable)
	jscrollpane = findjobj(htable);
	jviewport = jscrollpane.getViewport;
	jtable = jviewport.getView;
	
	jtable.setAutoResizeMode(jtable.AUTO_RESIZE_SUBSEQUENT_COLUMNS);
end

