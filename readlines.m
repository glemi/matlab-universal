% function lines = readlines( filename )
% 
% Reads a complete text file and returns its contents as a cell array of
% strings.
%
% usage:
%           lines = readlines('textfile.txt');
%
function lines = readlines( filename )
    h = fopen(filename, 'r');
    k = 0;
    while ~feof(h)
        k = k + 1;
        lines{k} = fgetl(h);
    end
    fclose(h);
end

