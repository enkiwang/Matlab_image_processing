function [ imgs ] = read_from_file( file_directory )
%READ_FROM_FILE Read all images from a given directory (in Win sytem).
% file_directory: directory of the image file to be read from.
% example: 
%         root = 'C:\Users\Yongwei\Downloads\data';
%         [ imgs ] = read_from_file( root )


% Note that:
% 1) I assume all images are of the same size 
% 2) I converted all images to their grayscale version.

% Date: Jun 6, 2018
% @ Yongwei Wang

info_ = dir(file_directory); % list image information in a struct type: name, data, bytes, isdir, datenum
info = info_(3:end-1); %clean the info_, since in windows sytem, info(1).name ='.', info(2).name='..', info(end).name='Thumbs.db'

num_img = length(info);
img1 = imread(fullfile(file_directory, info(1).name));
[width, height,~] = size(img1);
imgs = zeros(num_img, width * height);

for i = 1 : num_img
    img_name = info(i).name;
    imgin = imread(fullfile(file_directory, img_name)); % rgb or grayscale
    
    if size(imgin, 3) > 1
        imgin = rgb2gray(imgin);
    end
    
    imgs(i,:) = imgin(:)';
    
end


end

