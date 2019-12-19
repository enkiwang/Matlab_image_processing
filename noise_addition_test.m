% noise addition

[I, map] = imread('eight.tif');
I = double(I) / 255;

base_sigma = 1e-5; 
sigma = base_sigma * linspace(1, 1000);
PSNR = zeros(1,length(sigma));

for i = 1:length(sigma)
    sigma_tmp = sigma(i);
    for j = 1:10
        J_tmp = imnoise(I, 'gaussian', 0, sigma_tmp);
        diff = abs(I(:) - J_tmp(:));
        mse = mean(diff.^2); 
        PSNR(i) = PSNR(i) + 10*log10(1/mse);
    end
end


semilogx(sigma, PSNR/10); 
xlabel('std value');
ylabel('PSNR (dB)'); 

%sigma^2/PSNR vs visual quality:
% PNSR = -10log10(sigma^2)

% 1e-5, 50 dB; very good
% 5e-5, 43.00 dB; good
% 1e-4, 40.01 dB; okay
% 5e-4, 32.99 dB; noisy
% 1e-3, 30 dB; noisy
% 1e-2, 20.82 dB; very noisy






