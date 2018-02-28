% Matlab code to calculate PSNR+SSIM indices of images within one directory
% tested on Matlab R2013b
% Date: Jan. 20, 2017
% Author: yongweiw
clear
close all
clc

%% Initializations

pre_images_dir = './pre';
pre_images = dir(pre_images_dir);
pre_images = pre_images(3:end-1);

gt_images_dir = './gt'; 
gt_images=dir(gt_images_dir);
gt_images=gt_images(3:end-1);

psnr = zeros(length(pre_images),1);
ssIndex=zeros(length(pre_images),1);

%%
for image_number = 1:length(pre_images)
    
    image_name = pre_images(image_number).name;
    pre_im = im2double(imread(fullfile(pre_images_dir,image_name))); 
    rec_im=im2double(imread(fullfile(gt_images_dir,image_name))); 
    
    
    diff = pre_im - rec_im;
    sig = sqrt(mean(pre_im(:).^2));
    diff = diff(:);
    rmse = sqrt(mean(diff(:).^2));
    psnr(image_number) = 20*log10(1/rmse);
    
    [ssIndex(image_number),~]=ssim(pre_im,rec_im); % ssim index 
        
    fprintf('\n %15s: PSNR = %f dB,  SSIM = %f \n ', image_name, psnr(image_number), ssIndex(image_number));    

end

fprintf('\n  Averaged PSNR = %f dB, std(PSNR) = %f dB,  min(PSNR) = %f dB, max(PSNR) = %f dB ', mean(psnr),std(psnr), min(psnr), max(psnr));
fprintf('\n  Averaged SSIM = %f , std(SSIM) = %f, min(SSIM) = %f, max(SSIM) = %f \n ', mean(ssIndex),std(ssIndex), min(ssIndex), max(ssIndex));

save psnr.mat psnr
save ssIndex.mat ssIndex

