function varargout = power_add_new(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @power_add_new_OpeningFcn, ...
                   'gui_OutputFcn',  @power_add_new_OutputFcn, ...
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
% КОНЕЦ КОДА ИНИЦИАЛИЗАЦИИ - НЕ РЕДАКТИРОВАТЬ!


% --- Executes just before power_add_new is made visible.
function power_add_new_OpeningFcn(hObject, eventdata, handles, varargin)

load_PS1 = 0.1*str2double(get_param('Last_version_po_STO/PS_1_load/power_control_PS1/cnst_change','Value'));
set(handles.Load_PS1,'String',load_PS1);
load_PS2 = 0.1*str2double(get_param('Last_version_po_STO/PS_2_load/power_control_PS2/cnst_change','Value'));
set(handles.Load_PS2,'String',load_PS2);
load_PS3 = 0.1*str2double(get_param('Last_version_po_STO/PS_3_load/power_control_PS3/cnst_change','Value'));
set(handles.Load_PS3,'String',load_PS3);

set(handles.step_load, 'String', 0.1);
set(handles.mode_1,'Value',1);

switch get_param('Last_version_po_STO/PS_2_load/power_control_PS2/mode','Value')
    case '1'
        set(handles.mode_1,'Value',1);
    case '2'
        set(handles.mode_2,'Value',1);
    case '3'
        set(handles.mode_3,'Value',1);
    case '4'
        set(handles.radiobutton4,'Value',1);
end
% Choose default command line output for power_add_new
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = power_add_new_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;



function step_load_Callback(hObject, eventdata, handles)
step = str2double(get(hObject, 'String'));
if isnan(step) || step < 0 || ~(mod(step,0.1) == 0)
    set(hObject, 'String', 0.1);
    errordlg('Шаг должен быть положительным числом, кратным 0.1','Ошибка! Повторите ввод');
end

% --- Executes during object creation, after setting all properties.
function step_load_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Load_PS1_Callback(hObject, eventdata, handles)
load_PS1 = str2double(get(hObject, 'String'));
if isnan(load_PS1) || load_PS1 < 0 || ~(mod(load_PS1,0.1) == 0)
    set(handles.Load_PS1,'String',0.1*str2double(get_param('Last_version_po_STO/PS_1_load/power_control_PS1/cnst_change','Value')));
    errordlg('Значение должно быть положительным числом, кратным 0.1!','Ошибка!');
else
    set_param('Last_version_po_STO/PS_1_load/power_control_PS1/cnst_change','Value',string(load_PS1*10));
end

% --- Executes during object creation, after setting all properties.
function Load_PS1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Load_PS2_Callback(hObject, eventdata, handles)
load_PS2 = str2double(get(hObject, 'String'));
if isnan(load_PS2) || load_PS2 < 0 || ~(mod(load_PS2,0.1) == 0)
    set(handles.Load_PS2,'String',0.1*str2double(get_param('Last_version_po_STO/PS_2_load/power_control_PS2/cnst_change','Value')));
    errordlg('Значение должно быть положительным числом, кратным 0.1!','Ошибка!');
else
    set_param('Last_version_po_STO/PS_2_load/power_control_PS2/cnst_change','Value',string(load_PS2*10));
end

% --- Executes during object creation, after setting all properties.
function Load_PS2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Load_PS3_Callback(hObject, eventdata, handles)
load_PS3 = str2double(get(hObject, 'String'));
if isnan(load_PS3) || load_PS3 < 0 || ~(mod(load_PS3,0.1) == 0)
    set(handles.Load_PS3,'String',0.1*str2double(get_param('Last_version_po_STO/PS_3_load/power_control_PS3/cnst_change','Value')));
    errordlg('Значение должно быть положительным числом, кратным 0.1!','Ошибка!');
else
    set_param('Last_version_po_STO/PS_3_load/power_control_PS3/cnst_change','Value',string(load_PS3*10));
end

% --- Executes during object creation, after setting all properties.
function Load_PS3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Load_PS1_up.
function Load_PS1_up_Callback(hObject, eventdata, handles)
load_PS1 = str2double(get(handles.step_load,'String'))+str2double(get(handles.Load_PS1,'String'));
set(handles.Load_PS1,'String',load_PS1);
set_param('Last_version_po_STO/PS_1_load/power_control_PS1/cnst_change','Value',string(load_PS1*10));

% --- Executes on button press in Load_PS1_down.
function Load_PS1_down_Callback(hObject, eventdata, handles)
load_PS1 = -str2double(get(handles.step_load,'String'))+str2double(get(handles.Load_PS1,'String'));
set(handles.Load_PS1,'String',load_PS1);
set_param('Last_version_po_STO/PS_1_load/power_control_PS1/cnst_change','Value',string(load_PS1*10));

% --- Executes on button press in Load_PS2_up.
function Load_PS2_up_Callback(hObject, eventdata, handles)
load_PS2 = str2double(get(handles.step_load,'String'))+str2double(get(handles.Load_PS2,'String'));
set(handles.Load_PS2,'String',load_PS2);
set_param('Last_version_po_STO/PS_2_load/power_control_PS2/cnst_change','Value',string(load_PS2*10));

% --- Executes on button press in Load_PS2_down.
function Load_PS2_down_Callback(hObject, eventdata, handles)
load_PS2 = -str2double(get(handles.step_load,'String'))+str2double(get(handles.Load_PS2,'String'));
set(handles.Load_PS2,'String',load_PS2);
set_param('Last_version_po_STO/PS_2_load/power_control_PS2/cnst_change','Value',string(load_PS2*10));

% --- Executes on button press in Load_PS3_up.
function Load_PS3_up_Callback(hObject, eventdata, handles)
load_PS3 = str2double(get(handles.step_load,'String'))+str2double(get(handles.Load_PS3,'String'));
set(handles.Load_PS3,'String',load_PS3);
set_param('Last_version_po_STO/PS_3_load/power_control_PS3/cnst_change','Value',string(load_PS3*10));

% --- Executes on button press in Load_PS3_down.
function Load_PS3_down_Callback(hObject, eventdata, handles)
load_PS3 = str2double(get(handles.step_load,'String'))+str2double(get(handles.Load_PS3,'String'));
set(handles.Load_PS3,'String',load_PS3);
set_param('Last_version_po_STO/PS_3_load/power_control_PS3/cnst_change','Value',string(load_PS3*10));

% --- Executes on button press in default_powers.
function default_powers_Callback(hObject, eventdata, handles)
set(handles.Load_PS1,'String','550.9');
set(handles.Load_PS2,'String','475.8');
set(handles.Load_PS3,'String','23.8');
set_param('Last_version_po_STO/PS_1_load/power_control_PS1/cnst_change','Value','5509');
set_param('Last_version_po_STO/PS_2_load/power_control_PS2/cnst_change','Value','4758');
set_param('Last_version_po_STO/PS_3_load/power_control_PS3/cnst_change','Value','238');


% --- Executes on button press in mode_1.
function mode_1_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/PS_2_load/power_control_PS2/mode','Value','1');
set_param('Last_version_po_STO/PS_1_load/power_control_PS1/mode','Value','0');
% Hint: get(hObject,'Value') returns toggle state of mode_1


% --- Executes on button press in mode_2.
function mode_2_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/PS_2_load/power_control_PS2/mode','Value','2');
set_param('Last_version_po_STO/PS_1_load/power_control_PS1/mode','Value','0');
% Hint: get(hObject,'Value') returns toggle state of mode_2


% --- Executes on button press in mode_3.
function mode_3_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/PS_2_load/power_control_PS2/mode','Value','3');
set_param('Last_version_po_STO/PS_1_load/power_control_PS1/mode','Value','1');
% Hint: get(hObject,'Value') returns toggle state of mode_3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_param('Last_version_po_STO/PS_2_load/power_control_PS2/mode','Value','4');
set_param('Last_version_po_STO/PS_1_load/power_control_PS1/mode','Value','0');
% Hint: get(hObject,'Value') returns toggle state of radiobutton4
