function [SVFM, lowVec, upVec] = scaling(VecFeaMat, bTest, lRealBVec, uRealBVec)
% Input:  VecFeaMat --- ��Ҫscaling�� m*n ά���ݾ���ÿ��һ��������������������Ϊά��
%         bTest ---  =1��˵���Ƕ��ڲ�����������scaling����ʱ�����ṩ lRealBVec �� uRealBVec
%                       ��ֵ���˶�ֵӦ�����ڶ�ѵ������ scaling ʱ�õ���
%                    =0��Ĭ��ֵ����ѵ���������� scaling
%         lRealBVec --- nά��������ѵ������ scaling ʱ�õ��ĸ�ά��ʵ��������Ϣ
%         uRealBVec --- nά��������ѵ������ scaling ʱ�õ��ĸ�ά��ʵ��������Ϣ
%
% output: SVFM --- VecFeaMat�� scaling 
%         upVec --- ��ά����������(ֻ�ڶ�ѵ������scalingʱ�����壬bTest = 0)
%         lowVec --- ��ά����������(ֻ�ڶ�ѵ������scalingʱ�����壬bTest = 0)
if nargin < 2   
    %�������������������˼���������������2��ʱ��˵����ѵ���׶Σ��ʽ�bTest��Ϊ�㣬2018.11.29_FB 
    %nargin�������������nargout�����������
    bTest = 0;
end

% ����Ŀ�귶Χ[-1, 1]
lTargB = -1;
uTargB = 1;

%pcaFaces��200*49��
[m n] = size(VecFeaMat);

SVFM = zeros(m, n);

if bTest
    if nargin < 4
        error('To do scaling on testset, param lRealB and uRealB are needed.')
    end
    
    if nargout > 1  %nargout�����������
        error('When do scaling on testset, only one output is supported.')
    end

    for iCol = 1:n  %nΪpcaFaces  ����   k=49
        if uRealBVec(iCol) == lRealBVec(iCol)  %ʵ��������Ϣ = ʵ��������Ϣ
            SVFM(:, iCol) = uRealBVec(iCol);
            SVFM(:, iCol) = 0;
        else
            %lTargB = -1;  uTargB = 1;
            SVFM(:, iCol) = lTargB  +  ( VecFeaMat(:, iCol) - lRealBVec(iCol) ) / ( uRealBVec(iCol)-lRealBVec(iCol) ) * (uTargB-lTargB); % �������ݵ�scaling
        end
    end
else
    
    %ѵ���׶ε�scaling��һ��
    upVec = zeros(1, n);%  ��һ��  ����������������ѵ������Ҫ���������
    lowVec = zeros(1, n);

    for iCol = 1:n
        lowVec(iCol) = min( VecFeaMat(:, iCol) );  %����ѡȡһ����Сֵ
        upVec(iCol) = max( VecFeaMat(:, iCol) );
        if upVec(iCol) == lowVec(iCol)
            SVFM(:, iCol) = upVec(iCol);      
            SVFM(:, iCol) = 0;
        else
            SVFM(:, iCol) = lTargB  +  ( VecFeaMat(:, iCol) - lowVec(iCol) ) / ( upVec(iCol)-lowVec(iCol) ) * (uTargB-lTargB); % ѵ�����ݵ�scaling
        end
    end
end
