% (k*B) % D
% June 29 2018

close all; 
clc; 

B = 128;
D = 5e4;

STEPS = 5e3; 
Mod_kBD = zeros(1, STEPS);

for k = 1: STEPS
    mod_kBD = mod(k*B, D);
    quo = floor(k*B/D);
    Mod_kBD(k) = mod_kBD;
    
    fprintf('%d %% %d = %d ... %d \n', k*B, D, quo, mod_kBD);
    
end

nbins = 50;
hist( Mod_kBD, nbins)