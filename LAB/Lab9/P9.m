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

% Last Modified by GUIDE v2.5 06-Dec-2017 15:13:45

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
global pt;
pt = [0  0];
global pic;
pic = 0;

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

function aximage_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(gcf, 'WindowButtonDownFcn', 'pt = setpt();' );
pt




% --- Executes on selection change in popupmenu.
function popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu
paths = get(handles.popupmenu,'String');
path = paths{get(handles.popupmenu,'Value')};
if (strcmp(path,'Pop-up Menu'))
    temp=1;
else
    jpgnames = dir([path '\*.jpg']);
    [jpgnum , t] = size(jpgnames);
    jpgcount = 1;
    
    if jpgnum < 1
        set(handles.slider,'Enable','off') ;
    else
        set(handles.slider,'Enable','on') ;
        pic= imread([path '\' jpgnames(jpgcount).name]);
        axes(handles.aximage);
        imshow(pic);
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
folder_name = uigetdir;
current_entries = cellstr(get(handles.popupmenu, 'String'));
% size(current_entries) = n*1
current_entries{end+1} = folder_name;
set(handles.popupmenu, 'String', current_entries);

% --- Executes on slider movement.
function slider_Callback(hObject, eventdata, handles)
% hObject    handle to slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
paths = get(handles.popupmenu,'String');
path = paths{get(handles.popupmenu,'Value')};
if (strcmp(path,'Pop-up Menu'))
    temp=1;
else
    jpgnames = dir([path '\*.jpg']);
    [jpgnum , t] = size(jpgnames);
    jpgcount = 1;
    SliderSteparray = [0.01 0.01];
    set(handles.slider,'SliderStep',SliderSteparray);
    
    if jpgnum < 1
        set(handles.slider,'Enable','off') ;
    else
        jpgcount = (get(handles.slider,'Value'))
        jpgcount = ceil(mod(jpgcount,jpgnum)+1)
        if jpgcount>jpgnum
            jpgcount = jpgcount-1
        end
        pic= imread([path '\' jpgnames(jpgcount).name]);
        axes(handles.aximage);
        imshow(pic);
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
pt
pic

% --- Executes on button press in buttonleft.
function buttonleft_Callback(hObject, eventdata, handles)
% hObject    handle to buttonleft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonright.
function buttonright_Callback(hObject, eventdata, handles)
% hObject    handle to buttonright (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttondown.
function buttondown_Callback(hObject, eventdata, handles)
% hObject    handle to buttondown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonplus.
function buttonplus_Callback(hObject, eventdata, handles)
% hObject    handle to buttonplus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonmin.
function buttonmin_Callback(hObject, eventdata, handles)
% hObject    handle to buttonmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function imageinfo_Callback(hObject, eventdata, handles)
% hObject    handle to imageinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imageinfo as text
%        str2double(get(hObject,'String')) returns contents of imageinfo as a double


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
