function chartab(m)
    
    n = 32;
    if nargin < 1
        m = 32;
    end
    fprintf('\n\n\n');

    
    for k = n:n:n*m
        h = k+(0:n-1);
        fprintf('%4s  ', num2str(k));
        disp(char(h));
        fprintf([char(8) '\n']); 
    end
end

