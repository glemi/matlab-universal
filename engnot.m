function txt = engnot(number)
	% output a TeX-Formatted string of 
	% a number in scientific notation
	
    ex = floor(log10(number));
    ex = ex - mod(ex,3);
    fr = number.*10^(-ex);
    
    if fr > 10
        txtfr = sprintf('%1.0f', fr);
    else
        txtfr = sprintf('%1.1f', fr);
    end
        
    txtex = sprintf('%d', ex);
    txt = [txtfr '\cdot10^{' txtex '}'];
    
end
