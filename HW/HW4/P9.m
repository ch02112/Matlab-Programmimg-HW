
function varargout = P9(varargin)
%P9 MATLAB code file for P9.fig
%      P9, by itself, creates a new P9 or raises the existing
%      singleton*.
%
%      H = P9 returns the handle to a new P9 or the handle to
%      the existing singleton*.
%
%      P9('Property','Value',...) creates a new P9 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to P9_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      P9('CALLBACK') and P9('CALLBACK',hObject,...) call the
%      local function named CALLBACK in P9.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P9

% Last Modified by GUIDE v2.5 14-Dec-2017 13:35:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P9_OpeningFcn, ...
                   'gui_OutputFcn',  @P9_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before P9 is made visible.
function P9_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for P9
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.slider,'Enable','off') ;
global highlighsize;
highlighsize = 50;
% UIWAIT makes P9 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = P9_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu
global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;
global jpgcount;

%get the paths popupmenu shows
paths = get(handles.popupmenu,'String');
path = paths{get(handles.popupmenu,'Value')};
if (strcmp(path,'Pop-up Menu'))
    temp=1;
    set(handles.slider,'Enable','off') ;
else
    %show jpg
    jpgnames = dir([path '\*.jpg']);
    [jpgnum , t] = size(jpgnames);
    jpgcount = 1;
    
    if jpgnum < 1
        %set slider bar
        set(handles.slider,'Enable','off') ;
    else
        set(handles.slider,'Enable','on') ;
        pic= imread([path '\' jpgnames(jpgcount).name]);
        axes(handles.aximage);
        %show jpg and set size to 640*480
        [pica picb picc] = size(pic);
            if(picb > 640 || pica > 480)
               pic=imresize(pic,[480 640],'nearest'); 
            else
                tempzeros = zeros(480,640,3,'uint8');
                tempa = ceil((480 - pica)/2);
                tempb = ceil((640 - picb)/2);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,1) = pic(:,:,1);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,2) = pic(:,:,2);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,3) = pic(:,:,3);
                pic = tempzeros;
            end
        imshow(pic);
        stringinfo = ['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgnames(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%'];
        set(handles.imageinfo,'String',stringinfo);
    end
end



% --- Executes during object creation, after setting all properties.
function popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%get the String of popupmenu
folder_name = uigetdir;
current_entries = cellstr(get(handles.popupmenu, 'String'));
% size(current_entries) = n*1
[temps1 temps2] = size(current_entries);
%handle the same path
sameflag = 0;
for i = 1:temps1
   if(strcmp(folder_name,current_entries{i}))
       sameflag = 1;
       break;
   end
end
if sameflag==0
    current_entries{end+1} = folder_name;
    set(handles.popupmenu, 'String', current_entries);
end

% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;
global jpgcount;

%get path
paths = get(handles.popupmenu,'String');
path = paths{get(handles.popupmenu,'Value')};
if (strcmp(path,'Pop-up Menu'))
    temp=1;
else
    jpgnames = dir([path '\*.jpg']);
    [jpgnum , t] = size(jpgnames);
    jpgcount = 1;
    SliderSteparray = [1/(jpgnum-1) , 1/(jpgnum-1) ];
    set(handles.slider,'SliderStep',SliderSteparray);
    
    if jpgnum < 1
        set(handles.slider,'Enable','off') ;
    else
        jpgcount = (get(handles.slider,'Value'))
        jpgcount = round(jpgcount * (jpgnum-1) / 100)+1
        if jpgcount>jpgnum
            jpgcount = jpgcount-1
        end
        pic= imread([path '\' jpgnames(jpgcount).name]);
        axes(handles.aximage);
        [pica picb picc] = size(pic);
            if(picb > 640 || pica > 480)
               pic=imresize(pic,[480 640],'nearest'); 
            else
                tempzeros = zeros(480,640,3,'uint8');
                tempa = ceil((480 - pica)/2);
                tempb = ceil((640 - picb)/2);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,1) = pic(:,:,1);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,2) = pic(:,:,2);
                tempzeros(tempa:tempa+pica-1,tempb:tempb+picb-1,3) = pic(:,:,3);
                pic = tempzeros;
            end
        imshow(pic);
        stringinfo = ['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgnames(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%'];
        set(handles.imageinfo,'String',stringinfo);
    end
end



% --- Executes during object creation, after setting all properties.
function slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in buttonup.
function buttonup_Callback(hObject, eventdata, handles)
% hObject    handle to buttonup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;

