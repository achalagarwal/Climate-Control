function varargout = InpGUI(varargin)
% INPGUI M-file for InpGUI.fig
%      INPGUI, by itself, creates a new INPGUI or raises the existing
%      singleton*.
%
%      H = INPGUI returns the handle to a new INPGUI or the handle to
%      the existing singleton*.
%
%      INPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INPGUI.M with the given input arguments.
%
%      INPGUI('Property','Value',...) creates a new INPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before InpGUI_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to InpGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help InpGUI

% Last Modified by GUIDE v2.5 16-Aug-2011 10:54:23
% Nitin Skandan, 11-Aug-2011 

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @InpGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @InpGUI_OutputFcn, ...
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


% --- Executes just before InpGUI is made visible.
function InpGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to InpGUI (see VARARGIN)

% Choose default command line output for InpGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes InpGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = InpGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbuttn.
function pbuttn_Callback(hObject, eventdata, handles)
% hObject    handle to pbuttn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ud = get(gcbf,'UserData');
ud.radiobutton
if ud.radiobutton == 0
   ud.radiobutton = 1;
end
    
  


function edtxt_Callback(hObject, eventdata, handles)
% hObject    handle to edtxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edtxt as text
%        str2double(get(hObject,'String')) returns contents of edtxt as a double

%---part 2-1 ------%
val = get(hObject,'String'); %get the string in edit field

ud = get(gcbf,'UserData'); % get ud stored in fig userdata field
if str2num(val) %if number is stored in edit field
    ud.ambientT = str2num(val);
else % if its not number
    ud.ambientT = 0; % store 0 
end
set(gcbf,'UserData',ud) ; %update userdata

%----end of part 2-1 ------


% --- Executes during object creation, after setting all properties.
function edtxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-----part2-2---------------% display initial value
ud =get(gcbf,'UserData');
ud% get ud stored in fig userdata field
set(hObject,'String', num2str(ud.ambientT)) ; %write value in userdata to field
guidata(hObject, handles); %update view
%-----part2-2 ends----------------%


% --- Executes on button press in radbuttn.
function radbuttn_Callback(hObject, eventdata, handles)
% hObject    handle to radbuttn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radbuttn
%----part 3-1 ----%
ud = get(gcbf,'UserData') ; %retrieve user data
val = get(hObject,'Value') ; % get new value

%update user data
ud.resetbutton = val ; 
set(gcbf,'UserData', ud) ;

%-------end of part 3-1 -------%

% --- Executes on button press in chkbox.
function chkbox_Callback(hObject, eventdata, handles)
% hObject    handle to chkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chkbox

%----part 4-1 ----%
ud = get(gcbf,'UserData') ; %retrieve user data
val = get(hObject,'Value') ; % get new value

%update user data
ud.chkbox = val ; 
set(gcbf,'UserData', ud) ;

%-------end of part 4-1 -------%


% --- Executes during object creation, after setting all properties.
function radbuttn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radbuttn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%-----part3-2---------------% display initial value
ud =get(gcbf,'UserData'); % get ud stored in fig userdata field
set(hObject,'Value', ud.resetbutton) ; %write value in userdata to field
guidata(hObject, handles); %update view
%-----part2-2 ends----------------%

% --- Executes during object creation, after setting all properties.
function chkbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%-----part4-2---------------% display initial value
ud =get(gcbf,'UserData'); % get ud stored in fig userdata field
set(hObject,'Value', ud.chkbox) ; %write value in userdata to field
guidata(hObject, handles); %update view
%-----part4-2 ends----------------%


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

%---part 1 ---------------------%
%set initial values
ud.pushbutton = 0 ;
ud.radiobutton = 0 ;
ud.ambientT = 0 ; 
ud.ambientH = 0;

set(hObject, 'UserData', ud) ; %store GUI initial values 

%Store figure handle in block userdata - handle can then be used for
%manipulating the figure params
set_param(gcbh,'Userdata',hObject); 

%-----end of part 1 --------------%
