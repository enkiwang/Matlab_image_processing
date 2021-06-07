%% 
close all;
clear; clc

rng(0,'twister');

x_max = 52; y_max = 82; num_samples = x_max*y_max;

data = 0.3 + 0.01*rand(1, num_samples);

data_var = reshape(data, [x_max, y_max]);

% five 0.4 values

% PC
data_var(x_max,y_max) = 0.7;

% three 0.5 values
v1 = 4138; v2 = 1777; v3 = 709;
v1_x = floor(v1/y_max); v1_y = v1 - v1_x * y_max;
v2_x = floor(v2/y_max); v2_y = v2 - v2_x * y_max;
v3_x = floor(v3/y_max); v3_y = v3 - v3_x * y_max;

data_var(v1_x, v1_y) = 0.5;
data_var(v2_x, v2_y) = 0.5;
data_var(v3_x, v3_y) = 0.5;


% five 0.4 values
vv1 = 1132; vv2 = 3642; vv3 = 3681; vv4 = 3009; vv5 = 1730;
vv1_x = floor(vv1/y_max); vv1_y = vv1 - vv1_x * y_max;
vv2_x = floor(vv2/y_max); vv2_y = vv2 - vv2_x * y_max;
vv3_x = floor(vv3/y_max); vv3_y = vv3 - vv3_x * y_max;
vv4_x = floor(vv4/y_max); vv4_y = vv4 - vv4_x * y_max;
vv5_x = floor(vv5/y_max); vv5_y = vv5 - vv5_x * y_max;

data_var(vv1_x, vv1_y) = 0.4;
data_var(vv2_x, vv2_y) = 0.4;
data_var(vv3_x, vv3_y) = 0.4;
data_var(vv4_x, vv4_y) = 0.4;
data_var(vv5_x, vv5_y) = 0.4;


clips = [0.3, 0.7];
imagesc(data_var, clips);

set(gca,'YDir','normal');
set(gca, 'XTick', 0:20:80);
set(gca, 'YTick', 0:10:50);

set(0,'DefaultTextFontName','Times',...
'DefaultAxesFontName','Times',...
'DefaultLineLineWidth',1.5,...
'DefaultLineMarkerSize',6);
set(gcf,'color','w');
% set(gca,'LooseInset',get(gca,'TightInset'));

c = colorbar;
% c.Label.String = '';
% c.FontSize=12;
c.Ticks = 0.3:0.1:0.7;

print(gcf,'test.png','-dpng','-r600');        





