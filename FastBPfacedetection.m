function FastBPfacedetection()
%% 第一步，读入数据
global imgRow;
global imgCol;
global net
% display('训练开始...');

nPerson=40;
nFacesPerPerson = 5;
load Mat\imdata; 
% display('读入人脸数据...');
[imgRow,imgCol,FaceContainer,faceLabel]=ReadFaces(nFacesPerPerson,nPerson);
nFaces=size(FaceContainer,1);%样本（人脸）数目（40*5=200个人脸）

% display('PCA降维...');
k=49;   %前 k 个本征值和本征向量
[pcaFaces, W] = fastPCA(FaceContainer, k,imdata); % 主成分分析PCA
% pcaFaces是200*49的矩阵, 每一行代表一张主成分脸(共40人，每人5张)，每个脸49维特征
% W是分离变换矩阵, 10304*49 的矩阵
visualize_pc(W);%显示主成分脸

X = pcaFaces;
% 
% display('归一化开始...');
[X,A0,B0] = scaling(X);
save('Mat/scaling.mat', 'A0', 'B0');
% 保存 scaling 后的训练数据至 trainData.mat
TrainData = X;
trainLabel = faceLabel;   %在ReadFaces.m里面定义，人脸类别标签200*1（期望输出）
save('Mat/trainData.mat', 'TrainData', 'trainLabel');
% display('归一化完成...');


% %% 第二步，创建并训练BP神经网络
BP;

%% 第三步，测试BP神经网络并计算其识别率
% display('测试开始...');
%测试BP神经网络
s=0;
    load('Mat/PCA.mat');
    load('Mat/scaling.mat');
    load('Mat/trainData.mat');
%     load('Mat/multiSVMTrain.mat');
%     display('..............................');
for i=1:40
    for j=6:10                              %读入40x5副测试图像
         a=imread(strcat('F:\人脸识别技术\人脸识别\faces','\s',num2str(i),'/',num2str(j),'.bmp'));
         b=a(1:10304);
         b=double(b);
         TestFace=b;
         [m n] = size(TestFace);
         TestFace = (TestFace-repmat(meanVec, m, 1))*V; % 经过pca变换降维
         TestFace = scaling(TestFace,1,A0,B0);
         X = TestFace;
         Z=sim(net,X');
         [zi,index2]=max(Z);
         if index2==i   
             s=s+1;
         else
%              i                             %输出识别出错的那个人 i
%              j                           %输出识别出错的那张图片 j
%              index2;                         %输出误识别成的那个人
%              disp=(['测试集中第 ' ,num2str(i), '个人，第', num2str(j) , '张图片被错误分类到' ,num2str(index2), '类'])
         end
     end
end

%计算识别率
accuracy=s/Q
save('Mat/accuracy', 'accuracy')
