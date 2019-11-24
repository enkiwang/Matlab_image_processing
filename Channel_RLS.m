% RLS 算法仿真
close all;
clear;clc

load s.mat
load x.mat    % SNR=5 dB
% h的最大值排序下标依次为：43,49,66,77,144，160

%% 参数设置
%>>> SNR及fs
SNR=5;   % SNR与其他文件夹中接收信号信噪比要同步
fs=5000; % 采样频率 5k Hz
%>>>长度参数
Ns=length(s);
Nx=length(x);
Nh=Nx-Ns+1;
Iter_max=Nh;      % 迭代最大次数不大于Nx： x=S*h+n; x(n)=h'*sn+n
lambda=0.99;      % lambda取值介于 0.98~1 之间； 0.99999
S=toeplitz([s;zeros(Nh-1,1)],[s(1) zeros(1,Nh-1)]);   % S: Nx*Nh

%>>>初始化
hn=zeros(Nh,1);     % 信道冲击响应向量
delta=5;            % delta与SNR有关，SNR高时该值小，否则取大值 
Pn=1/delta*eye(Nh); % Nh*Nh的方阵

%>>>设定蒙特卡罗次数及相关参数
MC=100;              
h0=zeros(Nh,Iter_max);      % 存储MC=1时的信道估计值，x为002文件夹内保存的x.mat数据
hmc=zeros(Nh,Iter_max);     % 存储多次蒙特卡洛的实验结果   

%% RLS算法性能测试
%>>>利用002文件夹内保存的x.mat测试hn中各权值随n的变化（单次实验vs多次实验求平均）
load x0.mat x0;   % x0用于蒙特卡罗实验，此处x0来源于运行002文件夹下的LFM_generation并保存x0得到，为h归一化后的未添加噪声的接收信号
tic
for mc=1:MC
    if mc==1
        d=x;
        h0=RLS_self(Iter_max,S,hn,Pn,lambda,d);  % 保存首次计算结果
        hmc=hmc+h0/MC;  % MC==1的情况
    else
        xmc=awgn(x0,SNR,'measured');  % 添加噪声,得到测试信号，用于蒙特卡罗实验
        d=xmc;   % 期望信号为新产生的接收信号
        hp=RLS_self(Iter_max,S,hn,Pn,lambda,d);
        hmc=hmc+hp/MC;  % 进行MC的情况
    end
end
toc
% 单次运行时间为总时间除以MC
%% RLS性能分析
%>>>设置绘图环境
set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',16,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',12,...
'DefaultLineLineWidth',1.5,...
'DefaultLineMarkerSize',6);

%>>> 单次实验时前五个最大权值随迭代次数的变化情况
figure
plot(1:Iter_max,h0(43,:),1:Iter_max,h0(49,:),1:Iter_max,h0(66,:),1:Iter_max,h0(77,:),1:Iter_max,h0(144,:));
xlabel('迭代次数'); 
ylabel('幅度值 （v）');

%>>> 蒙特卡罗多次实验时前五个最大权值随迭代次数的变化情况
figure
plot(1:Iter_max,hmc(43,:),1:Iter_max,hmc(49,:),1:Iter_max,hmc(66,:),1:Iter_max,hmc(77,:),1:Iter_max,hmc(144,:));
xlabel('迭代次数'); 
ylabel('幅度值 （v）');
        
%>>> 蒙特卡罗多次实验时Iter_max次迭代后信道输出并与真实信道响应进行对比
load h.mat
h=abs(h(2,:))/max(abs(h(2,:))); % x=s*h+n中所取h为绝对值（参照002文件夹）

figure
plot((1:Nh)/fs*1000,hmc(:,Iter_max)/max(abs(hmc(:,Iter_max))));
hold on;
Indx=find(h>0);
stem((Indx)/fs*1000,h(Indx),'r^');
set(gca,'xTick',0:10:50,'yTick',-1.5:.5:1.5);
v = axis;
axis( [ v(1:2) -.8 1.1 ] );  % v向量为 x_min, x_max, y_min, y_max 
xlabel('相对时延值 （ms）');
ylabel('幅值 （v）');
legend('RLS估计信道冲击响应','真实信道冲击响应');

h_rls=hmc(:,Iter_max);

% save h_rls.mat h_rls


    