function addtoPPT(PPT_filename, operations)
%
if isempty(PPT_filename);
  [fname, fpath] = uiputfile('*.ppt');
  if fpath == 0; return; end
  PPT_filename = fullfile(fpath,fname);
else
  [fpath,fname,fext] = fileparts(PPT_filename);
  if isempty(fpath); fpath = pwd; end
  if isempty(fext); fext = '.ppt'; end
  PPT_filename = fullfile(fpath,[fname,fext]);
end
% Start an ActiveX session with PowerPoint:
printf('opening ActiveX')
ppt = actxserver('PowerPoint.Application');
if ~exist(PPT_filename,'file');
  printf('generating new file')
  pptdraft=sprintf('%s\\empty.ppt', pwd);
  [fpath,fname,fext] = fileparts(pptdraft);
  filespec_pptdraft = fullfile(fpath,[fname,fext]);
  op = invoke(ppt.Presentations,'Open',filespec_pptdraft,[],[],0);
  printf('Creating from file %s...', filespec_pptdraft);
else  % Open existing presentation:
  printf('opening existing file |%s| exists = %d', PPT_filename, exist(PPT_filename,'file'));
  op = invoke(ppt.Presentations,'Open',PPT_filename,[],[],0);
  printf('Opening file %s...', PPT_filename);
end
printf('getting height and width')
% Get height and width of slide:
slideHeight = op.PageSetup.SlideHeight; %assume title makes 10% of the page
slideWidth = op.PageSetup.SlideWidth;

for ii=1:size(operations,1)
  slide_count = get(op.Slides,'Count');
  which_slide = operations{ii,1};
  printf('slide_count = %d   which_slide = %d', slide_count, which_slide);
  if (which_slide <= 0)
    slide_count = int32(double(slide_count)+1);
    which_slide = slide_count;
    invoke(op.Slides,'Add',slide_count,12); % add empty page
  elseif (which_slide > slide_count)
    while (which_slide > slide_count)
      slide_count = int32(double(slide_count)+1);
      invoke(op.Slides,'Add',slide_count,12); % add empty page
    end;
  end;
  thisSlide = op.Slides.Item(which_slide);
  thisOperation = operations{ii,2};
  payload = operations{ii,3};
  location = operations{ii,4};
  if (strcmpi(thisOperation, 'text'))
    boxTitle = invoke(thisSlide.Shapes,'AddTextbox',1, location(1), location(2), location(3), location(4));
    textRange = boxTitle.TextFrame.TextRange;
    set(textRange,'Text', payload);  % Write the title
    if (size(operations,2)>4)
      options = operations{ii,5};
      for (jj=1:length(options))
        if strcmpi(options{jj}, 'AlignLeft')
          set(textRange.ParagraphFormat,'Alignment',1)% Set text alignment to center
        elseif strcmpi(options{jj}, 'AlignCenter')
          set(textRange.ParagraphFormat,'Alignment',2)% Set text alignment to center
        elseif strcmpi(options{jj}, 'AlignRight')
          set(textRange.ParagraphFormat,'Alignment',2)% Set text alignment to center
        elseif strcmpi(options{jj}, 'Bold')
          set(textRange.Font,'Bold',true);
        elseif strcmpi(options{jj}, 'Italic')
          set(textRange.Font,'Italic',true);
        elseif (strfind(options{jj}, 'FontSize=')==1)
          q = options{jj}; q = q([(length('FontSize=')+1):(length(q))]);
          set(textRange.Font,'Size',str2num(q));
        elseif (strfind(options{jj}, 'FontColor=')==1)
          q = options{jj}; q = q([(length('FontColor=')+1):(length(q))]);
          RGB_triplet = str2num(q);
          if (length(RGB_triplet)==3)
            value = (255*RGB_triplet(1)) + bitshift(round(255*RGB_triplet(2)),8) + bitshift(round(255*RGB_triplet(3)),16);
          else
            value = RGB_triplet;
          end;
          set(textRange.Font.Color,'RGB',value);
        end;
      end;
    end;
  elseif (strcmpi(thisOperation, 'image'))
    imgSize = size(imread(payload));
    if (location(3) < 0)
      imgHeight = location(4);
      imgWidth = imgHeight/(imgSize(1)/imgSize(2));
    elseif (location(4) < 0)
      imgWidth = location(3);
      imgHeight = imgWidth*(imgSize(1)/imgSize(2));
    else
      imgWidth = location(3);
      imgHeight = location(4);
    end;
    %printf('Placing image %s   with size %d x %d', payload, imgWidth, imgHeight);
    boxImage = thisSlide.Shapes.AddPicture(payload, 0, 1, location(1), location(2), imgWidth, imgHeight);
  end;
end;

if ~exist(PPT_filename,'file')
  % Save file as new:
  invoke(op,'SaveAs',PPT_filename,1);
else
  % Save existing file:
  invoke(op,'Save');
end
% Close the presentation window:
invoke(op,'Close');
% Quit PowerPoint
invoke(ppt,'Quit');

return
