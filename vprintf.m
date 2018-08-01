function vprintf(level, varargin)
    global verbosity_level;
    if level <= verbosity_level
        disp([repmat(9, [1 level]) sprintf(varargin{:})]);
    end
end
