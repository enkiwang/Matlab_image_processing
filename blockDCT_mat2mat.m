% DCT for .mat images
% Sept 5, 2018
% Yongwei Wang

close all; 
clear;clc

root = '/path/to/file/';

% load original images
load([root 'imgs_train_py.mat']);

imgs_train_py_dct = mat_dct(imgs_train_py);
imgs_train_py_idct = mat_idct(imgs_train_py_dct);

% show an example
k=10;
figure(1)
imshow(reshape(imgs_train_py(k,:),[32,32])); % original image 
figure(2)
imshow(reshape(imgs_train_py_dct(k,:),[32,32])); % DCT domain
figure(3)
imshow(reshape(imgs_train_py_idct(k,:),[32,32])); % inverse DCT, same values as original image



function imgs = mat_dct(data_mat) %.mat -> (imgs -> dct) -> .mat
[row,~]=size(data_mat);
imgs = zeros(size(data_mat));

for i = 1:row
    img = reshape(data_mat(i,:),[32,32]);
    img_dct = blockDCT(img);
    imgs(i,:) = img_dct(:);
end

end


function img_dct= blockDCT(img)
[hei,wid] = size(img);
img_dct = zeros(size(img));
step = 8;
for y = 1: step: wid-step+1
    for x = 1: step: hei-step+1
       img_dct(x:x+step-1,y:y+step-1) = dct2(img(x:x+step-1,y:y+step-1));
    end
end

end

function imgs = mat_idct(dct_mat) %.mat -> (imgs -> idct) -> .mat
[row,~]=size(dct_mat);
imgs = zeros(size(dct_mat));

for i = 1:row
    img_dct = reshape(dct_mat(i,:),[32,32]);
    dct_img = blockIDCT(img_dct);
    imgs(i,:) = dct_img(:);
end

end

function img= blockIDCT(data_dct)
[hei,wid] = size(data_dct);
img = zeros(size(data_dct));
step = 8;
for y = 1: step: wid-step+1
    for x = 1: step: hei-step+1
       img(x:x+step-1,y:y+step-1) = idct2(data_dct(x:x+step-1,y:y+step-1));
    end
end

end


