% Organize figures by an id string stored in the 'Tag' attribute
% of the figure, rather than using handle numbers. 
% This allows a script to efficiently reuse its figures, and helps avoiding
% conflicts where different parts of a program use the same figure handle
% number for different content. 
% 
% usage: 
%       [hFig, hAx] = fig(id, varargin)
%
% If a figure with the given id does not exist, a new figure is created.
% name-value pairs can be used to supply figure properties in the varargin
% part of the parameter list. Otherwise the existing figure is activated.
% When a new figure is created an empty axes is also added. The axes by
% default have the properties "box on" and "hold all" set by default.
function [hFig, hAx] = fig(id, varargin)
    handles = findobj('Type','figure'); 
    
    tags = get(handles, 'Tag');
    indices = find(strcmp(id, tags));
    
    if isempty(indices)
        hFig = figure('Tag', id, 'Name', id);
        set(hFig, 'NumberTitle', 'off');
        set(hFig, 'Color', get(0,'factoryUicontrolBackgroundColor'));
        hAx = axes; 
        box on; hold all;
        
        if length(varargin) > 1
            set(hFig, varargin{:});
        end
        autodock(hFig, id);
    else
        index = indices(1);
        hFig = handles(index);
        hAx = get(hFig, 'Children');
        figure(hFig);
    end
end

function autodock(hFig, id)
    parts = strsplit(id, ':');
    if length(parts) > 1 && ~isempty(which('setFigDockGroup'))
       group = parts{1}; 
       setFigDockGroup(hFig, group);
       set(hFig, 'WindowStyle', 'docked');
%     else
%         warning('Couldn''t set docking container for new figure: %s', id);
    end
end
