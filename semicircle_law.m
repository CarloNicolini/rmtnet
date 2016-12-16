% Fit the semicircle law to the normalized eigenvalues of a random
% hermitian matrix with 0 mean and 1 variance, as obtained with randn or
% with (sqrt(12)*rand - 0.5)
close all;
clear all;
n=1E3;
t=1;
v=[];
dx=0.2;

for i=1:t
    A=randn(n);
    S=(A+A')/2;
    v = [v; eig(S)];
end
v = v/sqrt(n/2);
[count, x]=hist(v,-2:dx:2);
cla reset;
bar(x,count/(t*n*dx),'y');
hold on;
plot(x,sqrt(4-x.^2)/(2*pi),'r','LineWidth',2);
