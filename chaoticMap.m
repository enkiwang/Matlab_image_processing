% chaotic map
% https://blog.csdn.net/lomen_hit/article/details/79536783
% Logistic map test: 
% X(n+1) = mu * X(n) * (1 - X(n) ) n=1,2,3...
% mu \in (0,4], X(n) \in (0,1)

close all;
clear;clc

%% 1D chaotic example -- Logistic map
mu = 3.999;
N = 5e4;
X = zeros(1,N);
X(1) = .5; 

for n = 2: N
    X(n) = mu * X(n-1) * (1 - X(n-1) );
end

% plot(X)
figure(1);
hist(X);
xlabel('n');
ylabel('x(n)');
title('logistic map hist');

%% 2D chaotic example -- Henon map
% x(n+1) = 1 + y(n) - a * x(n) ^2
% y(n+1) = b * x(n)
% a \in [1.07, 1.4], b=0.3

dim = 256;
x = zeros(1,dim);
y = zeros(1,dim);
x(1) = .5;
y(1) = .5;
a = 1.2;
b = .3;


for n = 2:dim
    x(n) = 1 + y(n-1) - a * x(n-1)^2;
    y(n) = b * x(n-1);
end

figure(2);
scatter(x,y)
xlabel('x ');
ylabel('y');
title('Henon map');