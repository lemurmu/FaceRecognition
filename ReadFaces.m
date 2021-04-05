function [imgRow,imgCol,FaceContainer,faceLabel,imdata]=ReadFaces(nFacesPerPerson, nPerson)
% ����ORL�������ָ����Ŀ������ǰǰ����(ѵ��)
%
% ���룺nFacesPerPerson --- ÿ������Ҫ�������������Ĭ��ֵΪ 5
%       nPerson --- ��Ҫ�����������Ĭ��Ϊȫ�� 40 ����
%       bTest --- bool�͵Ĳ�����Ĭ��Ϊ0����ʾ����ѵ��������ǰ5�ţ������Ϊ1����ʾ���������������5�ţ�
%
% �����FaceContainer --- ����������������nPerson��200�� * 10304 �� 2 ά����ÿ�ж�Ӧһ����������

% if nargin==0 %default value
%     nFacesPerPerson=5;%ǰ5������ѵ��
%     nPerson=40;%Ҫ�����������ÿ�˹�10�ţ�ǰ5������ѵ����
%     bTest = 0;
% elseif nargin < 3
%     bTest = 0;
% end

img=imread('faces/s1/1.bmp');%Ϊ����ߴ��ȶ���һ��
[imgRow,imgCol]=size(img);

%����40��*ǰ5�Ź�200�У�imgRow*imgCol�е�ȫ�����
FaceContainer = zeros(nFacesPerPerson*nPerson, imgRow*imgCol);
%����200�У�һ��ȫ�����
faceLabel = zeros(nFacesPerPerson*nPerson, 1);

% ����ѵ������
for i=1:nPerson    %40��
%     i1=mod(i,10); % ��λ��%�ú������ڽ���ȡģ��ȡ�ࣩ����
%     i0=char(i/10);% ����ת���ַ���

    for j=1:nFacesPerPerson   %ѵ�����ݼ�������ͼƬnFacesPerPerson = 5
        strPath=strcat('faces','\s',num2str(i),'/',num2str(j),'.bmp');
        img=imread(strPath);%������뵥��ͼƬ
        %�Ѷ����ͼ���д洢Ϊ������������������������faceContainer�Ķ�Ӧ����
        FaceContainer((i-1)*nFacesPerPerson+j, :) = img(:)';
        %����ǩ111112222233333...(���Ϊһ�����40�����)
        faceLabel((i-1)*nFacesPerPerson+j) = i;
        b=img(1:112*92); %��ͼ��a������˳��תΪ������b
        imdata(:,5*(i-1)+j)=b'; %��b��ת�þ����ŵ�imdata����ĵ�ph*(i-1)+j��
    end % j
end % i

% ����������������FaceMat��200*10304��ÿһ��Ϊһ������
save('Mat/FaceMat.mat', 'FaceContainer')
save('Mat/imdata.mat','imdata')

