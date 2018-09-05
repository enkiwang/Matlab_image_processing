% read images (.tif) and convert it to .png

close all;
clear;clc

root = 'C:\Users\Yongwei\Desktop\test_images\';
save_root = 'C:\Users\Yongwei\Desktop\test_images_png\';

info = dir(fullfile(root, '*.tif')); % list all images in terms of fields for the given full path

num_img = length(info);

for i = 1: num_img
    img = imread(fullfile(root,info(i).name));
    imwrite(img,[save_root num2str(i-1) '.png']);
end

