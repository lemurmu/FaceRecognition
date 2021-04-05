function FastBPfacedetection()
%% ��һ������������
global imgRow;
global imgCol;
global net
% display('ѵ����ʼ...');

nPerson=40;
nFacesPerPerson = 5;
load Mat\imdata; 
% display('������������...');
[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson,nPerson);
nFaces=size(FaceContainer,1);%��������������Ŀ��40*5=200��������

% display('PCA��ά...');
k=49;   %ǰ k ������ֵ�ͱ�������
[pcaFaces, W] = fastPCA(FaceContainer, k,imdata); % ���ɷַ���PCA
% pcaFaces��200*49�ľ���, ÿһ�д���һ�����ɷ���(��40�ˣ�ÿ��5��)��ÿ����49ά����
% W�Ƿ���任����, 10304*49 �ľ���
visualize_pc(W);%��ʾ���ɷ���

X = pcaFaces;
% 
% display('��һ����ʼ...');
[X,A0,B0] = scaling(X);
save('Mat/scaling.mat', 'A0', 'B0');
% ���� scaling ���ѵ�������� trainData.mat
TrainData = X;
trainLabel = faceLabel;   %��ReadFaces.m���涨�壬��������ǩ200*1�����������
save('Mat/trainData.mat', 'TrainData', 'trainLabel');
% display('��һ�����...');


% %% �ڶ�����������ѵ��BP������
BP;

%% ������������BP�����粢������ʶ����
% display('���Կ�ʼ...');
%����BP������
s=0;
    load('Mat/PCA.mat');
    load('Mat/scaling.mat');
    load('Mat/trainData.mat');
%     load('Mat/multiSVMTrain.mat');
%     display('..............................');
for i=1:40
    for j=6:10                              %����40x5������ͼ��
         a=imread(strcat('F:\����ʶ����\����ʶ��\faces','\s',num2str(i),'/',num2str(j),'.bmp'));
         b=a(1:10304);
         b=double(b);
         TestFace=b;
         [m n] = size(TestFace);
         TestFace = (TestFace-repmat(meanVec, m, 1))*V; % ����pca�任��ά
         TestFace = scaling(TestFace,1,A0,B0);
         X = TestFace;
         Z=sim(net,X');
         [zi,index2]=max(Z);
         if index2==i   
             s=s+1;
         else
%              i                             %���ʶ�������Ǹ��� i
%              j                           %���ʶ����������ͼƬ j
%              index2;                         %�����ʶ��ɵ��Ǹ���
%              disp=(['���Լ��е� ' ,num2str(i), '���ˣ���', num2str(j) , '��ͼƬ��������ൽ' ,num2str(index2), '��'])
         end
     end
end

%����ʶ����
accuracy=s/Q
save('Mat/accuracy', 'accuracy')
