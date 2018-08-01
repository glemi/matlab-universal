function txt = scinot(number)
	% output a TeX-Formatted string of 
	% a number in scientific notation
	
    ex = fix(log10(number));
    fr = number.*10.^(-ex);
    
    txtfr = sprintf('%1.1f', fr);
    txtex = sprintf('%d', ex);
    
%     if(fr - 1 > 1e2)
        txt = [txtfr '\cdot10^{' txtex '}'];
%     else
%         txt = ['10^{' txtex '}'];
%     end
end
