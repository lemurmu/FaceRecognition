%% 创建并训练BP神经网络
%num1 num2 num3 分别是最大迭代次数';'第一隐层隐元数目';'第二隐层隐元数目';
%str1 str2 str3;'第一隐层激活函数';'第二隐层激活函数';'训练函数';
load('Mat/TrainData.mat');
load Mat\key_reset;
if key_reset==0
    num1=5000; num2=240; num3=180;
    str1='purelin'; str2='purelin'; str3='traingdx';
else
    load Mat\param;
end
%生成训练BP神经网络的输入 P 
%200*49的矩阵, 每一行代表一张主成分脸(共40人，每人5张)，每个脸49维特征（输入）
%与faceLabel的200*1相对应（输出）
P=TrainData;
%生成目标输出矢量 T
T=zeros(200,40);
 for i=1:40
    for j=1:5
      T((i-1)*5+j,i)=1;
    end
 end
 
 
%打乱训练样本顺序
%P(200*49)   T(200*40)全零矩阵
gx2(:,1:k)=P;  %前 k 个本征值和本征向量 k=49
gx2(:,(k+1):(k+40))=T;
xd=gx2(randperm(numel(gx2)/(k+40)),:);   %matlab  randperm（）函数，是样本与标签对应打乱  
gx=xd(:,1:k);
d=xd(:,(k+1):(k+40));
P=gx';
T=d';

%创建BP神经网络

[R,Q]=size(P);
[S2,Q]=size(T);
% net=newff(minmax(P),T,[fix(sqrt(R*S2))],{'purelin','purelin'},'traingdx');
net=newff(minmax(P),T,[num2 num3],{str1,str2},str3);
save('Mat/net', 'net');
%训练BP神经网络
net.trainparam.epochs=num1;    %训练步数
net.trainparam.goal=0.0001;    %训练目标误差
net.divideFcn = '';            %所有的样本都用于训练
[net,tr]=train(net,P,T);       %P为输入，T为输出，开始训练

%仿真BP神经网络
Y=sim(net,P);
