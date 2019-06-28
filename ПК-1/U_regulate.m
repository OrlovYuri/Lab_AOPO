function varargout = U_regulate(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @U_regulate_OpeningFcn, ...
                   'gui_OutputFcn',  @U_regulate_OutputFcn, ...
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

% --- Executes just before U_regulate is made visible.
function U_regulate_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

volt_tes = 0.001*str2double(get_param('Last_version_po_STO/TES','Voltage'));
set(handles.Volt_tes,'String',volt_tes);
volt_es = 0.001*str2double(get_param('Last_version_po_STO/ES','Voltage'));
set(handles.Volt_es,'String',volt_es);

set(handles.v_step, 'String', 0.1);


% --- Outputs from this function are returned to the command line.
function varargout = U_regulate_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


function Volt_tes_Callback(hObject, eventdata, handles)
volt_tes = str2double(get(hObject, 'String'));
if isnan(volt_tes)
    set(handles.Volt_tes,'String',0.001*str2double(get_param('Last_version_po_STO/TES','Voltage')));
    errordlg('Значение должно быть числом!','Ошибка!');
else
    set_param('Last_version_po_STO/TES','Voltage',string(volt_tes*1000));
end

% --- Executes during object creation, after setting all properties.
function Volt_tes_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Volt_es_Callback(hObject, eventdata, handles)
volt_es = str2double(get(hObject, 'String'));
if isnan(volt_es)
    set(handles.Volt_es,'String',0.001*str2double(get_param('Last_version_po_STO/ES','Voltage')));
    errordlg('Значение должно быть числом!','Ошибка!');
else
    set_param('Last_version_po_STO/ES','Voltage',string(volt_es*1000));
end

% --- Executes during object creation, after setting all properties.
function Volt_es_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in v_tes_up.
function v_tes_up_Callback(hObject, eventdata, handles)
volt_tes = str2double(get(handles.v_step,'String'))+str2double(get(handles.Volt_tes,'String'));
set(handles.Volt_tes,'String',volt_tes);
set_param('Last_version_po_STO/TES','Voltage',string(volt_tes*1000));

% --- Executes on button press in v_es_up.
function v_es_up_Callback(hObject, eventdata, handles)
volt_es = str2double(get(handles.v_step,'String'))+str2double(get(handles.Volt_es,'String'));
set(handles.Volt_es,'String',volt_es);
set_param('Last_version_po_STO/ES','Voltage',string(volt_es*1000));

% --- Executes on button press in v_tes_down.
function v_tes_down_Callback(hObject, eventdata, handles)
volt_tes = -str2double(get(handles.v_step,'String'))+str2double(get(handles.Volt_tes,'String'));
set(handles.Volt_tes,'String',volt_tes);
set_param('Last_version_po_STO/TES','Voltage',string(volt_tes*1000));

% --- Executes on button press in v_es_down.
function v_es_down_Callback(hObject, eventdata, handles)
volt_es = -str2double(get(handles.v_step,'String'))+str2double(get(handles.Volt_es,'String'));
set(handles.Volt_es,'String',volt_es);
set_param('Last_version_po_STO/ES','Voltage',string(volt_es*1000));

function v_step_Callback(hObject, eventdata, handles)
step = str2double(get(hObject, 'String'));
if isnan(step) || step < 0
    set(hObject, 'String', 0.1);
    errordlg('Шаг должен быть положительным числом','Ошибка! Повторите ввод');
end

% --- Executes during object creation, after setting all properties.
function v_step_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end