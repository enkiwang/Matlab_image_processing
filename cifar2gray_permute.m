% load CIFAR-10 dataset (training + test), and convert to grayscale version
% both RGB and grayscale images are in uint8 format
% CIFAR-10 dataset(Matlab) can be downloaded from here-- https://www.cs.toronto.edu/~kriz/cifar.html

% June 16, 2018
% Yongwei Wang

close all; 
clear;clc

% concatenating datasets into one matrix (50k for training + 10k for test)
cifarRGB = uint8(zeros(60e3, 3072));  % uint8 conversion, otherwise data format mismatch
cifarGray = uint8(zeros(60e3, 1024));

%% loading cifar-10 RGB dataset
% batch 1
unit = 10e3;
load data_batch_1.mat
cifarRGB(1:unit,:) = data;


% batch 2
load data_batch_2.mat
cifarRGB(unit+1:2*unit,:) = data;


% batch 3
load data_batch_3.mat
cifarRGB(2*unit+1:3*unit,:) = data;

% batch 4
load data_batch_4.mat
cifarRGB(3*unit+1:4*unit,:) = data;


% batch 5
load data_batch_5.mat
cifarRGB(4*unit+1:5*unit,:) = data;


% test data
load test_batch.mat
cifarRGB(5*unit+1:6*unit,:) = data;

save cifarRGB.mat cifarRGB   % uint8 format

%% converting RGB into grayscale format
num_imgs = size(cifarRGB,1); 


for k = 1 : num_imgs
    
    img = reshape(cifarRGB(k,:), [32, 32, 3]); 
    img = permute(img, [2, 1, 3]);
    img = rgb2gray(img);
    cifarGray(k,:) = reshape(img, [1,1024]);
    
end
    
    
 save cifarGray.mat cifarGray   % uint8 format
    
    

