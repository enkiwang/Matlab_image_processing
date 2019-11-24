% RLS �㷨����
close all;
clear;clc

load s.mat
load x.mat    % SNR=5 dB
% h�����ֵ�����±�����Ϊ��43,49,66,77,144��160

%% ��������
%>>> SNR��fs
SNR=5;   % SNR�������ļ����н����ź������Ҫͬ��
fs=5000; % ����Ƶ�� 5k Hz
%>>>���Ȳ���
Ns=length(s);
Nx=length(x);
Nh=Nx-Ns+1;
Iter_max=Nh;      % ����������������Nx�� x=S*h+n; x(n)=h'*sn+n
lambda=0.99;      % lambdaȡֵ���� 0.98~1 ֮�䣻 0.99999
S=toeplitz([s;zeros(Nh-1,1)],[s(1) zeros(1,Nh-1)]);   % S: Nx*Nh

%>>>��ʼ��
hn=zeros(Nh,1);     % �ŵ������Ӧ����
delta=5;            % delta��SNR�йأ�SNR��ʱ��ֵС������ȡ��ֵ 
Pn=1/delta*eye(Nh); % Nh*Nh�ķ���

%>>>�趨���ؿ��޴�������ز���
MC=100;              
h0=zeros(Nh,Iter_max);      % �洢MC=1ʱ���ŵ�����ֵ��xΪ002�ļ����ڱ����x.mat����
hmc=zeros(Nh,Iter_max);     % �洢������ؿ����ʵ����   

%% RLS�㷨���ܲ���
%>>>����002�ļ����ڱ����x.mat����hn�и�Ȩֵ��n�ı仯������ʵ��vs���ʵ����ƽ����
load x0.mat x0;   % x0�������ؿ���ʵ�飬�˴�x0��Դ������002�ļ����µ�LFM_generation������x0�õ���Ϊh��һ�����δ��������Ľ����ź�
tic
for mc=1:MC
    if mc==1
        d=x;
        h0=RLS_self(Iter_max,S,hn,Pn,lambda,d);  % �����״μ�����
        hmc=hmc+h0/MC;  % MC==1�����
    else
        xmc=awgn(x0,SNR,'measured');  % �������,�õ������źţ��������ؿ���ʵ��
        d=xmc;   % �����ź�Ϊ�²����Ľ����ź�
        hp=RLS_self(Iter_max,S,hn,Pn,lambda,d);
        hmc=hmc+hp/MC;  % ����MC�����
    end
end
toc
% ��������ʱ��Ϊ��ʱ�����MC
%% RLS���ܷ���
%>>>���û�ͼ����
set(0,'DefaultTextFontName','Times',...
'DefaultTextFontSize',16,...
'DefaultAxesFontName','Times',...
'DefaultAxesFontSize',12,...
'DefaultLineLineWidth',1.5,...
'DefaultLineMarkerSize',6);

%>>> ����ʵ��ʱǰ������Ȩֵ����������ı仯���
figure
plot(1:Iter_max,h0(43,:),1:Iter_max,h0(49,:),1:Iter_max,h0(66,:),1:Iter_max,h0(77,:),1:Iter_max,h0(144,:));
xlabel('��������'); 
ylabel('����ֵ ��v��');

%>>> ���ؿ��޶��ʵ��ʱǰ������Ȩֵ����������ı仯���
figure
plot(1:Iter_max,hmc(43,:),1:Iter_max,hmc(49,:),1:Iter_max,hmc(66,:),1:Iter_max,hmc(77,:),1:Iter_max,hmc(144,:));
xlabel('��������'); 
ylabel('����ֵ ��v��');
        
%>>> ���ؿ��޶��ʵ��ʱIter_max�ε������ŵ����������ʵ�ŵ���Ӧ���жԱ�
load h.mat
h=abs(h(2,:))/max(abs(h(2,:))); % x=s*h+n����ȡhΪ����ֵ������002�ļ��У�

figure
plot((1:Nh)/fs*1000,hmc(:,Iter_max)/max(abs(hmc(:,Iter_max))));
hold on;
Indx=find(h>0);
stem((Indx)/fs*1000,h(Indx),'r^');
set(gca,'xTick',0:10:50,'yTick',-1.5:.5:1.5);
v = axis;
axis( [ v(1:2) -.8 1.1 ] );  % v����Ϊ x_min, x_max, y_min, y_max 
xlabel('���ʱ��ֵ ��ms��');
ylabel('��ֵ ��v��');
legend('RLS�����ŵ������Ӧ','��ʵ�ŵ������Ӧ');

h_rls=hmc(:,Iter_max);

% save h_rls.mat h_rls


    