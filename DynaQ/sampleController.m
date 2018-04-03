function varargout = sampleController(varargin)
% SAMPLECONTROLLER MATLAB code for sampleController.fig
%      SAMPLECONTROLLER, by itself, creates a new SAMPLECONTROLLER or raises the existing
%      singleton*.
%
%      H = SAMPLECONTROLLER returns the handle to a new SAMPLECONTROLLER or the handle to
%      the existing singleton*.
%
%      SAMPLECONTROLLER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMPLECONTROLLER.M with the given input arguments.
%
%      SAMPLECONTROLLER('Property','Value',...) creates a new SAMPLECONTROLLER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sampleController_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sampleController_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sampleController

% Last Modified by GUIDE v2.5 28-Nov-2017 15:33:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sampleController_OpeningFcn, ...
                   'gui_OutputFcn',  @sampleController_OutputFcn, ...
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


% --- Executes just before sampleController is made visible.
function sampleController_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sampleController (see VARARGIN)

% Choose default command line output for sampleController
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sampleController wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sampleController_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ud = get(gcbf,'UserData');
ud
if ud.resetbutton ==0
 ud.resetbutton =1; %turnoff
 ud.pushbutton = 0;
 ud.ambientT = 0;
 ud.ambientH = 0;
 ud.humidity = 0;
set(gcbf,'UserData',ud);
    set_param(bdroot, 'SimulationCommand', 'stop');

end
if ud.resetbutton ==1
    ud.resetbutton = 0; %turnon
    set(gcbf,'UserData',ud);
    set_param(bdroot, 'SimulationCommand', 'start');
end
function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'String');
ud = get(gcbf,'UserData');

ud
if str2double(val)
    val
    ud.ambientT = str2double(val);
end
set(gcbf,'UserData',ud);
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
ud =get(gcbf,'UserData');
if isfield(ud, 'ambientT')       % get ud stored in fig userdata field
    set(hObject,'String', num2str(ud.ambientT));
else
    set(hObject,'String',num2str(0));
end%write value in userdata to field
guidata(hObject, handles);


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'String');
ud = get(gcbf,'UserData');

if str2double(val)
    if val<0
        val = 0
    end
    
    ud.ambientH = str2double(val);
end
set(gcbf,'UserData',ud);
% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
ud =get(gcbf,'UserData'); % get ud stored in fig userdata field
if isfield(ud,'ambientH')
set(hObject,'String', num2str(ud.ambientH)) ;
else
    set(hObject,'String',num2str(0));
end%write value in userdata to field
guidata(hObject, handles);


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'Value');
ud = get(gcbf,'UserData');
ud.pushbutton = val;
set(gcbf,'UserData',ud);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ud = get(gcbf,'UserData')
set(hObject,'Max',50);
set(hObject,'Min',0);
if isfield(ud,'pushbutton')
    set(hObject,'Value',ud.pushbutton)
else
    set(hObject, 'Value',0)
end
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

% --- Executes during object creation, after setting all properties.
% hObject    handle to uipanel3 (see GCBO)

% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
ud.pushbutton = 0 ;
ud.resetbutton = 0 ;
ud.ambientT = 0;
ud.ambientH = 0;
ud.humidity = 0;
set(hObject, 'UserData', ud) ; %store GUI initial values 
%Store figure handle in block userdata - handle can then be used for
%manipulating the figure params
set_param(gcbh,'Userdata',hObject); 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(hObject,'Value');
ud = get(gcbf,'UserData');
ud.humidity = val;
set(gcbf,'UserData',ud);
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
ud = get(gcbf,'UserData')
set(hObject,'Max',100);
set(hObject,'Min',0);
if isfield(ud,'humidity')
    set(hObject,'Value',ud.humidity)
else
    set(hObject, 'Value',0)
end
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
