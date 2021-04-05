function varargout = faceGUI(varargin)
% FACEGUI MATLAB code for faceGUI.fig
%      FACEGUI, by itself, creates a new FACEGUI or raises the existing
%      singleton*.
%
%      H = FACEGUI returns the handle to a new FACEGUI or the handle to
%      the existing singleton*.
%
%      FACEGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FACEGUI.M with the given input arguments.
%
%      FACEGUI('Property','Value',...) creates a new FACEGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before faceGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to faceGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help faceGUI

% Last Modified by GUIDE v2.5 22-May-2020 16:26:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @faceGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @faceGUI_OutputFcn, ...
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


% --- Executes just before faceGUI is made visible.
function faceGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to faceGUI (see VARARGIN)

% Choose default command line output for faceGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes faceGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
warning off all;
% javeFrame=get(hObject,'JavaFrame');
% javeFrame.setFigureIcon(javax.swing.ImageIcon('logo.png'));

set(gcf,'numbertitle','off','name','�������ѧϰ������ʶ�����');
% UIWAIT makes firstPage wait for user response (see UIRESUME)
% uiwait(handles.figure1);
bg_P=axes('units','normalized','position',[0 0 1 1]);
uistack(bg_P,'bottom');
II=imread('theme.jpg');
image(II);
hold on 
  w=text(75,98,'�������ѧϰ������ʶ�����','fontsize',25,'color',[0.0 0.0 0.0]);
   w1=text(225,150,'Face Recognition Software ','fontsize',20,'color',[0.0 0.0 0.0]);
   w2=text(200,200,'Based on deep learning ','fontsize',20,'color',[0.0 0.0 0.0]); 
   w3=text(385,400,'����ʦ����ѧ','fontsize',15,'color',[0.0 0.0 0.0]);
    w4=text(340,420,'Guangxi Normal University ','fontsize',13,'color',[0.0 0.0 0.0]);
     w5=text(380,470,'2021.3.10','fontsize',11,'color',[0.0 0.0 0.0]);
   
   
colormap gray;
set(bg_P,'handlevisibility','off','visible','off');

% --- Outputs from this function are returned to the command line.
function varargout = faceGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_12_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_13_Callback(hObject, eventdata, handles)
Connection;
% hObject    handle to Untitled_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_14_Callback(hObject, eventdata, handles)
version_1;
% hObject    handle to Untitled_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_15_Callback(hObject, eventdata, handles)
open �������ѧϰ����ʶ�����˵����.docx
% hObject    handle to Untitled_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_11_Callback(hObject, eventdata, handles)
[filename pathname]=uigetfile({'*.jpg';'*.png';'*.gif'},'ѡ�񱳾�');
if filename~=0
    load([pathname filename]);

I=imread([pathname filename]);
I=imresize(I,[531,850]);
% c=uisetcolor([165/255 211/255 232/255],'��ɫ����');
bg_P=axes('units','normalized','position',[0 0 1 1]);
uistack(bg_P,'up');
image(I);

hold on 
  w=text(75,98,'�������ѧϰ������ʶ�����','fontsize',25,'color',[0.0 0.0 0.0]);
   w1=text(225,150,'Face Recognition Software ','fontsize',20,'color',[0.0 0.0 0.0]);
   w2=text(200,200,'Based on deep learning ','fontsize',20,'color',[0.0 0.0 0.0]); 
   w3=text(385,400,'����ʦ����ѧ','fontsize',15,'color',[0.0 0.0 0.0]);
    w4=text(340,420,'Guangxi Normal University ','fontsize',13,'color',[0.0 0.0 0.0]);
     w5=text(380,470,'2021.3.10','fontsize',11,'color',[0.0 0.0 0.0]);
set(bg_P,'handlevisibility','off','visible','off');
end
% axes('units','normalized','position',[0 0 1 1]);
% [filename ,pathname]=uigetfile({'*.png';'*.jpg';'*.gif';'*.bmp' },'ѡ��ͼƬ');
% str=[pathname filename];
% a=imread(str); % �������ͼ
% imshow(a); % ��ʾ
% handles.output = hObject;

% hObject    handle to Untitled_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
FastBPfacedetection();
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
tex=['Ĭ�ϲ����Ǿ����������õ���������ϣ��������Ҫ����������'];
q=questdlg(tex,'��ܰ��ʾ','��','��','��');
if q=='��'      
    t{1}='����������';t{2}='��һ������Ԫ��Ŀ';t{3}='�ڶ�������Ԫ��Ŀ';
    t{4}='��һ���㼤���';t{5}='�ڶ����㼤���';t{6}='ѵ������';
    title='����';
    default_t={'5000','240','180','purelin','purelin','traingdx'};
    param=inputdlg(t,title,1,default_t,'on');
    num1=str2num(param{1});num2=str2num(param{2});num3=str2num(param{3});
    str1=(param{4});str2=(param{5});str3=(param{6});
    
    save Mat\param num1 num2 num3 str1 str2 str3;
        key_reset=1;
    save Mat\key_reset key_reset;
else
    key_reset=0;
    save Mat\key_reset key_reset;
    
end
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
close(gcf); % �رյ�ǰҳ��
recognize;  % ������ʶ��ҳ��
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.jpg';'*.png';'*.gif'},'ѡ�񱳾�');
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
[filename,pathname]=uigetfile({'*.mat'},'�����ļ�','Untitled.mat');%���ļ�����Ի��򣬻�ñ����ļ����ļ����͵�ַ
file=strcat(pathname,filename);
save(file,'a');
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
close;% �رյ�ǰ����
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_16_Callback(hObject, eventdata, handles)
open BP���������.docx
% hObject    handle to Untitled_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
