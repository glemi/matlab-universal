function [jtable, jviewport] = getUiTableJavaObject(htable)

	jscrollpane = findjobj(htable, 'class', 'UIScrollPane');
	jviewport = jscrollpane.getViewport;
	jtable = jviewport.getView;
    
    % color = java.awt.Color(0.8314, 0.8157, 0.7843)
    % header = view.getTableHeader
    % header.setBackground(color)
    % color = java.awt.Color(0.8314, 0.8157, 0.7843)
    % view.setBackground(color)
    
    %assignin('base', 'scrollpane', jscrollpane); % for debug purpose
end

