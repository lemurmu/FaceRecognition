%% ������ѵ��BP������
%num1 num2 num3 �ֱ�������������';'��һ������Ԫ��Ŀ';'�ڶ�������Ԫ��Ŀ';
%str1 str2 str3;'��һ���㼤���';'�ڶ����㼤���';'ѵ������';
load('Mat/TrainData.mat');
load Mat\key_reset;
if key_reset==0
    num1=5000; num2=240; num3=180;
    str1='purelin'; str2='purelin'; str3='traingdx';
else
    load Mat\param;
end
%����ѵ��BP����������� P 
%200*49�ľ���, ÿһ�д���һ�����ɷ���(��40�ˣ�ÿ��5��)��ÿ����49ά���������룩
%��faceLabel��200*1���Ӧ�������
P=TrainData;
%����Ŀ�����ʸ�� T
T=zeros(200,40);
 for i=1:40
    for j=1:5
      T((i-1)*5+j,i)=1;
    end
 end
 
 
%����ѵ������˳��
%P(200*49)   T(200*40)ȫ�����
gx2(:,1:k)=P;  %ǰ k ������ֵ�ͱ������� k=49
gx2(:,(k+1):(k+40))=T;
xd=gx2(randperm(numel(gx2)/(k+40)),:);   %matlab  randperm�������������������ǩ��Ӧ����  
gx=xd(:,1:k);
d=xd(:,(k+1):(k+40));
P=gx';
T=d';

%����BP������

[R,Q]=size(P);
[S2,Q]=size(T);
% net=newff(minmax(P),T,[fix(sqrt(R*S2))],{'purelin','purelin'},'traingdx');
net=newff(minmax(P),T,[num2 num3],{str1,str2},str3);
save('Mat/net', 'net');
%ѵ��BP������
net.trainparam.epochs=num1;    %ѵ������
net.trainparam.goal=0.0001;    %ѵ��Ŀ�����
net.divideFcn = '';            %���е�����������ѵ��
[net,tr]=train(net,P,T);       %PΪ���룬TΪ�������ʼѵ��

%����BP������
Y=sim(net,P);
