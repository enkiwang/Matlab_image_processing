% 1) read all ".bmp" images from a specific directory (root)
% 2) chopping images into blocks, each with size block_size*block_size
% 3) assign a lable for each block-sized image

% Jun 6, 2018
% @yongwei

close all;
clear;clc

root = 'C:\Users\Yongwei\Documents\research\experiments\data\Training_Data\Train';

info = dir(fullfile(root, '*.bmp')); % list all images in terms of fields for the given full path

num_img = length(info);

% cropping each image into blocks with stride
stride = 16;
block_size = 32;
tol = 1; % tol-- number of blocks, will vary and given 1 first 
imgs = zeros(block_size, block_size, 1, tol);
labels = zeros(1, tol); % assigning a 1-dim label to each block
count = 0;


for i = 1 : num_img
    img = imread(fullfile(root, info(i).name));
    img = rgb2ycbcr(img);
    img = im2double(img(:, :, 1));
    
    [hei, wid, ~] = size(img);
    
    for x = 1: stride: hei - block_size + 1 
        for y = 1 : stride : wid - block_size + 1
            
            count = count + 1; 
            imgs(:, :, 1, count) = img(x: x + block_size-1, y: y + block_size -1);
            labels(1,count) = count; % just an example here
            
        end
        
    end
            
    
end