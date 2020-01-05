% wavelet decomposition
close all; clear; clc

% img = imread('cameraman.tif');
% [cA, cH, cV, cD] = dwt2(img, 'haar');
% figure(1);
% subplot(2,2,1),imshow(uint8(cA)),title('low freq. component');
% subplot(2,2,2),imshow(uint8(cH)),title('horizontal component');
% subplot(2,2,3),imshow(uint8(cV)),title('vertical component');
% subplot(2,2,4),imshow(uint8(cD)),title('diagonal component');
% 
% %wavelet decomposition at 2 scales
% X=imread('cameraman.tif');
% [c,s]=wavedec2(X,2,'db1');  %2 levels decomposition
% [cH1,cV1,cD1]=detcoef2('all',c,s,1);  %level 1 high-freq coefficients
% [cH2,cV2,cD2]=detcoef2('all',c,s,2);  %level 2 high-freq coefficients
% cA1=appcoef2(c,s,'db1',1);  %level 1 low-freq
% cA2=appcoef2(c,s,'db1',2);  %level 2 low-freq
% 
% figure(2),imshow(X);title('original image');
% 
% figure(3);
% subplot(1,2,1),imshow(uint8(cA1));axis off;title('level 1 low freq.');
% subplot(1,2,2),imshow(uint8(cA2));axis off;title('level 2 low freq');
% 
% figure(4);
% subplot(2,3,1),imshow(uint8(cH1));axis off;title('level 1 horizontal');
% subplot(2,3,2),imshow(uint8(cV1));axis off;title('level 1 vertical');
% subplot(2,3,3),imshow(uint8(cD1));axis off;title('level 1 diagonal');
% subplot(2,3,4),imshow(uint8(cH2));axis off;title('level 2 horizontal');
% subplot(2,3,5),imshow(uint8(cV2));axis off;title('level 2 vertical');
% subplot(2,3,6),imshow(uint8(cD2));axis off;title('level 2 diagonal');

clear; clc; 
load woman %map 255x3; X:256x256
h0 = [0.037828, -0.023849, -0.110624, 0.377402, 0.852699, ...
    0.377402, -0.110624, -0.023849, 0.037828];
h1 = [0.064539, -0.040689, -0.418092, 0.788486, ...
    -0.418092, -0.040689, 0.064539];

[c,s] = wavedec2(X,3,h0,h1);

% 3 level approximations
cA1=appcoef2(c,s,h0,h1,1);
cA2=appcoef2(c,s,h0,h1,2);
cA3=appcoef2(c,s,h0,h1,3);

figure;
imshow(cA1,[]); %132x132
figure;
imshow(cA2,[]); %70x70
figure;
imshow(cA3,[]); %39x39

% high-freq components
[cH1,cV1,cD1]=detcoef2('all',c,s,1); %132x132
[cH2,cV2,cD2]=detcoef2('all',c,s,2); %70x70
[cH3,cV3,cD3]=detcoef2('all',c,s,3); %39x39

figure;
subplot(2,2,1); imshow(cA1,[]);axis off;title('level 1 A');
subplot(2,2,2); imshow(cH1,[]);axis off;title('level 1 H');
subplot(2,2,3); imshow(cV1,[]);axis off;title('level 1 V');
subplot(2,2,4); imshow(cD1,[]);axis off;title('level 1 D');

figure;
subplot(2,2,2); imshow(cH2,[]);axis off;title('level 2 H');
subplot(2,2,3); imshow(cV2,[]);axis off;title('level 2 V');
subplot(2,2,4); imshow(cD2,[]);axis off;title('level 2 D');

figure;
subplot(2,2,2); imshow(cH3,[]);axis off;title('level 3 H');
subplot(2,2,3); imshow(cV3,[]);axis off;title('level 3 V');
subplot(2,2,4); imshow(cD3,[]);axis off;title('level 3 D');









