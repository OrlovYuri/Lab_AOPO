function varargout = General_window(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @General_window_OpeningFcn, ...
    'gui_OutputFcn',  @General_window_OutputFcn, ...
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
% ����� ���� ������������� - �� �������������!


% --- ����������� ����� ���, ��� ���� ������ �������
function General_window_OpeningFcn(hObject, eventdata, handles, varargin)

% ������� ������������ ������� � ������� ��
timers = timerfind; % ����� �������
if ~isempty(timers) % ���� ���� �������
    delete(timers); % ������� ��� �������
end

set(handles.start_model,'String','���� ������');
set(handles.start_model,'Enable','On');
set(handles.pause_model,'Enable','Off');
set(handles.stop_model,'String','����');
set(handles.stop_model,'Enable','Off');
% ��������� �������� ���������� � �����:
set_param('Last_version_po_STO/KZ_simulation/start_KZ','Value','0');
set_param('Last_version_po_STO/type_fault_BNN','Value','8');
set_param('Last_version_po_STO/type_fault_KITC','Value','1');
set_param('Last_version_po_STO/choose_PO','Value','1');
% ��������� �������� �� ������ � ���� ����� ���� ����������:
set(handles.temper_1,'String',get_param('Last_version_po_STO/temperature1','Value'));
set(handles.temper_2,'String',get_param('Last_version_po_STO/temperature2','Value'));
set(handles.time_cmtrd_full, 'String', string(0.001*str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'))));
set(handles.time_cmtrd, 'String', string(get_param('Last_version_po_STO/Constant1','Value')));
% Choose default command line output for General_window
handles.output = hObject;
% ��������� ����������
set(handles.get_comtrade,'Enable','off');
ah = axes('unit','normalized','position',[0.1 0.27 0.8 0.65]);
bg = imread('img/scheme2.tif');
imagesc(bg);
set(ah,'handlevisibility','off','visible','off');
% �������� �������:
global t;
t = timer(...
    'ExecutionMode', 'fixedRate', ...       % Run timer repeatedly
    'Period', 0.1, ...                        % Initial period is 1 sec.
    'TimerFcn', {@update_display,handles}); % Specify callback function
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = General_window_OutputFcn(hObject, eventdata, handles)

varargout{1} = handles.output;

% ���, ����������� ��������:
function update_display(obj,event,handles)
% �������� ���������� ���������� ��� �� ��������� � ������ ��������:
% - �������� ���������:
global rto_TES_U;
global rto_PS1_U;
global rto_PS2_U;
global rto_PS3_U;
global rto_ES_U;
global rto_PS1;
global rto_PS2;
global rto_PS3;

global rto_S_line;
global rto_I_line;
% - ��������� ������������
global rto_Q1;
global rto_Q2;
global rto_Q1_L2;
global rto_Q2_L2;
global rto_Q1_L3;
global rto_Q2_L3;
global rto_Q_TL2;
global rto_Q_TL3;
% - ���������� ������� �� ���� ��� �������� ���������
global rto_start_step_1
global rto_trip_step_1
global rto_start_step_2
global rto_trip_step_2
global rto_start_step_3
global rto_trip_step_3
global rto_trip_BNN
global rto_trip_KTC
global rto_temp_fault
% - ������ ���������� ������ ��� ������ COMTRADE
global rto_cmtrd_ready;
% - ���������� ��� ������������ ����������� ������� ������������� �
% �������� ��������:
global start_time;
global model_time;
% ����������� ������� �� ������ � ��� ����������� � �������� ��������:
time_model = start_time + seconds(model_time.OutputPort(1).data);
set(handles.model_time,'String',strcat("������� �����:�",string(time_model)));
time_mismatch = datetime('now','Format','HH:mm:ss.SSS') - time_model;
set(handles.time_mismatch,'String',strcat("�����������:�",string(time_mismatch)));
% ����������� �������� ���������� �� ����������:
% - ���������� �� �����:
set(handles.TES_U,'String',sprintf('U ��� = %6.2f ��',rto_TES_U.OutputPort(1).data));
set(handles.PS1_U,'String',sprintf('U ��1 = %6.2f ��',rto_PS1_U.OutputPort(1).data));
set(handles.PS2_U,'String',sprintf('U ��2 = %6.2f ��',rto_PS2_U.OutputPort(1).data));
set(handles.PS3_U,'String',sprintf('U ��3 = %6.2f ��',rto_PS3_U.OutputPort(1).data));
set(handles.ES_U,'String',sprintf('U �� = %5.2f ��',rto_ES_U.OutputPort(1).data));
% - �������� �������� � ��� � �����:
set(handles.PS1_load,'String',sprintf('P ��1 = %5.1f ���',real(rto_PS1.OutputPort(1).data)));
set(handles.PS2_load,'String',sprintf('P ��2 = %5.1f ���',real(rto_PS2.OutputPort(1).data)));
set(handles.PS3_load,'String',sprintf('P ��3 = %5.1f ���',real(rto_PS3.OutputPort(1).data)));
set(handles.Line1_P,'String',sprintf('P �1 = %7.2f ���',real(rto_S_line.OutputPort(1).data)));
set(handles.Line1_Q,'String',sprintf('Q �1 = %7.2f ����',imag(rto_S_line.OutputPort(1).data)));
set(handles.Line1_I,'String',sprintf('I �1 = %7.2f A',rto_I_line.OutputPort(1).data));
% �������� ��������� ��������� �������� ����

if rto_start_step_1.OutputPort(1).data == 1
    set(handles.start_1,'BackgroundColor','[1 0 0]');
else
    set(handles.start_1,'BackgroundColor','[0 0 0]');
end

if rto_trip_step_1.OutputPort(1).data == 1
    set(handles.trip_1,'BackgroundColor','[1 0 0]');
else
    set(handles.trip_1,'BackgroundColor','[0 0 0]');
end

if rto_start_step_2.OutputPort(1).data == 1
    set(handles.start_2,'BackgroundColor','[1 0 0]');
else
    set(handles.start_2,'BackgroundColor','[0 0 0]');
end

if rto_trip_step_2.OutputPort(1).data == 1
    set(handles.trip_2,'BackgroundColor','[1 0 0]');
else
    set(handles.trip_2,'BackgroundColor','[0 0 0]');
end

if rto_start_step_3.OutputPort(1).data == 1
    set(handles.start_3,'BackgroundColor','[1 0 0]');
else
    set(handles.start_3,'BackgroundColor','[0 0 0]');
end

if rto_trip_step_3.OutputPort(1).data == 1
    set(handles.trip_3,'BackgroundColor','[1 0 0]');
else
    set(handles.trip_3,'BackgroundColor','[0 0 0]');
end

if rto_trip_BNN.OutputPort(1).data == 1
    set(handles.trip_BNN,'BackgroundColor','[1 0 0]');
else
    set(handles.trip_BNN,'BackgroundColor','[0 0 0]');
end

if rto_trip_KTC.OutputPort(1).data == 1
    set(handles.trip_KTC,'BackgroundColor','[1 0 0]');
else
    set(handles.trip_KTC,'BackgroundColor','[0 0 0]');
end

if rto_temp_fault.OutputPort(1).data == 1
    set(handles.temp_fault,'BackgroundColor','[1 0 0]');
else
    set(handles.temp_fault,'BackgroundColor','[0 0 0]');
end
% ����������� ��������� ������������
if rto_Q1.OutputPort(1).data
    set(handles.Q1,'BackgroundColor','[1 0 0]');
else
    set(handles.Q1,'BackgroundColor','[0 1 0]');
end
% ----
if rto_Q2.OutputPort(1).data
    set(handles.Q2,'BackgroundColor','[1 0 0]');
else
    set(handles.Q2,'BackgroundColor','[0 1 0]');
end
% ----
if rto_Q1_L2.OutputPort(1).data
    set(handles.Q1_L2,'BackgroundColor','[1 0 0]');
else
    set(handles.Q1_L2,'BackgroundColor','[0 1 0]');
end
% ----
if rto_Q2_L2.OutputPort(1).data
    set(handles.Q2_L2,'BackgroundColor','[1 0 0]');
else
    set(handles.Q2_L2,'BackgroundColor','[0 1 0]');
end
% ----
if rto_Q1_L3.OutputPort(1).data
    set(handles.Q1_L3,'BackgroundColor','[1 0 0]');
else
    set(handles.Q1_L3,'BackgroundColor','[0 1 0]');
end
% ----
if rto_Q2_L3.OutputPort(1).data
    set(handles.Q2_L3,'BackgroundColor','[1 0 0]');
else
    set(handles.Q2_L3,'BackgroundColor','[0 1 0]');
end
% ----
if rto_Q_TL2.OutputPort(1).data
    set(handles.Q_TL2,'BackgroundColor','[1 0 0]');
else
    set(handles.Q_TL2,'BackgroundColor','[0 1 0]');
end
% ----
if rto_Q_TL3.OutputPort(1).data
    set(handles.Q_TL3,'BackgroundColor','[1 0 0]');
else
    set(handles.Q_TL3,'BackgroundColor','[0 1 0]');
end
% ���������� ������ ��� �������� COMTRADE:
if rto_cmtrd_ready.OutputPort(1).data
    set(handles.cmtrd_inform,'String','������ ��� ������ ������������� ������. ������� "�����", ����� "��������� ������������� � ����"');
    set(handles.cmtrd_inform,'BackgroundColor',[0.7 1 0.7]);
else
    set(handles.cmtrd_inform,'String','������ ��� ������ ������������� �� ������');
    set(handles.cmtrd_inform,'BackgroundColor',[1 1 1]);
end
% 31.01.19
% if rto_cmtrd_ready.OutputPort(1).data
%     set(handles.get_comtrade,'Enable','on');
% else
%     set(handles.get_comtrade,'Enable','off');
% end


% �������� ���� ������������� ����������:
function U_regulate_Callback(hObject, eventdata, handles)
U_regulate;

% �������� ���� �������� ����������� � ����� ����������:
function TN_faults_Callback(hObject, eventdata, handles)
TN_faults_control;

% �������� ���� ��������� ��������� ��������:
function power_manage_Callback(hObject, eventdata, handles)
power_add_new;

% ���, ����������� ��� ������� ������:
function start_model_Callback(hObject, eventdata, handles)

if strcmp(get_param('Last_version_po_STO', 'SimulationStatus'),'paused')
    set_param('Last_version_po_STO', 'SimulationCommand', 'continue');
    set(handles.pause_model,'String','�����');
    set(handles.start_model,'String','���� ������');
    set(handles.start_model,'Enable','off');
    set(handles.pause_model,'Enable','on');
    set(handles.stop_model,'Enable','on');
else
    set_param('Last_version_po_STO', 'SimulationCommand', 'start');
    set(handles.start_model,'Enable','off');
    set(handles.pause_model,'Enable','on');
    set(handles.stop_model,'Enable','on');
end
set(hObject,'Enable','Off');
set(handles.cmtrd_inform,'Visible','on');
evalin('base','clear cmtrd_data');
% ������ ��������� ����� ������������� (�.�. ������� �� ������ �� �����
% �������������)
set(handles.time_cmtrd_full,'Enable','off');
% ����� �������� ������� COMTRADE:
switch get_param('Last_version_po_STO/choosing_PO/reset_comtrade','Value')
    case '0'
        set_param('Last_version_po_STO/choosing_PO/reset_comtrade','Value','1');
    case '1'
        set_param('Last_version_po_STO/choosing_PO/reset_comtrade','Value','0');
end
% ����� �������� ������� �������������
switch get_param('Last_version_po_STO/time_reset','Value')
    case '0'
        set_param('Last_version_po_STO/time_reset','Value','1');
    case '1'
        set_param('Last_version_po_STO/time_reset','Value','0');
end
% �������� �������� ��������� ���������� �� ������:
% - ���������� �� �����
global rto_TES_U;
rto_TES_U = get_param('Last_version_po_STO/Gain', 'RuntimeObject');
global rto_PS1_U;
rto_PS1_U = get_param('Last_version_po_STO/Gain1', 'RuntimeObject');
global rto_PS2_U;
rto_PS2_U = get_param('Last_version_po_STO/Gain2', 'RuntimeObject');
global rto_PS3_U;
rto_PS3_U = get_param('Last_version_po_STO/Gain3', 'RuntimeObject');
global rto_ES_U;
rto_ES_U = get_param('Last_version_po_STO/Gain4', 'RuntimeObject');

% - �������� ��������
global rto_PS1;
rto_PS1 = get_param('Last_version_po_STO/Gain11', 'RuntimeObject');
global rto_PS2;
rto_PS2 = get_param('Last_version_po_STO/Gain10', 'RuntimeObject');
global rto_PS3;
rto_PS3 = get_param('Last_version_po_STO/Gain12', 'RuntimeObject');

% - ��� � �������� � �������������� �����
global rto_S_line;
rto_S_line = get_param('Last_version_po_STO/Gain6', 'RuntimeObject');
global rto_I_line;
rto_I_line = get_param('Last_version_po_STO/fourier_filter8/Gain1', 'RuntimeObject');
global t;

% - ��������� ������������
global rto_Q1;
rto_Q1 = get_param('Last_version_po_STO/LogicalOperator1', 'RuntimeObject');
global rto_Q2;
rto_Q2 = get_param('Last_version_po_STO/LogicalOperator3', 'RuntimeObject');
global rto_Q1_L2;
rto_Q1_L2 = get_param('Last_version_po_STO/LogicalOperator2', 'RuntimeObject');
global rto_Q2_L2;
rto_Q2_L2 = get_param('Last_version_po_STO/LogicalOperator6', 'RuntimeObject');
global rto_Q1_L3;
rto_Q1_L3 = get_param('Last_version_po_STO/LogicalOperator4', 'RuntimeObject');
global rto_Q2_L3;
rto_Q2_L3 = get_param('Last_version_po_STO/LogicalOperator9', 'RuntimeObject');
global rto_Q_TL2;
rto_Q_TL2 = get_param('Last_version_po_STO/LogicalOperator7', 'RuntimeObject');
global rto_Q_TL3;
rto_Q_TL3 = get_param('Last_version_po_STO/LogicalOperator8', 'RuntimeObject');

% - ���������� ������� �� ����
global rto_start_step_1
rto_start_step_1 = get_param('Last_version_po_STO/Gain13', 'RuntimeObject');
global rto_trip_step_1
rto_trip_step_1 = get_param('Last_version_po_STO/Gain14', 'RuntimeObject');
global rto_start_step_2
rto_start_step_2 = get_param('Last_version_po_STO/Gain15', 'RuntimeObject');
global rto_trip_step_2
rto_trip_step_2 = get_param('Last_version_po_STO/Gain16', 'RuntimeObject');
global rto_start_step_3
rto_start_step_3 = get_param('Last_version_po_STO/Gain20', 'RuntimeObject');
global rto_trip_step_3
rto_trip_step_3 = get_param('Last_version_po_STO/Gain21', 'RuntimeObject');
global rto_trip_BNN
rto_trip_BNN = get_param('Last_version_po_STO/Gain17', 'RuntimeObject');
global rto_trip_KTC
rto_trip_KTC = get_param('Last_version_po_STO/Gain18', 'RuntimeObject');
global rto_temp_fault
rto_temp_fault = get_param('Last_version_po_STO/Gain19', 'RuntimeObject');

% - ���������� ������ ��� ������ �������������
global rto_cmtrd_ready;
rto_cmtrd_ready = get_param('Last_version_po_STO/Logical6','RuntimeObject');

% - ����� ������ ������������� � �����, ������������� �� ������
global start_time;
start_time = datetime('now','Format','HH:mm:ss.SSS');
global model_time;
model_time = get_param('Last_version_po_STO/Clock','RuntimeObject');
start(t);


% ���, ����������� ��� ���������� ������ �� �����
function pause_model_Callback(hObject, eventdata, handles)
global t;
if strcmp(get_param('Last_version_po_STO', 'SimulationStatus'),'running')
    stop(t);
    set_param('Last_version_po_STO', 'SimulationCommand', 'pause');
    set(handles.start_model,'Enable','on');
    set(handles.start_model,'String','����������');
    set(handles.pause_model,'Enable','off');
    set(handles.get_comtrade,'Enable','on');
    set(handles.cmtrd_inform,'Visible','off');
    %set(handles.get_comtrade,'Enable','off'); 31.01.19
end

% ���, ����������� ��� ��������� ������
function stop_model_Callback(hObject, eventdata, handles)
global t;
stop(t);
set_param('Last_version_po_STO', 'SimulationCommand', 'stop');
set(handles.pause_model,'Enable','off');
set(handles.stop_model,'Enable','off');
set(handles.start_model,'Enable','on');
set(handles.start_model,'String','���� ������');
set(handles.time_cmtrd_full,'Enable','on');
set(hObject,'Enable','Off');
set(handles.get_comtrade,'Enable','off');
set(handles.cmtrd_inform,'Visible','off');

% ������������� �� � ���:
function KZ_APV_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/KZ_simulation/start_KZ','Value','1');

% ����� �� (����� ������������ ��� ��-�������)
function KZ_reset_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/KZ_simulation/start_KZ','Value','0');

% �������� ���� �������� ����������� � ������� �����:
function TT_faults_Callback(hObject, eventdata, handles)
TT_faults_control;

% ���������������� ������� ��������� ������� ����������� �1
function temper_1_Callback(hObject, eventdata, handles)
temp = str2double(get(hObject, 'String'));
if isnan(temp) || ~(mod(temp,1) == 0)
    set(hObject, 'String', get_param('Last_version_po_STO/temperature1','Value'));
    errordlg('����������� ������ ���� ������ � ����� 1','������! ��������� ����');
end

function temper_1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ���������������� ������� ��������� ������� ����������� �2
function temper_2_Callback(hObject, eventdata, handles)
temp = str2double(get(hObject, 'String'));
if isnan(temp) || ~(mod(temp,1) == 0)
    set(hObject, 'String', get_param('Last_version_po_STO/temperature2','Value'));
    errordlg('����������� ������ ���� ������ � ����� 1','������! ��������� ����');
end

function temper_2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ������� ����� ������������ �������������:
function time_cmtrd_full_Callback(hObject, eventdata, handles)
t = str2double(get(hObject, 'String'));
t2 = str2double(get(handles.time_cmtrd,'String'));
if isnan(t) || t < 0 || ~(mod(t,0.1) == 0)
    set(hObject, 'String', string(0.001*str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'))));
    errordlg('����� ������ ���� ������������� ������ � ����� 0.1','������! ��������� ����');
else
    if t < t2
        set(hObject, 'String', string(0.001*str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'))));
        errordlg('����� ������ ���� ������ ������� ����� ����� ��','������! ��������� ����');
    else
        set_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints',string(1000*t));
        set_param('Last_version_po_STO/time_cmtrd','Value',string(t));
    end
end

function time_cmtrd_full_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ������� ������� � ������� ������������ ��������� ������ �� �����
% ������������ �������������:
function time_cmtrd_Callback(hObject, eventdata, handles)
t = str2double(get(hObject, 'String'));
t2 = str2double(get(handles.time_cmtrd_full,'String'));
if isnan(t) || t < 0 || ~(mod(t,0.1) == 0)
    set(hObject, 'String', string(get_param('Last_version_po_STO/Constant1','Value')));
    errordlg('����� ������ ���� ������������� ������ � ����� 0.1','������! ��������� ����');
else
    if t > t2
        set(hObject, 'String', string(get_param('Last_version_po_STO/Constant1','Value')));
        errordlg('����� ������ ���� ������ ������� ������ �������������','������! ��������� ����');
    else
        set_param('Last_version_po_STO/Constant1','Value',string(t));
    end
end

function time_cmtrd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ��������� �������� �������� ����������� � ������
function set_tempers_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/temperature1','Value',get(handles.temper_1,'String'));
set_param('Last_version_po_STO/temperature2','Value',get(handles.temper_2,'String'));


% ���������� ������ �� ����� � �������� �������������:
function get_comtrade_Callback(hObject, eventdata, handles)
%pause_model_Callback(hObject, eventdata, handles); 31.01.19
set(hObject,'Enable','off');
try
    cmtrd_data = evalin('base','cmtrd_data');
    value_number = length(cmtrd_data.Data(:,1));
    value_number = str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'));
    write_comtrade;
    evalin('base','clear cmtrd_data');
    msgbox('������������� ��������');
catch
    errordlg('���-�� ����� �� ���. ���������� ��� ���','���! ������!');
end

% ������ "���" ������������� COMTRADE
function radiobutton1_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','1');

% ������ "���" ������������� COMTRADE
function radiobutton2_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','2');

% ������ "������������ 1 ������� ����" ������������� COMTRADE
function radiobutton3_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','3');

% ���� �������� �������� ������������� COMTRADE
function radiobutton4_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','4');

% ���� �� ������������� COMTRADE
function radiobutton5_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','5');

% ������ "������������ 2 ������� ����" ������������� COMTRADE
function radiobutton6_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','6');

% ������ "���� 1 ������� ����" ������������� COMTRADE
function radiobutton7_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','7');

% ������ "������������� �������� �����������" ������������� COMTRADE
function radiobutton8_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','8');

% ������ "����� ������ �������" ������������� COMTRADE
function radiobutton9_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','9');

% ������ "������������ 3 ������� ����" ������������� COMTRADE
function radiobutton10_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','10');

% ��������� ����� � ����� ������
function turn_on_LEP_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/Constant4','Value','1');
set_param('Last_version_po_STO/Constant5','Value','1');
pause(0.2);
set_param('Last_version_po_STO/Constant4','Value','0');
set_param('Last_version_po_STO/Constant5','Value','0');


% �������� ������� ��� �������� ����
function figure1_CloseRequestFcn(hObject, eventdata, handles)
global t;
if strcmp(get(t, 'Running'), 'on')
    stop(t);
end
% Destroy timer
delete(t)
if strcmp(gcs,'Last_version_po_STO')
    set_param('Last_version_po_STO', 'SimulationCommand', 'stop');
end
delete(hObject);
