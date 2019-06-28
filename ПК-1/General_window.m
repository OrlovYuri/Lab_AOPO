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
% ÊÎÍÅÖ ÊÎÄÀ ÈÍÈÖÈÀËÈÇÀÖÈÈ - ÍÅ ĞÅÄÀÊÒÈĞÎÂÀÒÜ!


% --- ÂÛÏÎËÍßÅÒÑß ÏÅĞÅÄ ÒÅÌ, ÊÀÊ ÎÊÍÎ ÑÒÀÍÅÒ ÂÈÄÈÌÛÌ
function General_window_OpeningFcn(hObject, eventdata, handles, varargin)

% ÍÀÕÎÄÈÌ ÑÓÙÅÑÒÂÓŞÙÈÅ ÒÀÉÌÅĞÛ È ÓÄÀËßÅÌ ÈÕ
timers = timerfind; % íàéòè òàéìåğû
if ~isempty(timers) % åñëè åñòü òàéìåğû
    delete(timers); % óäàëèòü âñå òàéìåğû
end

set(handles.start_model,'String','Ïóñê ìîäåëè');
set(handles.start_model,'Enable','On');
set(handles.pause_model,'Enable','Off');
set(handles.stop_model,'String','Ñòîï');
set(handles.stop_model,'Enable','Off');
% ÓÑÒÀÍÎÂÊÀ ÈÑÕÎÄÍÛÕ ÏÀĞÀÌÅÒĞÎÂ Â ÑÕÅÌÅ:
set_param('Last_version_po_STO/KZ_simulation/start_KZ','Value','0');
set_param('Last_version_po_STO/type_fault_BNN','Value','8');
set_param('Last_version_po_STO/type_fault_KITC','Value','1');
set_param('Last_version_po_STO/choose_PO','Value','1');
% ÓÑÒÀÍÎÂÊÀ ÇÍÀ×ÅÍÈÉ ÈÇ ÌÎÄÅËÈ Â ÏÎËß ÂÂÎÄÀ ÎÊÍÀ ÈÍÒÅĞÔÅÉÑÀ:
set(handles.temper_1,'String',get_param('Last_version_po_STO/temperature1','Value'));
set(handles.temper_2,'String',get_param('Last_version_po_STO/temperature2','Value'));
set(handles.time_cmtrd_full, 'String', string(0.001*str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'))));
set(handles.time_cmtrd, 'String', string(get_param('Last_version_po_STO/Constant1','Value')));
% Choose default command line output for General_window
handles.output = hObject;
% ÄÎÁÀÂËßÅÌ ÌÍÅÌÎÑÕÅÌÓ
set(handles.get_comtrade,'Enable','off');
ah = axes('unit','normalized','position',[0.1 0.27 0.8 0.65]);
bg = imread('img/scheme2.tif');
imagesc(bg);
set(ah,'handlevisibility','off','visible','off');
% ÑÎÇÄÀÍÈÅ ÒÀÉÌÅĞÀ:
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

% ÊÎÄ, ÈÑÏÎËÍßÅÌÛÉ ÒÀÉÌÅĞÎÌ:
function update_display(obj,event,handles)
% ÑÎÇÄÀÍÈÅ ÃËÎÁÀËÜÍÛÕ ÏÅĞÅÌÅÍÍÛÕ ÄËß ÈÕ ÂÈÄÈÌÎÑÒÈ Â ÄĞÓÃÈÕ ÔÓÍÊÖÈßÕ:
% - ĞÅÆÈÌÍÛÅ ÏÀĞÀÌÅÒĞÛ:
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
% - ÏÎËÎÆÅÍÈß ÂÛÊËŞ×ÀÒÅËÅÉ
global rto_Q1;
global rto_Q2;
global rto_Q1_L2;
global rto_Q2_L2;
global rto_Q1_L3;
global rto_Q2_L3;
global rto_Q_TL2;
global rto_Q_TL3;
% - ÄÈÑÊĞÅÒÍÛÅ ÑÈÃÍÀËÛ ÎÒ ÀÎÏÎ ÄËß ÑÂÅÒÎÂÎÉ ÈÍÄÈÊÀÖÈÈ
global rto_start_step_1
global rto_trip_step_1
global rto_start_step_2
global rto_trip_step_2
global rto_start_step_3
global rto_trip_step_3
global rto_trip_BNN
global rto_trip_KTC
global rto_temp_fault
% - ÑÈÃÍÀË ÃÎÒÎÂÍÎÑÒÈ ÄÀÍÍÛÕ ÄËß ÇÀÏÈÑÈ COMTRADE
global rto_cmtrd_ready;
% - ÏÅĞÅÌÅÍÍÛÅ ÄËß ÂÈÇÓÀËÈÇÀÖÈÈ ĞÀÑÕÎÆÄÅÍÈß ÂĞÅÌÅÍÈ ÌÎÄÅËÈĞÎÂÀÍÈß Ñ
% ĞÅÀËÜÍÛÌ ÂĞÅÌÅÍÅÌ:
global start_time;
global model_time;
% ÎÒÎÁĞÀÆÅÍÈÅ ÂĞÅÌÅÍÈ ÏÎ ÌÎÄÅËÈ È ÅÃÎ ĞÀÑÕÎÆÄÅÍÈß Ñ ĞÅÀËÜÍÛÌ ÂĞÅÌÅÍÅÌ:
time_model = start_time + seconds(model_time.OutputPort(1).data);
set(handles.model_time,'String',strcat("Òåêóùåå âğåìÿ: ",string(time_model)));
time_mismatch = datetime('now','Format','HH:mm:ss.SSS') - time_model;
set(handles.time_mismatch,'String',strcat("Ğàñõîæäåíèå: ",string(time_mismatch)));
% ÎÒÎÁĞÀÆÅÍÈÅ ĞÅÆÈÌÍÛÕ ÏÀĞÀÌÅÒĞÎÂ ÍÀ ÌÍÅÌÎÑÕÅÌÅ:
% - ÍÀÏĞßÆÅÍÈß ÍÀ ØÈÍÀÕ:
set(handles.TES_U,'String',sprintf('U ÒİÑ = %6.2f êÂ',rto_TES_U.OutputPort(1).data));
set(handles.PS1_U,'String',sprintf('U ÏÑ1 = %6.2f êÂ',rto_PS1_U.OutputPort(1).data));
set(handles.PS2_U,'String',sprintf('U ÏÑ2 = %6.2f êÂ',rto_PS2_U.OutputPort(1).data));
set(handles.PS3_U,'String',sprintf('U ÏÑ3 = %6.2f êÂ',rto_PS3_U.OutputPort(1).data));
set(handles.ES_U,'String',sprintf('U İÑ = %5.2f êÂ',rto_ES_U.OutputPort(1).data));
% - ÌÎÙÍÎÑÒÈ ÍÀÃĞÓÇÎÊ È ÒÎÊ Â ËÈÍÈÈ:
set(handles.PS1_load,'String',sprintf('P ÏÑ1 = %5.1f ÌÂò',real(rto_PS1.OutputPort(1).data)));
set(handles.PS2_load,'String',sprintf('P ÏÑ2 = %5.1f ÌÂò',real(rto_PS2.OutputPort(1).data)));
set(handles.PS3_load,'String',sprintf('P ÏÑ3 = %5.1f ÌÂò',real(rto_PS3.OutputPort(1).data)));
set(handles.Line1_P,'String',sprintf('P Ë1 = %7.2f ÌÂò',real(rto_S_line.OutputPort(1).data)));
set(handles.Line1_Q,'String',sprintf('Q Ë1 = %7.2f ÌÂÀğ',imag(rto_S_line.OutputPort(1).data)));
set(handles.Line1_I,'String',sprintf('I Ë1 = %7.2f A',rto_I_line.OutputPort(1).data));
% ÑÂÅÒÎÂÀß ÈÍÄÈÊÀÖÈß ÄÈÑĞÅÒÍÛÕ ÑÈÃÍÀËÎÂ ÀÎÏÎ

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
% ÎÒÎÁĞÀÆÅÍÈÅ ÏÎËÎÆÅÍÈß ÂÛÊËŞ×ÀÒÅËÅÉ
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
% ÃÎÒÎÂÍÎÑÒÜ ÄÀÍÍÛÕ ÄËß ÑÎÇÄÀÍÈß COMTRADE:
if rto_cmtrd_ready.OutputPort(1).data
    set(handles.cmtrd_inform,'String','Äàííûå äëÿ çàïèñè îñöèëëîãğàììû ãîòîâû. Íàæìèòå "Ïàóçà", çàòåì "Ñîõğàíèòü îñöèëëîãğàììû â ôàéë"');
    set(handles.cmtrd_inform,'BackgroundColor',[0.7 1 0.7]);
else
    set(handles.cmtrd_inform,'String','Äàííûå äëÿ çàïèñè îñöèëëîãğàììû íå ãîòîâû');
    set(handles.cmtrd_inform,'BackgroundColor',[1 1 1]);
end
% 31.01.19
% if rto_cmtrd_ready.OutputPort(1).data
%     set(handles.get_comtrade,'Enable','on');
% else
%     set(handles.get_comtrade,'Enable','off');
% end


% ÎÒÊĞÛÒÈÅ ÎÊÍÀ ĞÅÃÓËÈĞÎÂÀÍÈß ÍÀÏĞßÆÅÍÈß:
function U_regulate_Callback(hObject, eventdata, handles)
U_regulate;

% ÎÒÊĞÛÒÈÅ ÎÊÍÀ ÈÌÈÒÀÖÈÈ ÏÎÂĞÅÆÄÅÍÈÉ Â ÖÅÏßÕ ÍÀÏĞßÆÅÍÈß:
function TN_faults_Callback(hObject, eventdata, handles)
TN_faults_control;

% ÎÒÊĞÛÒÈÅ ÎÊÍÀ ÈÇÌÅÍÅÍÈß ÌÎÙÍÎÑÒÅÉ ÍÀÃĞÓÇÎÊ:
function power_manage_Callback(hObject, eventdata, handles)
power_add_new;

% ÊÎÄ, ÈÑÏÎËßÍÅÌÛÉ ÏĞÈ ÇÀÏÓÑÊÅ ÌÎÄÅËÈ:
function start_model_Callback(hObject, eventdata, handles)

if strcmp(get_param('Last_version_po_STO', 'SimulationStatus'),'paused')
    set_param('Last_version_po_STO', 'SimulationCommand', 'continue');
    set(handles.pause_model,'String','Ïàóçà');
    set(handles.start_model,'String','Ïóñê ìîäåëè');
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
% ÇÀÏĞÅÒ ÈÇÌÅÍÅÍÈß ÄËÈÍÛ ÎÑÖÈËËÎÃĞÀÌÌÛ (Ò.Ê. ÍÅËÜÇßß ÅÅ ÌÅÍßÒÜ ÂÎ ÂĞÅÌß
% ÌÎÄÅËÈĞÎÂÀÍÈß)
set(handles.time_cmtrd_full,'Enable','off');
% ÑÁĞÎÑ Ñ×ÅÒ×ÈÊÀ ÂĞÅÌÅÍÈ COMTRADE:
switch get_param('Last_version_po_STO/choosing_PO/reset_comtrade','Value')
    case '0'
        set_param('Last_version_po_STO/choosing_PO/reset_comtrade','Value','1');
    case '1'
        set_param('Last_version_po_STO/choosing_PO/reset_comtrade','Value','0');
end
% ÑÁĞÎÑ Ñ×ÅÒ×ÈÊÀ ÂĞÅÌÅÍÈ ÌÎÄÅËÈĞÎÂÀÍÈß
switch get_param('Last_version_po_STO/time_reset','Value')
    case '0'
        set_param('Last_version_po_STO/time_reset','Value','1');
    case '1'
        set_param('Last_version_po_STO/time_reset','Value','0');
end
% ÑÎÇÄÀÍÈÅ ÎÁÚÅÊÒÎÂ ÏÎËÓ×ÅÍÈß ÏÀĞÀÌÅÒĞÎÂ ÈÇ ÌÎÄÅËÈ:
% - ÍÀÏĞßÆÅÍÈß ÍÀ ØÈÍÀÕ
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

% - ÌÎÙÍÎÑÒÈ ÍÀÃĞÓÇÎÊ
global rto_PS1;
rto_PS1 = get_param('Last_version_po_STO/Gain11', 'RuntimeObject');
global rto_PS2;
rto_PS2 = get_param('Last_version_po_STO/Gain10', 'RuntimeObject');
global rto_PS3;
rto_PS3 = get_param('Last_version_po_STO/Gain12', 'RuntimeObject');

% - ÒÎÊ È ÌÎÙÍÎÑÒÜ Â ÊÎÍÒĞÎËÈĞÓÅÌÎÉ ËÈÍÈÈ
global rto_S_line;
rto_S_line = get_param('Last_version_po_STO/Gain6', 'RuntimeObject');
global rto_I_line;
rto_I_line = get_param('Last_version_po_STO/fourier_filter8/Gain1', 'RuntimeObject');
global t;

% - ÏÎËÎÆÅÍÈß ÂÛÊËŞ×ÀÒÅËÅÉ
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

% - ÄÈÑÊĞÅÒÍÛÅ ÑÈÃÍÀËÛ ÎÒ ÀÎÏÎ
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

% - ÃÎÒÎÂÍÎÑÒÜ ÄÀÍÍÛÕ ÄËß ÇÀÏÈÑÈ ÎÑÖÈËËÎÃĞÀÌÌÛ
global rto_cmtrd_ready;
rto_cmtrd_ready = get_param('Last_version_po_STO/Logical6','RuntimeObject');

% - ÂĞÅÌß ÑÒÀĞÒÀ ÌÎÄÅËÈĞÎÂÀÍÈß È ÂĞÅÌß, ÎÒÑ×ÈÒÛÂÀÅÌÎÅ ÎÒ ÑÒÀĞÒÀ
global start_time;
start_time = datetime('now','Format','HH:mm:ss.SSS');
global model_time;
model_time = get_param('Last_version_po_STO/Clock','RuntimeObject');
start(t);


% ÊÎÄ, ÈÑÏÎËßÍÅÌÛÉ ÏĞÈ ÏÎÑÒÀÍÎÂÊÅ ÌÎÄÅËÈ ÍÀ ÏÀÓÇÓ
function pause_model_Callback(hObject, eventdata, handles)
global t;
if strcmp(get_param('Last_version_po_STO', 'SimulationStatus'),'running')
    stop(t);
    set_param('Last_version_po_STO', 'SimulationCommand', 'pause');
    set(handles.start_model,'Enable','on');
    set(handles.start_model,'String','Ïğîäîëæèòü');
    set(handles.pause_model,'Enable','off');
    set(handles.get_comtrade,'Enable','on');
    set(handles.cmtrd_inform,'Visible','off');
    %set(handles.get_comtrade,'Enable','off'); 31.01.19
end

% ÊÎÄ, ÈÑÏÎËßÍÅÌÛÉ ÏĞÈ ÎÑÒÀÍÎÂÊÅ ÌÎÄÅËÈ
function stop_model_Callback(hObject, eventdata, handles)
global t;
stop(t);
set_param('Last_version_po_STO', 'SimulationCommand', 'stop');
set(handles.pause_model,'Enable','off');
set(handles.stop_model,'Enable','off');
set(handles.start_model,'Enable','on');
set(handles.start_model,'String','Ïóñê ìîäåëè');
set(handles.time_cmtrd_full,'Enable','on');
set(hObject,'Enable','Off');
set(handles.get_comtrade,'Enable','off');
set(handles.cmtrd_inform,'Visible','off');

% ÌÎÄÅËÈĞÎÂÀÍÈÅ ÊÇ Ñ ÀÏÂ:
function KZ_APV_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/KZ_simulation/start_KZ','Value','1');

% ÑÁĞÎÑ ÊÇ (ÌÎÆÍÎ ÎĞÃÀÍÈÇÎÂÀÒÜ İÒÎ ÏÎ-ÄĞÓÃÎÌÓ)
function KZ_reset_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/KZ_simulation/start_KZ','Value','0');

% ÎÒÊĞÛÒÈÅ ÎÊÍÀ ÈÌÈÒÀÖÈÈ ÏÎÂĞÅÆÄÅÍÈÉ Â ÒÎÊÎÂÛÕ ÖÅÏßÕ:
function TT_faults_Callback(hObject, eventdata, handles)
TT_faults_control;

% ÏÎËÜÇÎÂÀÒÅËÜÑÊÎÅ ÇÀÄÀÍÈÅ ÏÎÊÀÇÀÍÈÉ ÄÀÒ×ÈÊÀ ÒÅÌÏÅĞÀÒÓĞÛ ¹1
function temper_1_Callback(hObject, eventdata, handles)
temp = str2double(get(hObject, 'String'));
if isnan(temp) || ~(mod(temp,1) == 0)
    set(hObject, 'String', get_param('Last_version_po_STO/temperature1','Value'));
    errordlg('Òåìïåğàòóğà äîëæíà áûòü ÷èñëîì ñ øàãîì 1','Îøèáêà! Ïîâòîğèòå ââîä');
end

function temper_1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ÏÎËÜÇÎÂÀÒÅËÜÑÊÎÅ ÇÀÄÀÍÈÅ ÏÎÊÀÇÀÍÈÉ ÄÀÒ×ÈÊÀ ÒÅÌÏÅĞÀÒÓĞÛ ¹2
function temper_2_Callback(hObject, eventdata, handles)
temp = str2double(get(hObject, 'String'));
if isnan(temp) || ~(mod(temp,1) == 0)
    set(hObject, 'String', get_param('Last_version_po_STO/temperature2','Value'));
    errordlg('Òåìïåğàòóğà äîëæíà áûòü ÷èñëîì ñ øàãîì 1','Îøèáêà! Ïîâòîğèòå ââîä');
end

function temper_2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ÇÀÄÀÍÈÅ ÄËÈÍÛ ÇÀÏÈÑÛÂÀÅÌÎÉ ÎÑÖÈËËÎÃĞÀÌÌÛ:
function time_cmtrd_full_Callback(hObject, eventdata, handles)
t = str2double(get(hObject, 'String'));
t2 = str2double(get(handles.time_cmtrd,'String'));
if isnan(t) || t < 0 || ~(mod(t,0.1) == 0)
    set(hObject, 'String', string(0.001*str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'))));
    errordlg('Âğåìÿ äîëæíî áûòü ïîëîæèòåëüíûì ÷èñëîì ñ øàãîì 0.1','Îøèáêà! Ïîâòîğèòå ââîä');
else
    if t < t2
        set(hObject, 'String', string(0.001*str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'))));
        errordlg('Âğåìÿ äîëæíî áûòü áîëüøå âğåìåíè ïîñëå ïóñêà ÏÎ','Îøèáêà! Ïîâòîğèòå ââîä');
    else
        set_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints',string(1000*t));
        set_param('Last_version_po_STO/time_cmtrd','Value',string(t));
    end
end

function time_cmtrd_full_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% ÇÀÄÀÍÈÅ ÂĞÅÌÅÍÈ Ñ ÌÎÌÅÍÒÀ ÑĞÀÁÀÒÛÂÀÍÈß ÏÓÑÊÎÂÎÃÎ ÎĞÃÀÍÀ ÄÎ ÊÎÍÖÀ
% ÇÀÏÈÑÛÂÀÅÌÎÉ ÎÑÖÈËËÎÃĞÀÌÌÛ:
function time_cmtrd_Callback(hObject, eventdata, handles)
t = str2double(get(hObject, 'String'));
t2 = str2double(get(handles.time_cmtrd_full,'String'));
if isnan(t) || t < 0 || ~(mod(t,0.1) == 0)
    set(hObject, 'String', string(get_param('Last_version_po_STO/Constant1','Value')));
    errordlg('Âğåìÿ äîëæíî áûòü ïîëîæèòåëüíûì ÷èñëîì ñ øàãîì 0.1','Îøèáêà! Ïîâòîğèòå ââîä');
else
    if t > t2
        set(hObject, 'String', string(get_param('Last_version_po_STO/Constant1','Value')));
        errordlg('Âğåìÿ äîëæíî áûòü ìåíüøå âğåìåíè çàïèñè îñöèëëîãğàììû','Îøèáêà! Ïîâòîğèòå ââîä');
    else
        set_param('Last_version_po_STO/Constant1','Value',string(t));
    end
end

function time_cmtrd_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ÓÑÒÀÍÎÂÊÀ ÇÀÄÀÍÍÛÕ ÇÍÀ×ÅÍÈÉ ÒÅÌÏÅĞÀÒÓĞÛ Â ÌÎÄÅËÜ
function set_tempers_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/temperature1','Value',get(handles.temper_1,'String'));
set_param('Last_version_po_STO/temperature2','Value',get(handles.temper_2,'String'));


% ÏÎÑÒÀÍÎÂÊÀ ÌÎÄÅËÈ ÍÀ ÏÀÓÇÓ È ÂÛÃĞÓÇÊÀ ÎÑÖÈËËÎÃĞÀÌÌÛ:
function get_comtrade_Callback(hObject, eventdata, handles)
%pause_model_Callback(hObject, eventdata, handles); 31.01.19
set(hObject,'Enable','off');
try
    cmtrd_data = evalin('base','cmtrd_data');
    value_number = length(cmtrd_data.Data(:,1));
    value_number = str2double(get_param('Last_version_po_STO/Subsystem/ToWorkspace','MaxDataPoints'));
    write_comtrade;
    evalin('base','clear cmtrd_data');
    msgbox('Îñöèëëîãğàììà çàïèñàíà');
catch
    errordlg('×òî-òî ïîøëî íå òàê. Ïîïğîáóéòå åùå ğàç','Óïñ! Îøèáêà!');
end

% ÑÈÃÍÀË "ÁÍÍ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton1_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','1');

% ÑÈÃÍÀË "ÊÒÖ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton2_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','2');

% ÑÈÃÍÀË "ÑĞÀÁÀÒÛÂÀÍÈÅ 1 ÑÒÓÏÅÍÈ ÀÎÏÎ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton3_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','3');

% ÔÀÊÒ ÑÍÈÆÅÍÈß ÍÀÃĞÓÇÊÈ ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton4_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','4');

% ÔÀÊÒ ÊÇ ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton5_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','5');

% ÑÈÃÍÀË "ÑĞÀÁÀÒÛÂÀÍÈÅ 2 ÑÒÓÏÅÍÈ ÀÎÏÎ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton6_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','6');

% ÑÈÃÍÀË "ÏÓÑÊ 1 ÑÒÓÏÅÍÈ ÀÎÏÎ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton7_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','7');

% ÑÈÃÍÀË "ÍÅÈÑÏĞÀÂÍÎÑÒÜ ÄÀÒ×ÈÊÎÂ ÒÅÌÏÅĞÀÒÓĞÛ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton8_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','8');

% ÑÈÃÍÀË "ÑÌÅÍÀ ÃĞÓÏÏÛ ÓÑÒÀÂÎÊ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton9_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','9');

% ÑÈÃÍÀË "ÑĞÀÁÀÒÛÂÀÍÈÅ 3 ÑÒÓÏÅÍÈ ÀÎÏÎ" ÎÑÒÀÍÀÂËÈÂÀÅÒ COMTRADE
function radiobutton10_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/choose_PO','Value','10');

% ÂÊËŞ×ÅÍÈÅ ËÈÍÈÈ Ñ ÎÁÅÈÕ ÑÒÎĞÎÍ
function turn_on_LEP_Callback(hObject, eventdata, handles)
set_param('Last_version_po_STO/Constant4','Value','1');
set_param('Last_version_po_STO/Constant5','Value','1');
pause(0.2);
set_param('Last_version_po_STO/Constant4','Value','0');
set_param('Last_version_po_STO/Constant5','Value','0');


% ÓÄÀËÅÍÈÅ ÒÀÉÌÅĞÀ ÏĞÈ ÇÀÊĞÛÒÈÈ ÎÊÍÀ
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
