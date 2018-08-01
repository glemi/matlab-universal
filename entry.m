function entry(onoff)
	hAx = gca;	
	hLine = findobj(gca, 'type', 'line');
	leginf = get(get(hLine(1), 'Annotation'),'LegendInformation');
	set(leginf, 'IconDisplayStyle', onoff);
end

