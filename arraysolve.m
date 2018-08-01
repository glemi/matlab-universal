% function varargout = arraysolve(fun, initial, varargin)
% 
% Solver based on MATLAB's built-in fsolve function, which accepts multiple
% parameters (not only one), each of which can be an array or matrix. 
%
% usage:
%       [u v w] = arraysolve(@fun, {x0 y0 z0});
%       [u v w] = arraysolve(@fun, {x0 y0 z0}, fsolve_options);
%   
%   where fun takes and returns three parameters:
%       [u v w] = fun(x, y, z);
%   arraysolve will attempt to find x, y, z such that u, v, w are close to
%   zero. 
%  
% usage of fsolve for comparison:
%       x = fsolve(@fun, x0, options);
% 
% Arraysolve packs all the different parameters into one array before
% passing it to the function to solve. 
%
function varargout = arraysolve(fun, initial, varargin)
    
    [array, sizes] = merge(initial{:});
    %display(array);
    %display(sizes);
    
    function array = wrapper(array)
        data_in = unmerge(array, sizes);
        data_out = fun(data_in{:});
        array = merge(data_out);
    end

    %[array, fval, flag, output, jacobian] = fsolve(@wrapper, data_init);
    if length(varargin) == 0
        array = fsolve(@wrapper, array);
    else
        array = fsolve(@wrapper, array, varargin{:});
    end
    
    final = unmerge(array, sizes);
    varargout = final;
    %display(final);
end

function [array, sizes] = merge(varargin)
    offset = 1;
    array = [1];
    for k = 1:length(varargin)
        var = varargin{k};
        if ~ismatrix(var)
            error('multi_solve: only parameters of two or less dimensions are allowed');
        end
        [n, m] = size(var);
        
        a = offset;
        b = offset + n*m-1;
        
        array(1,a:b) = reshape(var, 1, n*m);
        offset = b+1;  
        sizes(k,:) = size(var);
    end
end

function vars = unmerge(array, sizes)
    b = 0;
    for k = 1:length(sizes)
        n = sizes(k,1);
        m = sizes(k,2);
        a = b+1;
        b = a+n*m-1;
        
        vars{k} = reshape(array(a:b), n, m);
    end
end


