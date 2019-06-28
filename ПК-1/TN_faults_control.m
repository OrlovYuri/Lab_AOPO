function varargout = TN_faults_control(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TN_faults_control_OpeningFcn, ...
                   'gui_OutputFcn',  @TN_faults_control_OutputFcn, ...
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
%  ŒÕ≈÷  Œƒ¿ »Õ»÷»¿À»«¿÷»» - Õ≈ –≈ƒ¿ “»–Œ¬¿“‹!


% --- ¬€œŒÀÕﬂ≈“—ﬂ œ≈–≈ƒ “≈Ã,  ¿  Œ ÕŒ —“¿Õ≈“ ¬»ƒ»Ã€Ã
function TN_faults_control_OpeningFcn(hObject, eventdata, handles, varargin)
switch get_param('Last_version_po_STO/type_fault_BNN','Value')
    case '1'
        set(handles.radiobutton2,'Value',1);
    case '2'
        set(handles.radiobutton3,'Value',1);
    case '3'
        set(handles.radiobutton4,'Value',1);
    case '4'
        set(handles.radiobutton5,'Value',1);
    case '5'
        set(handles.radiobutton6,'Value',1);
    case '6'
        set(handles.radiobutton7,'Value',1);
    case '7'
        set(handles.radiobutton8,'Value',1);
    case '8'
        set(handles.radiobutton1,'Value',1);
end
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% --- Outputs from this function are returned to the command line.
function varargout = TN_faults_control_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','8');

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','1');

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','2');

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','3');

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','4');

% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','5');

% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','6');

% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_BNN','Value','7');
