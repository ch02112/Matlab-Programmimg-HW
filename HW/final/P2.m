function varargout = P2(varargin)
% P2 MATLAB code for P2.fig
%      P2, by itself, creates a new P2 or raises the existing
%      singleton*.
%
%      H = P2 returns the handle to a new P2 or the handle to
%      the existing singleton*.
%
%      P2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in P2.M with the given input arguments.
%
%      P2('Property','Value',...) creates a new P2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before P2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to P2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help P2

% Last Modified by GUIDE v2.5 05-Jan-2018 21:10:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @P2_OpeningFcn, ...
                   'gui_OutputFcn',  @P2_OutputFcn, ...
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


% --- Executes just before P2 is made visible.
function P2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to P2 (see VARARGIN)

% Choose default command line output for P2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes P2 wait for user response (see UIRESUME)
% uiwait(handles.axes1);


% --- Outputs from this function are returned to the command line.
function varargout = P2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
num = get(handles.listbox1,'Value');
tempuserdata = get(handles.listbox1,'UserData');
if num >1
    set(handles.x1, 'String', tempuserdata(num-1,1));
    set(handles.y1, 'String', tempuserdata(num-1,2));
    set(handles.x2, 'String', tempuserdata(num-1,3));
    set(handles.y2, 'String', tempuserdata(num-1,4));
    axes(handles.figure1);
    cla(handles.figure1);
    axis([0, 10, 0, 10]);
    [s1 s2] = size(tempuserdata);
    for i =1:s1
        if i == num-1
             rectangle('Position',[tempuserdata(i,1)  tempuserdata(i,2)  tempuserdata(i,3)-tempuserdata(i,1)  tempuserdata(i,4)-tempuserdata(i,2)],'EdgeColor','r');
        else
             rectangle('Position',[tempuserdata(i,1)  tempuserdata(i,2)  tempuserdata(i,3)-tempuserdata(i,1)  tempuserdata(i,4)-tempuserdata(i,2)]);
        end
    end
end




% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

string= '(';
                           string=strcat(string,get(handles.x1, 'String'));
                           string(end+1) = ',';
                           string=strcat(string,get(handles.y1, 'String'));
                           string(end+1) = ')';
                           string(end+1) = '-';
                           string(end+1) = '(';
                            string=strcat(string,get(handles.x2, 'String'));
                            string(end+1) = ',';
                            string=strcat(string,get(handles.y2, 'String'));
                           string(end+1) = ')';
current_entries = cellstr(get(handles.listbox1, 'String'));

[temps1 temps2] = size(current_entries);
current_entries{end+1} = string;
set(handles.listbox1, 'String', current_entries);
tempuserdata = get(handles.listbox1, 'UserData');
if numel(tempuserdata) == 0
    tempuserdata = [str2num(get(handles.x1, 'String')) str2num(get(handles.y1, 'String')) str2num(get(handles.x2, 'String')) str2num(get(handles.y2, 'String'))];
else
    tempuserdata(end+1,:) = [str2num(get(handles.x1, 'String')) str2num(get(handles.y1, 'String')) str2num(get(handles.x2, 'String')) str2num(get(handles.y2, 'String'))];
end
set(handles.listbox1, 'UserData', tempuserdata);

[s1 s2] = size(tempuserdata);
set(handles.listbox1,'Value',s1+1);
axes(handles.figure1);
cla(handles.figure1);
axis([0, 10, 0, 10]);

for i =1:s1-1
    rectangle('Position',[tempuserdata(i,1)  tempuserdata(i,2)  tempuserdata(i,3)-tempuserdata(i,1)  tempuserdata(i,4)-tempuserdata(i,2)]);
end
rectangle('Position',[tempuserdata(end,1)  tempuserdata(end,2)  tempuserdata(end,3)-tempuserdata(end,1)  tempuserdata(end,4)-tempuserdata(end,2)],'EdgeColor','r');





% --- Executes on button press in change.
function change_Callback(hObject, eventdata, handles)
% hObject    handle to change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

string= '(';
                           string=strcat(string,get(handles.x1, 'String'));
                           string(end+1) = ',';
                           string=strcat(string,get(handles.y1, 'String'));
                           string(end+1) = ')';
                           string(end+1) = '-';
                           string(end+1) = '(';
                            string=strcat(string,get(handles.x2, 'String'));
                            string(end+1) = ',';
                            string=strcat(string,get(handles.y2, 'String'));
                           string(end+1) = ')';
                           
num = get(handles.listbox1,'Value');
current_entries = cellstr(get(handles.listbox1, 'String'));

[temps1 temps2] = size(current_entries);
if num > 1
    current_entries{num} = string;
    set(handles.listbox1, 'String', current_entries);
    tempuserdata = get(handles.listbox1, 'UserData');
    
    tempuserdata(num-1,:) = [str2num(get(handles.x1, 'String')) str2num(get(handles.y1, 'String')) str2num(get(handles.x2, 'String')) str2num(get(handles.y2, 'String'))]
    set(handles.listbox1, 'UserData', tempuserdata);
    [s1 s2] = size(tempuserdata);
    axes(handles.figure1);
    cla(handles.figure1);
    axis([0, 10, 0, 10]);
    for i =1:s1
        if i == num-1
             rectangle('Position',[tempuserdata(i,1)  tempuserdata(i,2)  tempuserdata(i,3)-tempuserdata(i,1)  tempuserdata(i,4)-tempuserdata(i,2)],'EdgeColor','r');
        else
             rectangle('Position',[tempuserdata(i,1)  tempuserdata(i,2)  tempuserdata(i,3)-tempuserdata(i,1)  tempuserdata(i,4)-tempuserdata(i,2)]);
        end
    end
end


% --- Executes on button press in delete.
function delete_Callback(hObject, eventdata, handles)
% hObject    handle to delete (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num = get(handles.listbox1,'Value');
current_entries = cellstr(get(handles.listbox1, 'String'))

[temps1 temps2] = size(current_entries);
if num > 1
    current_entries = {current_entries{1:num-1} current_entries{num+1:end}};
    set(handles.listbox1, 'String', current_entries');
    tempuserdata = get(handles.listbox1, 'UserData');
    
    tempuserdata(num-1,:) = [];
    set(handles.listbox1, 'UserData', tempuserdata);
    [s1 s2] = size(tempuserdata);
    num = get(handles.listbox1,'Value');
    axes(handles.figure1);
    cla(handles.figure1);
    axis([0, 10, 0, 10]);
    for i =1:s1
        if i == num-1
             rectangle('Position',[tempuserdata(i,1)  tempuserdata(i,2)  tempuserdata(i,3)-tempuserdata(i,1)  tempuserdata(i,4)-tempuserdata(i,2)],'EdgeColor','r');
        else
             rectangle('Position',[tempuserdata(i,1)  tempuserdata(i,2)  tempuserdata(i,3)-tempuserdata(i,1)  tempuserdata(i,4)-tempuserdata(i,2)]);
        end
    end
end




function x1_Callback(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x1 as text
%        str2double(get(hObject,'String')) returns contents of x1 as a double


% --- Executes during object creation, after setting all properties.
function x1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y1_Callback(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y1 as text
%        str2double(get(hObject,'String')) returns contents of y1 as a double


% --- Executes during object creation, after setting all properties.
function y1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function x2_Callback(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x2 as text
%        str2double(get(hObject,'String')) returns contents of x2 as a double


% --- Executes during object creation, after setting all properties.
function x2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y2_Callback(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y2 as text
%        str2double(get(hObject,'String')) returns contents of y2 as a double


% --- Executes during object creation, after setting all properties.
function y2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
