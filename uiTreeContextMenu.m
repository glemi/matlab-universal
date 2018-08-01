function jmenu = uiTreeContextMenu(hTree, createFcn)

    if nargin < 2
        createFcn = @testOnMenuCreate;
    end
    
    jmenu = javax.swing.JPopupMenu;
    jTree = handle(hTree.getTree(), 'CallbackProperties');
    set(jTree, 'MousePressedCallback', @(tree, event)callback(tree, event, jmenu, createFcn));
end

function [labels, callbacks] = testOnMenuCreate(tree, node, menu) %#ok
    
    labels{1}     = 'menu item 1';
    callbacks{1}  = @()disp('menu item 1');
    
    labels{2}     = 'menu item 2';
    callbacks{2}  = @()disp('menu item 2');
    
    labels{3}     = 'menu item 3';
    callbacks{3}  = @()disp('menu item 3');
end

function menuClickWrapper(clickFcn, menu, item)
    clickFcn();
    menu.remove(item);
end

function callback(hTree, event, menu, createFcn)
    if event.isMetaDown  % right-click is like a Meta-button
        % Get the clicked node
        clickX = event.getX;
        clickY = event.getY;
        jtree = event.getSource;
        treePath = jtree.getPathForLocation(clickX, clickY);
        
        if isempty(treePath)
            return;
        end
        
        node = treePath.getLastPathComponent;
        hTree.setSelectionPath(treePath)

        [labels, callbacks] = createFcn(hTree, node, menu);

        warning off MATLAB:hg:PossibleDeprecatedJavaSetHGProperty

        menu.removeAll();
        n = length(labels);
        
        if n > 0
            for k = 1:n
                label = labels{k};
                callback = callbacks{k};
                
                if strcmp(label, '-')
                    menu.addSeparator();
                else
                    item = menu.add(label);
                    wrapper = @(~,~)menuClickWrapper(callback, menu, item);
                    set(item, 'ActionPerformedCallback', wrapper);
                end
            end

            warning on MATLAB:hg:PossibleDeprecatedJavaSetHGProperty

            % Display the context menu
            menu.show(jtree, clickX, clickY);
            menu.repaint;
        end
    end
end