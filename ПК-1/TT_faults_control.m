function varargout = TT_faults_control(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TT_faults_control_OpeningFcn, ...
                   'gui_OutputFcn',  @TT_faults_control_OutputFcn, ...
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
% ÊÎÍÅÖ ÊÎÄÀ ÈÍÈÖÈÀËÈÇÀÖÈÈ - ÍÅ ĞÅÄÀÊÒÈĞÎÂÀÒÜ!


% --- ÂÛÏÎËÍßÅÒÑß ÏÅĞÅÄ ÒÅÌ, ÊÀÊ ÎÊÍÎ ÑÒÀÍÅÒ ÂÈÄÈÌÛÌ
function TT_faults_control_OpeningFcn(hObject, eventdata, handles, varargin)
switch get_param('Last_version_po_STO/type_fault_KITC','Value')
    case '1'
        set(handles.radiobutton1,'Value',1)
    case '2'
        set(handles.radiobutton2,'Value',1)
    case '3'
        set(handles.radiobutton3,'Value',1)
end
        
        
% Choose default command line output for TT_faults_control
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = TT_faults_control_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_KITC','Value','1');

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_KITC','Value','2');

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/type_fault_KITC','Value','3');