%set the point up
pt(2) = pt(2) - 50;
axes(handles.axhighlight);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            axes(handles.aximage);
            imshow(pic);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             axes(handles.aximage);
             imshow(pic);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        axes(handles.aximage);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);






% --- Executes on button press in buttonleft.
function buttonleft_Callback(hObject, eventdata, handles)
% hObject    handle to buttonleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;


pt(1) = pt(1) - 50;
axes(handles.axhighlight);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            axes(handles.aximage);
            imshow(pic);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             axes(handles.aximage);
             imshow(pic);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        axes(handles.aximage);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);


% --- Executes on button press in buttonright.
function buttonright_Callback(hObject, eventdata, handles)
% hObject    handle to buttonright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;


pt(1) = pt(1) + 50;
axes(handles.axhighlight);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            axes(handles.aximage);
            imshow(pic);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             axes(handles.aximage);
             imshow(pic);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        axes(handles.aximage);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);


% --- Executes on button press in buttondown.
function buttondown_Callback(hObject, eventdata, handles)
% hObject    handle to buttondown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;


pt(2) = pt(2) + 50;
axes(handles.axhighlight);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            axes(handles.aximage);
            imshow(pic);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             axes(handles.aximage);
             imshow(pic);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        axes(handles.aximage);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);



% --- Executes on button press in buttonplus.
function buttonplus_Callback(hObject, eventdata, handles)
% hObject    handle to buttonplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;
global jpgcount;

%plus the highlighsize
if highlighsize < 100
    highlighsize = highlighsize + 10;
    axes(handles.axhighlight);
    stringinfo = ['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgnames(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%'];
        set(handles.imageinfo,'String',stringinfo);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            axes(handles.aximage);
            imshow(pic);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             axes(handles.aximage);
             imshow(pic);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        axes(handles.aximage);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);
end


% --- Executes on button press in buttonmin.
function buttonmin_Callback(hObject, eventdata, handles)
% hObject    handle to buttonmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;
global jpgcount;

if highlighsize > 50
    highlighsize = highlighsize - 10;
    axes(handles.axhighlight);
    stringinfo = ['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgnames(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%'];
        set(handles.imageinfo,'String',stringinfo);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            axes(handles.aximage);
            imshow(pic);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             axes(handles.aximage);
             imshow(pic);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        axes(handles.aximage);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);
end


function imageinfo_Callback(hObject, eventdata, handles)
% hObject    handle to imageinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imageinfo as text
%        str2double(get(hObject,'String')) returns contents of imageinfo as a double
global pt;
global pic;
global jpgnames;
global jpgnum;
global jpgfiles;
global highlighsize;
highlighsize = 50;
stringinfo = ['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']
set(handles.imageinfo,'String',stringinfo);


%title(['Picture ',num2str(jpgcount) ,' of ',num2str(jpgnum) ,' (', jpgfiles(jpgcount).name ,') ' ,'640x480 @', num2str((highlighsize / 50)*100),'%']);



% --- Executes during object creation, after setting all properties.
function imageinfo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pt;
global pic;
global jpgnames;
global jpgnum;
global highlighsize;

%get mounse point
rrr = get(gca, 'CurrentPoint');
pt = rrr(1, 1:2)

axes(handles.axhighlight);
        % handle the 
        if (pt(1)<=0 || pt(1)>=640)
            axes(handles.aximage);
            imshow(pic);
            return;
        end
         if pt(2)<=0 || pt(2) >=480
             axes(handles.aximage);
             imshow(pic);
             return;
         end
        if pt(1) < highlighsize+1
            pt(1) = highlighsize+1;
        elseif pt(1) > (640 - highlighsize)
            pt(1) = 640-highlighsize;
        end
        if pt(2) < highlighsize + 1
            pt(2) = highlighsize + 1;
        elseif pt(2) > (480 - highlighsize)
            pt(2) = 480-highlighsize;
        end
        temppic = pic (pt(2)-highlighsize:pt(2)+highlighsize , pt(1)-highlighsize:pt(1)+highlighsize,:);
        temppic = imresize(temppic,[highlighsize*4 highlighsize*4],'nearest');
        imshow(temppic);
        axes(handles.aximage);
        picwithrec = insertShape(pic,'Rectangle',[pt(1)-highlighsize , pt(2)-highlighsize , highlighsize*2 , highlighsize*2],'LineWidth',5);
        imshow(picwithrec);

