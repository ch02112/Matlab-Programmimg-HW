%0316324 ªL­Ê¥þ
function varargout = p4_0316324(varargin)
% P4_0316324 MATLAB code for p4_0316324.fig
%      P4_0316324, by itself, creates a new P4_0316324 or raises the existing
%      singleton*.
%
%      H = P4_0316324 returns the handle to a new P4_0316324 or the handle to
%      the existing singleton*.
%
%      P4_0316324('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P4_0316324.M with the given input arguments.
%
%      P4_0316324('Property','Value',...) creates a new P4_0316324 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before p4_0316324_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to p4_0316324_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help p4_0316324

% Last Modified by GUIDE v2.5 23-May-2017 12:18:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @p4_0316324_OpeningFcn, ...
                   'gui_OutputFcn',  @p4_0316324_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
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


% --- Executes just before p4_0316324 is made visible.
function p4_0316324_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to p4_0316324 (see VARARGIN)

% Choose default command line output for p4_0316324
handles.output = hObject;
%ori_image represent the unchanged image(zoom=1)
handles.ori_image=0;    
handles.zoom=1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes p4_0316324 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = p4_0316324_OutputFcn(~, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider_h_Callback(hObject, eventdata, handles)
% hObject    handle to slider_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.axes.XLim=[hObject.Value hObject.Value+handles.axes.XLim(2)-handles.axes.XLim(1)]; 
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_v_Callback(hObject, eventdata, handles)
% hObject    handle to slider_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
handles.axes.YLim=[hObject.Max-hObject.Value hObject.Max-hObject.Value+handles.axes.YLim(2)-handles.axes.YLim(1)];
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%import a picture.  I didn't do file checking.
[filename, pathname]=uigetfile('*.*');

if(filename~=0)
    %some things should be initialized 
    handles.pushbutton_plus.Enable='on';        
    handles.pushbutton_minus.Enable='on';       
    handles.text_zoom.String=['Zoom: 1x'];    
    handles.zoom=1;    
    handles.slider_v.Enable='off';      
    handles.slider_h.Enable='off';
    
    %read and show image
    handles.ori_image=imread([pathname filename]);
    imshow(handles.ori_image);
    axis on;
    
    %change XYLim to fit the ratio I want(3:4)
    if(handles.axes.YLim(2)/handles.axes.XLim(2)>3/4)        
        handles.axes.XLim(2)=handles.axes.YLim(2)*4/3;
    elseif((handles.axes.YLim(2)/handles.axes.XLim(2)<3/4))
        handles.axes.YLim(2)=handles.axes.XLim(2)*3/4;
    end
    
    %to avoid a weird error described below.
    %use both sliders in zoom16x, then one of sliders may have a little space which shouldnt appear in zoom1x.
    handles.axes.XLim(2)=handles.axes.XLim(2)+0.5;
    handles.axes.YLim(2)=handles.axes.YLim(2)+0.5;
     
end
guidata(hObject,handles);

% --- Executes on button press in pushbutton_plus.
function pushbutton_plus_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%zoom double, check if zoom reach its limit 
%this part in pushbutton_plus and pushbutton_minus are different 
handles.zoom=handles.zoom*2;
if(handles.zoom==16)
    handles.pushbutton_plus.Enable='off';
end
handles.pushbutton_minus.Enable='on';
        
%update text_zoom
handles.text_zoom.String=['Zoom: ' num2str(handles.zoom) 'x']; 

%save axis width and height.  It only changes when user read new image. 
Xlen=handles.axes.XLim(2)-handles.axes.XLim(1);
Ylen=handles.axes.YLim(2)-handles.axes.YLim(1);

%compute new XYLim.  Goal:center axes of picture will not change  
%part1
%this part in pushbutton_plus and pushbutton_minus are different 
Xcenter=(handles.axes.XLim(2)+handles.axes.XLim(1))/2*2;%plus%
Ycenter=(handles.axes.YLim(2)+handles.axes.YLim(1))/2*2;%plus%

%part2. to avoid showing white color part that is not from image
if(Xcenter-Xlen/2<0)
    newXLim=[0 Xlen];
elseif(Xcenter+Xlen/2>size(handles.ori_image,2)*handles.zoom)
    if(size(handles.ori_image,2)*handles.zoom-Xlen<0)
        newXLim=[0 Xlen];
    else
        newXLim=[size(handles.ori_image,2)*handles.zoom-Xlen size(handles.ori_image,2)*handles.zoom];
    end
else
    newXLim=[Xcenter-Xlen/2 Xcenter+Xlen/2];
end

if(Ycenter-Ylen/2<0)
    newYLim=[0 Ylen];
elseif(Ycenter+Ylen/2>size(handles.ori_image,1)*handles.zoom)
    if(size(handles.ori_image,1)*handles.zoom-Ylen<0)
        newYLim=[0 Ylen];
    else
        newYLim=[size(handles.ori_image,1)*handles.zoom-Ylen size(handles.ori_image,1)*handles.zoom];
    end
else
    newYLim=[Ycenter-Ylen/2 Ycenter+Ylen/2];
end

%update image
newimage=imresize(handles.ori_image,handles.zoom,'nearest');
imshow(newimage);
axis on;
handles.axes.XLim=newXLim;
handles.axes.YLim=newYLim;

%update slider_v (vertical)
if(size(newimage,1)<=Ylen)
    handles.slider_v.Enable='off';
else 
    handles.slider_v.Enable='on';
    handles.slider_v.Max=size(newimage,1)-Ylen;
    vstep=0.2*Ylen/handles.slider_v.Max;
    if(vstep>1)
        vstep=1;
    end
    handles.slider_v.SliderStep=[vstep vstep*10];
end

%update slider_h (horizental)
if(size(newimage,2)<=Xlen)
    handles.slider_h.Enable='off';
else 
    handles.slider_h.Enable='on';
    handles.slider_h.Max=size(newimage,2)-Xlen;
    hstep=0.2*Xlen/handles.slider_h.Max;
    if(hstep>1)
        hstep=1;
    end
    handles.slider_h.SliderStep=[hstep hstep*10];
end

%update slider value
handles.slider_h.Value=handles.axes.XLim(1);
handles.slider_v.Value=handles.slider_v.Max-handles.axes.YLim(1);

guidata(hObject,handles);

% --- Executes on button press in pushbutton_minus.
function pushbutton_minus_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)'

%zoom is divide by 2 ,check if zoom reach its limit
%this part in pushbutton_plus and pushbutton_minus are different 
handles.zoom=handles.zoom/2;
if(handles.zoom<0.03)
    handles.pushbutton_minus.Enable='off';
end
handles.pushbutton_plus.Enable='on';
       
        
%update text_zoom
handles.text_zoom.String=['Zoom: ' num2str(handles.zoom) 'x']; 

%save axis width and height.  It only changes when user read new image. 
Xlen=handles.axes.XLim(2)-handles.axes.XLim(1);
Ylen=handles.axes.YLim(2)-handles.axes.YLim(1);

%compute new XYLim.  Goal:center axes of picture will not change  
%part1
%this part in pushbutton_plus and pushbutton_minus are different 
Xcenter=(handles.axes.XLim(2)+handles.axes.XLim(1))/2/2;%minus%
Ycenter=(handles.axes.YLim(2)+handles.axes.YLim(1))/2/2;%minus%

%part2. to avoid showing white color part that is not from image
if(Xcenter-Xlen/2<0)
    newXLim=[0 Xlen];
elseif(Xcenter+Xlen/2>size(handles.ori_image,2)*handles.zoom)
    if(size(handles.ori_image,2)*handles.zoom-Xlen<0)
        newXLim=[0 Xlen];
    else
        newXLim=[size(handles.ori_image,2)*handles.zoom-Xlen size(handles.ori_image,2)*handles.zoom];
    end
else
    newXLim=[Xcenter-Xlen/2 Xcenter+Xlen/2];
end

if(Ycenter-Ylen/2<0)
    newYLim=[0 Ylen];
elseif(Ycenter+Ylen/2>size(handles.ori_image,1)*handles.zoom)
    if(size(handles.ori_image,1)*handles.zoom-Ylen<0)
        newYLim=[0 Ylen];
    else
        newYLim=[size(handles.ori_image,1)*handles.zoom-Ylen size(handles.ori_image,1)*handles.zoom];
    end
else
    newYLim=[Ycenter-Ylen/2 Ycenter+Ylen/2];
end

%update image
newimage=imresize(handles.ori_image,handles.zoom,'nearest');
imshow(newimage);
axis on;
handles.axes.XLim=newXLim;
handles.axes.YLim=newYLim;

%update slider_v (vertical)
if(size(newimage,1)<=Ylen)
    handles.slider_v.Enable='off';
else 
    handles.slider_v.Enable='on';
    handles.slider_v.Max=size(newimage,1)-Ylen;
    vstep=0.2*Ylen/handles.slider_v.Max;
    if(vstep>1)
        vstep=1;
    end
    handles.slider_v.SliderStep=[vstep vstep*10];
end

%update slider_h (horizental)
if(size(newimage,2)<=Xlen)
    handles.slider_h.Enable='off';
else 
    handles.slider_h.Enable='on';
    handles.slider_h.Max=size(newimage,2)-Xlen;
    hstep=0.2*Xlen/handles.slider_h.Max;
    if(hstep>1)
        hstep=1;
    end
    handles.slider_h.SliderStep=[hstep hstep*10];
end

%update slider value
handles.slider_h.Value=handles.axes.XLim(1);
handles.slider_v.Value=handles.slider_v.Max-handles.axes.YLim(1);

guidata(hObject,handles);
