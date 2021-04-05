function [pcaA V immin] = fastPCA( A, k ,imdata)
% 快速PCA
%
% 输入：A --- 样本矩阵，每行为一个样本
%       k --- 降维至 k 维
%       imdata---训练数据集矩阵
% 输出：pcaA --- 降维后的 k 维样本特征向量组成的矩阵，每行一个样本，列数 k 为降维后的样本特征维数
%       V --- 主成分向量
[r c] = size(A);

% 样本均值
meanVec = mean(A);
save('Mat/meanVec', 'meanVec')
%读入数据的平均脸
average_face=mean(imdata,2);
save('Mat/average_face','average_face')
immin=zeros(112*92,40*5);
for i=1:40*5  
    immin(:,i) = double(imdata(:,i))-mean(imdata,2);
end
save('Mat/immin','immin')

% 计算协方差矩阵的转置 covMatT
Z = (A-repmat(meanVec, r, 1));
covMatT = Z * Z';

% 计算 covMatT 的前 k 个本征值和本征向量
[V D] = eigs(covMatT, k);

% 得到协方差矩阵 (covMatT)' 的本征向量
V = Z' * V;

% 本征向量归一化为单位本征向量
for i=1:k
    V(:,i)=V(:,i)/norm(V(:,i));
end
save('Mat/V', 'V');
% 线性变换（投影）降维至 k 维
pcaA = Z * V;

% 保存变换矩阵 V(10304*49) 和变换原点 meanVec(1*10304)（均值）
% 这里就是PCA部分训练得到的数据，保存后面测试的时候依然往这个空间投影
save('Mat/PCA.mat', 'V', 'meanVec');
