clear all;
close all;
n=2E3;
t=10;
v=[];
dx=0.05;

pER=0.2;
for i=1:t
    %A=randn(n);
    %A=sqrt(12)*(rand(n)-0.5);
    A=randomGraph(n,pER);
    A=A-n*pER; % the mean of a Poisson law
    A=A./sqrt(pER); % the standard deviation of a Poisson law
    v = [v; eig(A)];
end
v = v/sqrt(n/2);
[count, x]=hist(v,-2:dx:2);
%cla reset;
bar(x,count/(t*n*dx),'y');
%histogram(v,-4:dx:4);
hold on;
plot(x,sqrt(4-x.^2)/(2*pi),'r','LineWidth',2);
