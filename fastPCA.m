function [pcaA V immin] = fastPCA( A, k ,imdata)
% ����PCA
%
% ���룺A --- ��������ÿ��Ϊһ������
%       k --- ��ά�� k ά
%       imdata---ѵ�����ݼ�����
% �����pcaA --- ��ά��� k ά��������������ɵľ���ÿ��һ������������ k Ϊ��ά�����������ά��
%       V --- ���ɷ�����
[r c] = size(A);

% ������ֵ
meanVec = mean(A);
save('Mat/meanVec', 'meanVec')
%�������ݵ�ƽ����
average_face=mean(imdata,2);
save('Mat/average_face','average_face')
immin=zeros(112*92,40*5);
for i=1:40*5  
    immin(:,i) = double(imdata(:,i))-mean(imdata,2);
end
save('Mat/immin','immin')

% ����Э��������ת�� covMatT
Z = (A-repmat(meanVec, r, 1));
covMatT = Z * Z';

% ���� covMatT ��ǰ k ������ֵ�ͱ�������
[V D] = eigs(covMatT, k);

% �õ�Э������� (covMatT)' �ı�������
V = Z' * V;

% ����������һ��Ϊ��λ��������
for i=1:k
    V(:,i)=V(:,i)/norm(V(:,i));
end
save('Mat/V', 'V');
% ���Ա任��ͶӰ����ά�� k ά
pcaA = Z * V;

% ����任���� V(10304*49) �ͱ任ԭ�� meanVec(1*10304)����ֵ��
% �������PCA����ѵ���õ������ݣ����������Ե�ʱ����Ȼ������ռ�ͶӰ
save('Mat/PCA.mat', 'V', 'meanVec');
