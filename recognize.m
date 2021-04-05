function varargout = recognize(varargin)
% RECOGNIZE MATLAB code for recognize.fig
%      RECOGNIZE, by itself, creates a new RECOGNIZE or raises the existing
%      singleton*.
%
%      H = RECOGNIZE returns the handle to a new RECOGNIZE or the handle to
%      the existing singleton*.
%
%      RECOGNIZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECOGNIZE.M with the given input arguments.
%
%      RECOGNIZE('Property','Value',...) creates a new RECOGNIZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before recognize_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to recognize_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help recognize

% Last Modified by GUIDE v2.5 21-Feb-2021 13:36:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @recognize_OpeningFcn, ...
                   'gui_OutputFcn',  @recognize_OutputFcn, ...
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


% --- Executes just before recognize is made visible.
function recognize_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to recognize (see VARARGIN)

% Choose default command line output for recognize
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes recognize wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = recognize_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in input.
function input_Callback(hObject, eventdata, handles)
FastBPfacedetection(); %运行FastBPfacedetection程序，进行预置神经网络的训练
load Mat\accuracy;   % 加载accuracy变量到工作区，它表示该预置神经网络的准确率
set(handles.acu,'String',accuracy); %将accuracy显示在文本框内
msgbox('数据导入成功','提示');
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in ceshi.
function ceshi_Callback(hObject, eventdata, handles)
% set(handles.uipanel1,'visible','off');
[filename, pathname]=uigetfile({'*.bmp';'*.png';'*.jpg'},'打开测试图片');
% if filename~=0
%     fullfile([pathname filename]);
% %     load([pathname filename]);
% end

I=imread([pathname filename]);
axes(handles.axes4);
imshow(I);
save('Mat/I', 'I')
msgbox('人脸导入成功','提示');
% handles.I=I;
% guidata(hObject,handles);
% setappdata(0,'I',I);
% hObject    handle to ceshi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in result.
function result_Callback(hObject, eventdata, handles)
%           load Mat\test; 
          load Mat\I; 
          load Mat\meanVec; 
          load Mat\V; 
          load Mat\immin; 
          load Mat\average_face;      
face_train_projection=zeros(49,40*5);
for i=1:40*5
    %映射训练集图像
    Coefficient1=V'*immin(:,i);  %k*d x d*1=k*1;
    face_train_projection(:,i)=Coefficient1;
end         
         
B=I(1:112*92);
test=double(B')-average_face;
TestProjectedImage = (V'*test);
Euc_dist = [];
for p=1:length(face_train_projection)
      temp=normest(TestProjectedImage-face_train_projection(:,p));
      Euc_dist = [Euc_dist temp];
end
[Euc_dist_min , Recognized_index] = min(Euc_dist);%Recognized_index记录最小距离的行号
OutputClass = strcat('s',int2str((Recognized_index-1)/5),'class');
axes(handles.axes6);
imshow(reshape(((immin(:,Recognized_index))'+average_face'),112,92),[]);
title(strcat('识别人脸，类别:',int2str((Recognized_index-1)/5)));
msgbox('人脸识别完成','提示');
%          b=test(1:10304);
%          b=double(b);
%          TestFace=b;
%          [m n] = size(TestFace);
%          TestFace = (TestFace-repmat(meanVec, m, 1))*V; % 经过pca变换降维
%          TestFace = scaling(TestFace,1,A0,B0);
%          X = TestFace;
%          Z=sim(net,X');
%          [zi,index2]=max(Z);
%          addr=strcat('F:\人脸识别技术\人脸识别\faces','\s',num2str(int2str((index2-1)/5)),'/',num2str(index2),'.bmp');
%          res=imread(addr);
%          axes(handles.axes6);
%          imshow(res);
         %         a=imread(addr);

% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function acu_Callback(hObject, eventdata, handles)

% hObject    handle to acu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of acu as text
%        str2double(get(hObject,'String')) returns contents of acu as a double


% --- Executes during object creation, after setting all properties.
function acu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
close(recognize);
faceGUI;
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over input.
function input_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
