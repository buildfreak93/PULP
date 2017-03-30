function varargout = start_window(varargin)
% START_WINDOW MATLAB code for start_window.fig
%      START_WINDOW, by itself, creates a new START_WINDOW or raises the existing
%      singleton*.
%
%      H = START_WINDOW returns the handle to a new START_WINDOW or the handle to
%      the existing singleton*.
%
%      START_WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in START_WINDOW.M with the given input arguments.
%
%      START_WINDOW('Property','Value',...) creates a new START_WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before start_window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to start_window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help start_window

% Last Modified by GUIDE v2.5 27-Mar-2017 17:24:48

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_window_OpeningFcn, ...
                   'gui_OutputFcn',  @start_window_OutputFcn, ...
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


% --- Executes just before start_window is made visible.
function start_window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to start_window (see VARARGIN)

% Choose default command line output for start_window
handles.output = hObject;
axes(handles.axes1);
imshow('PULP.PNG');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes start_window wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.



function varargout = start_window_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function MRN_Callback(hObject, eventdata, handles)
% hObject    handle to MRN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MRN as text
%        str2double(get(hObject,'String')) returns contents of MRN as a double


% --- Executes during object creation, after setting all properties.
function MRN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MRN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pt_name_Callback(hObject, eventdata, handles)
% hObject    handle to pt_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pt_name as text
%        str2double(get(hObject,'String')) returns contents of pt_name as a double


% --- Executes during object creation, after setting all properties.
function pt_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pt_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in left.
function left_Callback(hObject, eventdata, handles)
% hObject    handle to left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of left
 
% --- Executes on button press in right.
function right_Callback(hObject, eventdata, handles)
% hObject    handle to right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of right

% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

MRN = get(handles.MRN, 'String');
pt_name = get(handles.pt_name, 'String');
 
b = get(handles.right,'Value');
  if b==1
      which_eye = 2;
      disp('right');
  end
 a = get(handles.left,'Value');
 if a==1
     which_eye=1;
     disp('left');
 end
 
assignin('base', 'MRN', MRN);
assignin('base', 'pt_name', pt_name);
assignin('base', 'which_eye', which_eye);

disp(which_eye);
disp(MRN);
disp(pt_name);

close;
test_window;
