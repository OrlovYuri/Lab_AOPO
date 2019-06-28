function varargout = sets_AOPO(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sets_AOPO_OpeningFcn, ...
                   'gui_OutputFcn',  @sets_AOPO_OutputFcn, ...
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


% --- Executes just before sets_AOPO is made visible.
function sets_AOPO_OpeningFcn(hObject, eventdata, handles, varargin)

set(handles.set_ena_AOPO,'Value',str2double(get_param('Stand_AOPO/set_ena_AOPO','Value')));

set(handles.set_ena_BNN,'Value',str2double(get_param('Stand_AOPO/set_ena_BNN','Value')));
set(handles.set_U_BNN,'String',get_param('Stand_AOPO/set_U_BNN','Value'));
set(handles.set_t_BNN,'String',get_param('Stand_AOPO/set_t_BNN','Value'));

set(handles.set_ena_KTC,'Value',str2double(get_param('Stand_AOPO/set_ena_KTC','Value')));
set(handles.set_I_KTC,'String',get_param('Stand_AOPO/set_I_KTC','Value'));
set(handles.set_t_KTC,'String',get_param('Stand_AOPO/set_t_KTC','Value'));

set(handles.kt,'String',5*str2double(get_param('Stand_AOPO/Kt','Value')));
set(handles.high_limit,'String',get_param('Stand_AOPO/set_high_temp','Value'));
set(handles.low_limit,'String',get_param('Stand_AOPO/set_low_temp','Value'));
set(handles.temp_dif,'String',get_param('Stand_AOPO/set_temp_dif','Value'));

switch get(handles.step_choose,'Value')
    case 1
        set_ena_step = 'Stand_AOPO/set_ena_step1';
        set_ena_dir_step = 'Stand_AOPO/set_ena_dir_step1';
        set_dir_step = 'Stand_AOPO/set_dir_step1';
        set_char_type = 'Stand_AOPO/set_char_type_step1';
        set_t_step = 'Stand_AOPO/set_t_step1';
        set_Iust = 'Stand_AOPO/set_Iust_step1';
        set_Iust1 = 'Stand_AOPO/set_Iust1_step1';
        set_Iust2 = 'Stand_AOPO/set_Iust2_step1';
        set_Iust3 = 'Stand_AOPO/set_Iust3_step1';
        set_t1 = 'Stand_AOPO/set_temp1_step1';
        set_t2 = 'Stand_AOPO/set_temp2_step1';
    case 2
        set_ena_step = 'Stand_AOPO/set_ena_step2';
        set_ena_dir_step = 'Stand_AOPO/set_ena_dir_step2';
        set_dir_step = 'Stand_AOPO/set_dir_step2';
        set_char_type = 'Stand_AOPO/set_char_type_step2';
        set_t_step = 'Stand_AOPO/set_t_step2';
        set_Iust = 'Stand_AOPO/set_Iust_step2';
        set_Iust1 = 'Stand_AOPO/set_Iust1_step2';
        set_Iust2 = 'Stand_AOPO/set_Iust2_step2';
        set_Iust3 = 'Stand_AOPO/set_Iust3_step2';
        set_t1 = 'Stand_AOPO/set_temp1_step2';
        set_t2 = 'Stand_AOPO/set_temp2_step2';
    case 3
        set_ena_step = 'Stand_AOPO/set_ena_step3';
        set_ena_dir_step = 'Stand_AOPO/set_ena_dir_step3';
        set_dir_step = 'Stand_AOPO/set_dir_step3';
        set_char_type = 'Stand_AOPO/set_char_type_step3';
        set_t_step = 'Stand_AOPO/set_t_step3';
        set_Iust = 'Stand_AOPO/set_Iust_step3';
        set_Iust1 = 'Stand_AOPO/set_Iust1_step3';
        set_Iust2 = 'Stand_AOPO/set_Iust2_step3';
        set_Iust3 = 'Stand_AOPO/set_Iust3_step3';
        set_t1 = 'Stand_AOPO/set_temp1_step3';
        set_t2 = 'Stand_AOPO/set_temp2_step3';
end

set(handles.set_ena_step1,'Value',str2double(get_param(set_ena_step,'Value')));
set(handles.set_ena_dir_step1,'Value',str2double(get_param(set_ena_dir_step,'Value')));
switch get_param(set_dir_step,'Value')
    case '0'
        set(handles.reverse_step1,'Value',1);
    case '1'
        set(handles.direct_step1,'Value',1);
end
set(handles.charact_type1,'Value',str2double(get_param(set_char_type,'Value')));
set(handles.set_t_step1,'String',get_param(set_t_step,'Value'));
set(handles.set_Iust_step1,'String',get_param(set_Iust,'Value'));

set(handles.set_i1_step1,'String',get_param(set_Iust1,'Value'));
set(handles.set_i2_step1,'String',get_param(set_Iust2,'Value'));
set(handles.set_i3_step1,'String',get_param(set_Iust3,'Value'));
set(handles.set_t1_step1,'String',get_param(set_t1,'Value'));
set(handles.set_t2_step1,'String',get_param(set_t2,'Value'));

switch get(handles.charact_type1,'Value')
    case 0
        set(handles.set_Iust_step1,'Enable','on');
        set(handles.set_i1_step1,'Enable','off');
        set(handles.set_i2_step1,'Enable','off');
        set(handles.set_i3_step1,'Enable','off');
        set(handles.set_t1_step1,'Enable','off');
        set(handles.set_t2_step1,'Enable','off');
    case 1
        set(handles.set_Iust_step1,'Enable','off');
        set(handles.set_i1_step1,'Enable','on');
        set(handles.set_i2_step1,'Enable','on');
        set(handles.set_i3_step1,'Enable','on');
        set(handles.set_t1_step1,'Enable','on');
        set(handles.set_t2_step1,'Enable','on');
end
ah = axes('unit','normalized','position',[0.02 0.18 0.445 0.3]);
bg = imread('img/charact.tif');
imagesc(bg);
set(ah,'handlevisibility','off','visible','off');
set(handles.popupmenu1,'Visible','off');
% Choose default command line output for sets_AOPO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sets_AOPO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sets_AOPO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% Hints: get(hObject,'String') returns contents of password as text
%        str2double(get(hObject,'String')) returns contents of password as a double


% --- Executes on button press in set_ena_AOPO.
function set_ena_AOPO_Callback(hObject, eventdata, handles)
% hObject    handle to set_ena_AOPO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set_param('Stand_AOPO/set_ena_AOPO','Value','1');
else
    set_param('Stand_AOPO/set_ena_AOPO','Value','0');
end
% Hint: get(hObject,'Value') returns toggle state of set_ena_AOPO

% --- Executes on button press in set_ena_step1.
function set_ena_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_ena_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_ena_step1';
    case 2
        element = 'Stand_AOPO/set_ena_step2';
    case 3
        element = 'Stand_AOPO/set_ena_step3';
end
if get(hObject,'Value')
    set_param(element,'Value','1');
else
    set_param(element,'Value','0');
end
% Hint: get(hObject,'Value') returns toggle state of set_ena_step1


% --- Executes on button press in set_ena_BNN.
function set_ena_BNN_Callback(hObject, eventdata, handles)
% hObject    handle to set_ena_BNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set_param('Stand_AOPO/set_ena_BNN','Value','1');
else
    set_param('Stand_AOPO/set_ena_BNN','Value','0');
end
% Hint: get(hObject,'Value') returns toggle state of set_ena_BNN



function set_U_BNN_Callback(hObject, eventdata, handles)
% hObject    handle to set_U_BNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
U_BNN = str2double(get(hObject, 'String'));
if isnan(U_BNN) || U_BNN < 0 || ~(mod(U_BNN,0.001) == 0)
    set(hObject, 'String', get_param('Stand_AOPO/set_U_BNN','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_U_BNN','Value',string(U_BNN));
end
% Hints: get(hObject,'String') returns contents of set_U_BNN as text
%        str2double(get(hObject,'String')) returns contents of set_U_BNN as a double


% --- Executes during object creation, after setting all properties.
function set_U_BNN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_U_BNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in set_ena_KTC.
function set_ena_KTC_Callback(hObject, eventdata, handles)
% hObject    handle to set_ena_KTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set_param('Stand_AOPO/set_ena_KTC','Value','1');
else
    set_param('Stand_AOPO/set_ena_KTC','Value','0');
end
% Hint: get(hObject,'Value') returns toggle state of set_ena_KTC



function set_I_KTC_Callback(hObject, eventdata, handles)
% hObject    handle to set_I_KTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I_KTC = str2double(get(hObject, 'String'));
if isnan(I_KTC) || I_KTC < 0 || ~(mod(I_KTC,0.001) == 0)
    set(hObject, 'String', get_param('Stand_AOPO/set_I_KTC','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_I_KTC','Value',string(I_KTC));
end
% Hints: get(hObject,'String') returns contents of set_I_KTC as text
%        str2double(get(hObject,'String')) returns contents of set_I_KTC as a double


% --- Executes during object creation, after setting all properties.
function set_I_KTC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_I_KTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_t_KTC_Callback(hObject, eventdata, handles)
% hObject    handle to set_t_KTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_KTC = str2double(get(hObject, 'String'));
if isnan(t_KTC) || t_KTC < 0 || ~(mod(t_KTC,0.001) == 0)
    set(hObject, 'String', get_param('Stand_AOPO/set_t_KTC','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_t_KTC','Value',string(t_KTC));
end
% Hints: get(hObject,'String') returns contents of set_t_KTC as text
%        str2double(get(hObject,'String')) returns contents of set_t_KTC as a double


% --- Executes during object creation, after setting all properties.
function set_t_KTC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_t_KTC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_Iust_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_Iust_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_Iust_step1';
    case 2
        element = 'Stand_AOPO/set_Iust_step2';
    case 3
        element = 'Stand_AOPO/set_Iust_step3';
end
I1_ust = str2double(get(hObject, 'String'));
if isnan(I1_ust) || I1_ust < 0 || ~(mod(I1_ust,0.001) == 0)
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param(element,'Value',string(I1_ust));
end
% Hints: get(hObject,'String') returns contents of set_Iust_step1 as text
%        str2double(get(hObject,'String')) returns contents of set_Iust_step1 as a double


% --- Executes during object creation, after setting all properties.
function set_Iust_step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_Iust_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_t_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_t_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_t_step1';
    case 2
        element = 'Stand_AOPO/set_t_step2';
    case 3
        element = 'Stand_AOPO/set_t_step3';
end
t_step1 = str2double(get(hObject, 'String'));
if isnan(t_step1) || t_step1 < 0 || ~(mod(t_step1,0.001) == 0)
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param(element,'Value',string(t_step1));
end
% Hints: get(hObject,'String') returns contents of set_t_step1 as text
%        str2double(get(hObject,'String')) returns contents of set_t_step1 as a double


% --- Executes during object creation, after setting all properties.
function set_t_step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_t_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in set_ena_dir_step1.
function set_ena_dir_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_ena_dir_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_ena_dir_step1';
    case 2
        element = 'Stand_AOPO/set_ena_dir_step2';
    case 3
        element = 'Stand_AOPO/set_ena_dir_step3';
end
if get(hObject,'Value')
    set_param(element,'Value','1');
else
    set_param(element,'Value','0');
end
% Hint: get(hObject,'Value') returns toggle state of set_ena_dir_step1


% --- Executes on button press in charact_type1.
function charact_type1_Callback(hObject, eventdata, handles)
% hObject    handle to charact_type1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_char_type_step1';
    case 2
        element = 'Stand_AOPO/set_char_type_step2';
    case 3
        element = 'Stand_AOPO/set_char_type_step3';
end
if get(handles.charact_type1,'Value')
    set_param(element,'Value','1');
    set(handles.set_Iust_step1,'Enable','off');
    set(handles.set_i1_step1,'Enable','on');
    set(handles.set_i2_step1,'Enable','on');
    set(handles.set_i3_step1,'Enable','on');
    set(handles.set_t1_step1,'Enable','on');
    set(handles.set_t2_step1,'Enable','on');
else
    set_param(element,'Value','0');
    set(handles.set_Iust_step1,'Enable','on');
    set(handles.set_i1_step1,'Enable','off');
    set(handles.set_i2_step1,'Enable','off');
    set(handles.set_i3_step1,'Enable','off');
    set(handles.set_t1_step1,'Enable','off');
    set(handles.set_t2_step1,'Enable','off');
end
% Hint: get(hObject,'Value') returns toggle state of charact_type1



function set_i1_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_i1_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_Iust1_step1';
        element2 = 'Stand_AOPO/set_Iust2_step1';
    case 2
        element = 'Stand_AOPO/set_Iust1_step2';
        element2 = 'Stand_AOPO/set_Iust2_step2';
    case 3
        element = 'Stand_AOPO/set_Iust1_step3';
        element2 = 'Stand_AOPO/set_Iust2_step3';
end
I1_ust = str2double(get(hObject, 'String'));
if isnan(I1_ust) || I1_ust < 0 || ~(mod(I1_ust,0.001) == 0)
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
elseif I1_ust <= str2double(get_param(element2,'Value'))
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Должно выполняться соотношение I(1) > I(2) > I(3)','Ошибка! Повторите ввод');
else
    set_param(element,'Value',string(I1_ust));
end
% Hints: get(hObject,'String') returns contents of set_i1_step1 as text
%        str2double(get(hObject,'String')) returns contents of set_i1_step1 as a double


% --- Executes during object creation, after setting all properties.
function set_i1_step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_i1_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_i2_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_i2_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_Iust2_step1';
        element2 = 'Stand_AOPO/set_Iust1_step1';
        element3 = 'Stand_AOPO/set_Iust3_step1';
    case 2
        element = 'Stand_AOPO/set_Iust2_step2';
        element2 = 'Stand_AOPO/set_Iust1_step2';
        element3 = 'Stand_AOPO/set_Iust3_step2';
    case 3
        element = 'Stand_AOPO/set_Iust2_step3';
        element2 = 'Stand_AOPO/set_Iust1_step3';
        element3 = 'Stand_AOPO/set_Iust3_step3';
end
I2_ust = str2double(get(hObject, 'String'));
if isnan(I2_ust) || I2_ust < 0 || ~(mod(I2_ust,0.001) == 0)
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
elseif I2_ust <= str2double(get_param(element3,'Value')) || I2_ust >= str2double(get_param(element2,'Value'))
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Должно выполняться соотношение I(1) > I(2) > I(3)','Ошибка! Повторите ввод');
else
    set_param(element,'Value',string(I2_ust));
end
% Hints: get(hObject,'String') returns contents of set_i2_step1 as text
%        str2double(get(hObject,'String')) returns contents of set_i2_step1 as a double


% --- Executes during object creation, after setting all properties.
function set_i2_step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_i2_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_i3_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_i3_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_Iust3_step1';
        element2 = 'Stand_AOPO/set_Iust2_step1';
    case 2
        element = 'Stand_AOPO/set_Iust3_step2';
        element2 = 'Stand_AOPO/set_Iust2_step2';
    case 3
        element = 'Stand_AOPO/set_Iust3_step3';
        element2 = 'Stand_AOPO/set_Iust2_step3';
end
I3_ust = str2double(get(hObject, 'String'));
if isnan(I3_ust) || I3_ust < 0 || ~(mod(I3_ust,0.001) == 0)
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
elseif I3_ust >= str2double(get_param(element2,'Value'))
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Должно выполняться соотношение I(1) > I(2) > I(3)','Ошибка! Повторите ввод');
else
    set_param(element,'Value',string(I3_ust));
end
% Hints: get(hObject,'String') returns contents of set_i3_step1 as text
%        str2double(get(hObject,'String')) returns contents of set_i3_step1 as a double


% --- Executes during object creation, after setting all properties.
function set_i3_step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_i3_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_t1_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_t1_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_temp1_step1';
        element2 = 'Stand_AOPO/set_temp2_step1';
    case 2
        element = 'Stand_AOPO/set_temp1_step2';
        element2 = 'Stand_AOPO/set_temp2_step2';
    case 3
        element = 'Stand_AOPO/set_temp1_step3';
        element2 = 'Stand_AOPO/set_temp2_step3';
end
t1_ust = str2double(get(hObject, 'String'));
if isnan(t1_ust) || t1_ust < 0 || ~(mod(t1_ust,1) == 0)
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Уставка должна быть положительным числом с шагом 1','Ошибка! Повторите ввод');
elseif t1_ust >= str2double(get_param(element2,'Value'))
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Должно выполняться соотношение Т(1) < T(2)','Ошибка! Повторите ввод');
else
    set_param(element,'Value',string(t1_ust));
end
% Hints: get(hObject,'String') returns contents of set_t1_step1 as text
%        str2double(get(hObject,'String')) returns contents of set_t1_step1 as a double


% --- Executes during object creation, after setting all properties.
function set_t1_step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_t1_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_t2_step1_Callback(hObject, eventdata, handles)
% hObject    handle to set_t2_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_temp2_step1';
        element2 = 'Stand_AOPO/set_temp1_step1';
    case 2
        element = 'Stand_AOPO/set_temp2_step2';
        element2 = 'Stand_AOPO/set_temp1_step2';
    case 3
        element = 'Stand_AOPO/set_temp2_step3';
        element2 = 'Stand_AOPO/set_temp1_step3';
end
t2_ust = str2double(get(hObject, 'String'));
if isnan(t2_ust) || t2_ust < 0 || ~(mod(t2_ust,1) == 0)
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Уставка должна быть положительным числом с шагом 1','Ошибка! Повторите ввод');
elseif t2_ust <= str2double(get_param(element2,'Value'))
    set(hObject, 'String', get_param(element,'Value'));
    errordlg('Должно выполняться соотношение Т(1) < T(2)','Ошибка! Повторите ввод');
else
    set_param(element,'Value',string(t2_ust));
end
% Hints: get(hObject,'String') returns contents of set_t2_step1 as text
%        str2double(get(hObject,'String')) returns contents of set_t2_step1 as a double


% --- Executes during object creation, after setting all properties.
function set_t2_step1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_t2_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function set_t_BNN_Callback(hObject, eventdata, handles)
% hObject    handle to text101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_BNN = str2double(get(hObject, 'String'));
if isnan(t_BNN) || t_BNN < 0 || ~(mod(t_BNN,0.001) == 0)
    set(hObject, 'String', get_param('Stand_AOPO/set_t_BNN','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_t_BNN','Value',string(t_BNN));
end
% Hints: get(hObject,'String') returns contents of text101 as text
%        str2double(get(hObject,'String')) returns contents of text101 as a double


% --- Executes during object creation, after setting all properties.
function set_t_BNN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text101 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in direct_step1.
function direct_step1_Callback(hObject, eventdata, handles)
% hObject    handle to direct_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_dir_step1';
    case 2
        element = 'Stand_AOPO/set_dir_step2';
    case 3
        element = 'Stand_AOPO/set_dir_step3';
end
set_param(element,'Value','1');
% Hint: get(hObject,'Value') returns toggle state of direct_step1


% --- Executes on button press in reverse_step1.
function reverse_step1_Callback(hObject, eventdata, handles)
% hObject    handle to reverse_step1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch get(handles.step_choose,'Value')
    case 1
        element = 'Stand_AOPO/set_dir_step1';
    case 2
        element = 'Stand_AOPO/set_dir_step2';
    case 3
        element = 'Stand_AOPO/set_dir_step3';
end
set_param(element,'Value','0');
% Hint: get(hObject,'Value') returns toggle state of reverse_step1


function kt_Callback(hObject, eventdata, handles)
% hObject    handle to kt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Kt = str2double(get(hObject, 'String'));
if isnan(Kt) || Kt < 0
    set(hObject, 'String', 5*str2double(get_param('Stand_AOPO/Kt','Value')));
    errordlg('Уставка должна быть положительным числом','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/Kt','Value',string(Kt/5));
end
% Hints: get(hObject,'String') returns contents of kt as text
%        str2double(get(hObject,'String')) returns contents of kt as a double


% --- Executes during object creation, after setting all properties.
function kt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function high_limit_Callback(hObject, eventdata, handles)
% hObject    handle to high_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject, 'String'));
if isnan(temp) || ~(mod(temp,1) == 0) || temp < str2double(get_param('Stand_AOPO/set_low_temp','Value'))
    set(hObject, 'String', get_param('Stand_AOPO/set_high_temp','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 1 не меньше уставки нижней границы','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_high_temp','Value',string(temp));
end
% Hints: get(hObject,'String') returns contents of high_limit as text
%        str2double(get(hObject,'String')) returns contents of high_limit as a double


% --- Executes during object creation, after setting all properties.
function high_limit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to high_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function low_limit_Callback(hObject, eventdata, handles)
% hObject    handle to low_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp = str2double(get(hObject, 'String'));
if isnan(temp) || ~(mod(temp,1) == 0) || temp > str2double(get_param('Stand_AOPO/set_high_temp','Value'))
    set(hObject, 'String', get_param('Stand_AOPO/set_low_temp','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 1 не больше уставки верхней границы','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_low_temp','Value',string(temp));
end
% Hints: get(hObject,'String') returns contents of low_limit as text
%        str2double(get(hObject,'String')) returns contents of low_limit as a double


% --- Executes during object creation, after setting all properties.
function low_limit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to low_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_dif_Callback(hObject, eventdata, handles)
% hObject    handle to temp_dif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dif = str2double(get(hObject, 'String'));
if isnan(dif) || dif < 0 || ~(mod(dif,1) == 0)
    set(hObject, 'String', get_param('Stand_AOPO/set_temp_dif','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 1','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_temp_dif','Value',string(dif));
end
% Hints: get(hObject,'String') returns contents of temp_dif as text
%        str2double(get(hObject,'String')) returns contents of temp_dif as a double


% --- Executes during object creation, after setting all properties.
function temp_dif_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_dif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% switch get(handles.popupmenu1,'Value')
%     % дефолтные уставки
%     case 1
%         set_param('Stand_AOPO/set_ena_AOPO','Value','1');
%         set(handles.set_ena_AOPO,'Value',1);
%         set_param('Stand_AOPO/set_ena_step1','Value','1');
%         set(handles.set_ena_step1,'Value',1);
%         set_param('Stand_AOPO/set_ena_BNN','Value','1');
%         set(handles.set_ena_BNN,'Value',1);
%         set_param('Stand_AOPO/set_ena_KTC','Value','1');
%         set(handles.set_ena_KTC,'Value',1);
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','0');
%         set(handles.set_ena_dir_step1,'Value',0);
%         set_param('Stand_AOPO/set_dir_step1','Value','1');
%         set(handles.direct_step1,'Value',1);
%         set_param('Stand_AOPO/set_U_BNN','Value','10');
%         set(handles.set_U_BNN,'String','10');
%         set_param('Stand_AOPO/set_t_BNN','Value','0.1');
%         set(handles.set_t_BNN,'String','0.1');
%         set_param('Stand_AOPO/set_I_KTC','Value','1');
%         set(handles.set_I_KTC,'String','1');
%         set_param('Stand_AOPO/set_t_KTC','Value','0.1');
%         set(handles.set_t_KTC,'String','0.1');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%         set_param('Stand_AOPO/set_t_step1','Value','2');
%         set(handles.set_t_step1,'String','2');
%         set_param('Stand_AOPO/set_Iust_step1','Value','90');
%         set(handles.set_Iust_step1,'String','90');
%         set_param('Stand_AOPO/Kt','Value','20');
%         set(handles.kt,'String','100');
%         set_param('Stand_AOPO/set_high_temp','Value','50');
%         set(handles.high_limit,'String','50');
%         set_param('Stand_AOPO/set_low_temp','Value','-40');
%         set(handles.low_limit,'String','-40');
%         set_param('Stand_AOPO/set_temp_dif','Value','3');
%         set(handles.temp_dif,'String','3');
%         % уставки для срабатывания при превышении
%     case 2
%         set_param('Stand_AOPO/set_char_type_step1','Value','0');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%         set_param('Stand_AOPO/set_Iust_step1','Value','90');
%         set(handles.set_Iust_step1,'String','90');
%         set_param('Stand_AOPO/set_t_step1','Value','2');
%         set(handles.set_t_step1,'String','2');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','0');
%         set(handles.set_ena_dir_step1,'Value',0);
%         % уставки несрабатывании при отключении нагрузки
%     case 3
%         set_param('Stand_AOPO/set_Iust_step1','Value','140');
%         set(handles.set_Iust_step1,'String','140');
%         set_param('Stand_AOPO/set_t_step1','Value','2');
%         set(handles.set_t_step1,'String','2');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','0');
%         set(handles.set_ena_dir_step1,'Value',0);
%         set_param('Stand_AOPO/set_char_type_step1','Value','0');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%         % уставки для несрабатывания при КЗ
%     case 4
%         set_param('Stand_AOPO/set_Iust_step1','Value','140');
%         set(handles.set_Iust_step1,'String','140');
%         set_param('Stand_AOPO/set_t_step1','Value','3');
%         set(handles.set_t_step1,'String','3');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','0');
%         set(handles.set_ena_dir_step1,'Value',0);
%         set_param('Stand_AOPO/set_char_type_step1','Value','0');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%         % уставки для срабатывания при перетоке в линию
%     case 5
%         set_param('Stand_AOPO/set_Iust_step1','Value','35');
%         set(handles.set_Iust_step1,'String','35');
%         set_param('Stand_AOPO/set_t_step1','Value','6');
%         set(handles.set_t_step1,'String','6');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','1');
%         set(handles.set_ena_dir_step1,'Value',1);
%         set_param('Stand_AOPO/set_char_type_step1','Value','0');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%         % уставки для срабатывания 2 ступени при БНН
%     case 6
%         set_param('Stand_AOPO/set_Iust_step1','Value','35');
%         set(handles.set_Iust_step1,'String','35');
%         set_param('Stand_AOPO/set_t_step1','Value','2');
%         set(handles.set_t_step1,'String','2');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','1');
%         set(handles.set_ena_dir_step1,'Value',1);
%         set_param('Stand_AOPO/set_char_type_step1','Value','0');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%     % уставки для проверки возврата
%     case 7
%         set_param('Stand_AOPO/set_Iust_step1','Value','120');
%         set(handles.set_Iust_step1,'String','120');
%         set_param('Stand_AOPO/set_t_step1','Value','1');
%         set(handles.set_t_step1,'String','1');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','0');
%         set(handles.set_ena_dir_step1,'Value',0);
%         set_param('Stand_AOPO/set_char_type_step1','Value','0');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%     % уставки для проверки датчиков температуры
%     case 8
%         set_param('Stand_AOPO/set_Iust_step1','Value','120');
%         set(handles.set_Iust_step1,'String','120');
%         set_param('Stand_AOPO/set_t_step1','Value','1');
%         set(handles.set_t_step1,'String','1');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','0');
%         set(handles.set_ena_dir_step1,'Value',0);
%         set_param('Stand_AOPO/set_char_type_step1','Value','0');
%         set(handles.charact_type1,'Value',0);
%         charact_type1_Callback(hObject, eventdata, handles);
%     % уставки для смены группы уставок
%     case 9
%         set_param('Stand_AOPO/set_char_type_step1','Value','1');
%         set(handles.charact_type1,'Value',1);
%         charact_type1_Callback(hObject, eventdata, handles);
%         set_param('Stand_AOPO/set_Iust1_step1','Value','100');
%         set(handles.set_i1_step1,'String','100');
%         set_param('Stand_AOPO/set_Iust2_step1','Value','95');
%         set(handles.set_i2_step1,'String','95')
%         set_param('Stand_AOPO/set_Iust3_step1','Value','90');
%         set(handles.set_i3_step1,'String','90')
%         set_param('Stand_AOPO/set_t_step1','Value','5');
%         set(handles.set_t_step1,'String','5');
%         set_param('Stand_AOPO/set_temp1_step1','Value','20');
%         set(handles.set_t1_step1,'String','20');
%         set_param('Stand_AOPO/set_temp2_step1','Value','40');
%         set(handles.set_t2_step1,'String','40');
%         set_param('Stand_AOPO/set_ena_dir_step1','Value','0');
%         set(handles.set_ena_dir_step1,'Value',0);
% end
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in set_ena_step3.
function set_ena_step3_Callback(hObject, eventdata, handles)
% hObject    handle to set_ena_step3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')
    set_param('Stand_AOPO/set_ena_step3','Value','1');
else
    set_param('Stand_AOPO/set_ena_step3','Value','0');
end
% Hint: get(hObject,'Value') returns toggle state of set_ena_step3



function set_Iust_step3_Callback(hObject, eventdata, handles)
% hObject    handle to set_Iust_step3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I1_ust = str2double(get(hObject, 'String'));
if isnan(I1_ust) || I1_ust < 0 || ~(mod(I1_ust,0.001) == 0)
    set(hObject, 'String', get_param('Stand_AOPO/set_Iust_step3','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_Iust_step3','Value',string(I1_ust));
end
% Hints: get(hObject,'String') returns contents of set_Iust_step3 as text
%        str2double(get(hObject,'String')) returns contents of set_Iust_step3 as a double


% --- Executes during object creation, after setting all properties.
function set_Iust_step3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_Iust_step3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_t_step3_Callback(hObject, eventdata, handles)
% hObject    handle to set_t_step3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_step1 = str2double(get(hObject, 'String'));
if isnan(t_step1) || t_step1 < 0 || ~(mod(t_step1,0.001) == 0)
    set(hObject, 'String', get_param('Stand_AOPO/set_t_step3','Value'));
    errordlg('Уставка должна быть положительным числом с шагом 0.001','Ошибка! Повторите ввод');
else
    set_param('Stand_AOPO/set_t_step3','Value',string(t_step1));
end
% Hints: get(hObject,'String') returns contents of set_t_step3 as text
%        str2double(get(hObject,'String')) returns contents of set_t_step3 as a double


% --- Executes during object creation, after setting all properties.
function set_t_step3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_t_step3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in step_choose.
function step_choose_Callback(hObject, eventdata, handles)
% hObject    handle to step_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% switch get(handles.step_choose,'Value')
%     case 1
%         set(handles.RNM_group,'Title','1 ступень АОПО');
%     case 2
%         set(handles.RNM_group,'Title','2 ступень АОПО');
%     case 3
%         set(handles.RNM_group,'Title','3 ступень АОПО');
% end
switch get(handles.step_choose,'Value')
    case 1
        set(handles.RNM_group,'Title','1 ступень АОПО');
        set_ena_step = 'Stand_AOPO/set_ena_step1';
        set_ena_dir_step = 'Stand_AOPO/set_ena_dir_step1';
        set_dir_step = 'Stand_AOPO/set_dir_step1';
        set_char_type = 'Stand_AOPO/set_char_type_step1';
        set_t_step = 'Stand_AOPO/set_t_step1';
        set_Iust = 'Stand_AOPO/set_Iust_step1';
        set_Iust1 = 'Stand_AOPO/set_Iust1_step1';
        set_Iust2 = 'Stand_AOPO/set_Iust2_step1';
        set_Iust3 = 'Stand_AOPO/set_Iust3_step1';
        set_t1 = 'Stand_AOPO/set_temp1_step1';
        set_t2 = 'Stand_AOPO/set_temp2_step1';
    case 2
        set(handles.RNM_group,'Title','2 ступень АОПО');
        set_ena_step = 'Stand_AOPO/set_ena_step2';
        set_ena_dir_step = 'Stand_AOPO/set_ena_dir_step2';
        set_dir_step = 'Stand_AOPO/set_dir_step2';
        set_char_type = 'Stand_AOPO/set_char_type_step2';
        set_t_step = 'Stand_AOPO/set_t_step2';
        set_Iust = 'Stand_AOPO/set_Iust_step2';
        set_Iust1 = 'Stand_AOPO/set_Iust1_step2';
        set_Iust2 = 'Stand_AOPO/set_Iust2_step2';
        set_Iust3 = 'Stand_AOPO/set_Iust3_step2';
        set_t1 = 'Stand_AOPO/set_temp1_step2';
        set_t2 = 'Stand_AOPO/set_temp2_step2';
    case 3
        set(handles.RNM_group,'Title','3 ступень АОПО');
        set_ena_step = 'Stand_AOPO/set_ena_step3';
        set_ena_dir_step = 'Stand_AOPO/set_ena_dir_step3';
        set_dir_step = 'Stand_AOPO/set_dir_step3';
        set_char_type = 'Stand_AOPO/set_char_type_step3';
        set_t_step = 'Stand_AOPO/set_t_step3';
        set_Iust = 'Stand_AOPO/set_Iust_step3';
        set_Iust1 = 'Stand_AOPO/set_Iust1_step3';
        set_Iust2 = 'Stand_AOPO/set_Iust2_step3';
        set_Iust3 = 'Stand_AOPO/set_Iust3_step3';
        set_t1 = 'Stand_AOPO/set_temp1_step3';
        set_t2 = 'Stand_AOPO/set_temp2_step3';
end

set(handles.set_ena_step1,'Value',str2double(get_param(set_ena_step,'Value')));
set(handles.set_ena_dir_step1,'Value',str2double(get_param(set_ena_dir_step,'Value')));
switch get_param(set_dir_step,'Value')
    case '0'
        set(handles.reverse_step1,'Value',1);
    case '1'
        set(handles.direct_step1,'Value',1);
end
set(handles.charact_type1,'Value',str2double(get_param(set_char_type,'Value')));
set(handles.set_t_step1,'String',get_param(set_t_step,'Value'));
set(handles.set_Iust_step1,'String',get_param(set_Iust,'Value'));

set(handles.set_i1_step1,'String',get_param(set_Iust1,'Value'));
set(handles.set_i2_step1,'String',get_param(set_Iust2,'Value'));
set(handles.set_i3_step1,'String',get_param(set_Iust3,'Value'));
set(handles.set_t1_step1,'String',get_param(set_t1,'Value'));
set(handles.set_t2_step1,'String',get_param(set_t2,'Value'));

switch get(handles.charact_type1,'Value')
    case 0
        set(handles.set_Iust_step1,'Enable','on');
        set(handles.set_i1_step1,'Enable','off');
        set(handles.set_i2_step1,'Enable','off');
        set(handles.set_i3_step1,'Enable','off');
        set(handles.set_t1_step1,'Enable','off');
        set(handles.set_t2_step1,'Enable','off');
    case 1
        set(handles.set_Iust_step1,'Enable','off');
        set(handles.set_i1_step1,'Enable','on');
        set(handles.set_i2_step1,'Enable','on');
        set(handles.set_i3_step1,'Enable','on');
        set(handles.set_t1_step1,'Enable','on');
        set(handles.set_t2_step1,'Enable','on');
end
% Hints: contents = cellstr(get(hObject,'String')) returns step_choose contents as cell array
%        contents{get(hObject,'Value')} returns selected item from step_choose


% --- Executes during object creation, after setting all properties.
function step_choose_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_choose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
