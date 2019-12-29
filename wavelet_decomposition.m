% wavelet decomposition
close all; clear; clc

img = imread('cameraman.tif');
[cA, cH, cV, cD] = dwt2(img, 'haar');
figure(1);
subplot(2,2,1),imshow(uint8(cA)),title('low freq. component');
subplot(2,2,2),imshow(uint8(cH)),title('horizontal component');
subplot(2,2,3),imshow(uint8(cV)),title('vertical component');
subplot(2,2,4),imshow(uint8(cD)),title('diagonal component');

%wavelet decomposition at 2 scales
X=imread('cameraman.tif');
[c,s]=wavedec2(X,2,'db1');  %2 levels decomposition
[cH1,cV1,cD1]=detcoef2('all',c,s,1);  %level 1 high-freq coefficients
[cH2,cV2,cD2]=detcoef2('all',c,s,2);  %level 2 high-freq coefficients
cA1=appcoef2(c,s,'db1',1);  %level 1 low-freq
cA2=appcoef2(c,s,'db1',2);  %level 2 low-freq

figure(2),imshow(X);title('original image');

figure(3);
subplot(1,2,1),imshow(uint8(cA1));axis off;title('level 1 low freq.');
subplot(1,2,2),imshow(uint8(cA2));axis off;title('level 2 low freq');

figure(4);
subplot(2,3,1),imshow(uint8(cH1));axis off;title('level 1 horizontal');
subplot(2,3,2),imshow(uint8(cV1));axis off;title('level 1 vertical');
subplot(2,3,3),imshow(uint8(cD1));axis off;title('level 1 diagonal');
subplot(2,3,4),imshow(uint8(cH2));axis off;title('level 2 horizontal');
subplot(2,3,5),imshow(uint8(cV2));axis off;title('level 2 vertical');
subplot(2,3,6),imshow(uint8(cD2));axis off;title('level 2 diagonal');
