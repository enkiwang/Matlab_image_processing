% GrayScale image processing for contrast enhancement + post-smoothing
% Tested on Matlab R2017a
% Date: Feb. 26, 2018

close all;
clear;clc
% load A1 data, scanning time 5/10 mu sec
load A1_5.mat   
load A1_10.mat
% load A2 data, scanning time 5/10 mu sec
load A2_5.mat   
load A2_10.mat
% convert double to uint8 type
A1_5=uint8(A1_5);A1_10=uint8(A1_10);
A2_5=uint8(A2_5);A2_10=uint8(A2_10);

fprintf('min and max value of 5 mu sec (A1) are: %.1f, %.1f \n', min(min(A1_5)),max(max(A1_5)));
fprintf('min and max value of 10 mu sec (A1) are: %.1f, %.1f \n', min(min(A1_10)),max(max(A1_10)));

fprintf('min and max value of 5 mu sec (A1) are: %.1f, %.1f \n', min(min(A2_5)),max(max(A2_5)));
fprintf('min and max value of 10 mu sec (A1) are: %.1f, %.1f \n', min(min(A2_10)),max(max(A2_10)));

% %*************** try variance values ***************
val_var=0.5;
% %*************** try variance values ***************

%% comparison A1
A1_imadjust=imadjust(A1_5); A1_imadjust=imgaussfilt(A1_imadjust,[val_var val_var]);
A1_histeq=histeq(A1_5);  A1_histeq=imgaussfilt(A1_histeq,[val_var val_var]);
A1_adapthisteq=adapthisteq(A1_5);  A1_adapthisteq=imgaussfilt(A1_adapthisteq,[val_var val_var]);
% % show two original images (scanning time =5 (10) mu sec
figure(1);imshow(A1_10,[0,max(max(A1_10))]); title('A1 (10 \mu sec)');
figure(2);imshow(A1_5,[0,max(max(A1_5))]); title('A1 (5 \mu sec)');
% % show three processed images: contrast enhanced images with three
% built-in functions (i.e., imadjust, histeq and adapthiseq) + gauss
% filtering with variance var_var in both x and y axis.
figure(3); imshow(A1_imadjust,[0,max(max(A1_imadjust))]); title('image adjust');
figure(4); imshow(A1_histeq,[0,max(max(A1_histeq))]); title('histogram equalization');
figure(5); imshow(A1_adapthisteq,[0,max(max(A1_adapthisteq))]); title('adaptative histogram equalization');


%% comparison A2
A2_imadjust=imadjust(A2_5); A2_imadjust=imgaussfilt(A2_imadjust,[val_var val_var]);
A2_histeq=histeq(A2_5);  A2_histeq=imgaussfilt(A2_histeq,[val_var val_var]);
A2_adapthisteq=adapthisteq(A2_5);  A2_adapthisteq=imgaussfilt(A2_adapthisteq,[val_var val_var]);
% % show two original images (scanning time =5 (10) mu sec
figure(6);imshow(A2_10,[0,max(max(A2_10))]); title('A2 (10 \mu sec)');
figure(7);imshow(A2_5,[0,max(max(A2_5))]); title('A2 (5 \mu sec)');
% % show three processed images: contrast enhanced images with three
% built-in functions (i.e., imadjust, histeq and adapthiseq) + gauss
% filtering with variance var_var in both x and y axis.
figure(8); imshow(A2_imadjust,[0,max(max(A2_imadjust))]); title('image adjust');
figure(9); imshow(A2_histeq,[0,max(max(A2_histeq))]); title('histogram equalization');
figure(10); imshow(A2_adapthisteq,[0,max(max(A2_adapthisteq))]); title('adaptative histogram equalization');



