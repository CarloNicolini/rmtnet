% Experiment: Quantum density of random ER graph.
% Plot:Histogram of the eigenvalues of X'X/m
% Theory: Marcenko−Pastur as n−>infinity
% Parameters
addpath(genpath('~/workspace/algonet/'));
addpath('~/workspace/qit/matlab/');

clear all;
close all;

t=1000; %trials
r=1; % aspectratio
n=100; % matrixcolumnsize
m=round(n/r);
dx=.01; % binsize

pER=0.25;
A=randomGraph(n,pER);
[entropy_values, invbetas] = entropy_vs_invbeta(A, -5, 5, 1000);
figure;
semilogx(invbetas,entropy_values,'.-');
xlabel('1/beta');
ylabel('S/log(N)');

beta=estimate_beta(randomGraph(n,pER),0.05);

%%Experiment
v=[];
for i=1:t
     X = quantum_density(randomGraph(n,pER),0.2);
     XI = inv(sqrt(diag(diag(X))));
     C = XI*X*XI; % correlation matrix
     v = [v; eig(C)];
    
    %QUESTO FITTA PERFETTISSIMO
    %l=randn(n); C=(l*l'); v=[v;eig(C)]; %eigenvalues
end
v=v/m;%normalized eigenvalues

%lx=linspace(0,mean(v)*4,100);
a=(1-sqrt(r))^2;b=(1+sqrt(r))^2;
[count, x]=hist(v,a:dx:b);
cla reset;
dlx=diff(x);
bar(x,count/(t*n*dlx(1)));
hold on;
y=marchenko_pastur(x,r,1);

plot(linspace(a,b),marchenko_pastur(linspace(a,b),r,1),'r','LineWidth',2);

% subplot(1,2,1);
% X=quantum_density(randomGraph(n,0.25),0.1);
% X=X*n;
% imagesc(X); colorbar; axis square;
% subplot(1,2,2);
% histogram(eig(X));
%plot(v);

%histogram(v,linspace(0,1E-4,100))
%
% a=(1-sqrt(r))^2;b=(1+sqrt(r))^2;
% %%Plot
% [count,x]=hist(v,a:dx:b);
% cla reset
% bar(x,count/(t*n*dx),'y');
% hold on;
% %%Theory
% x=linspace(a,b);
% plot(x,sqrt((x-a).*(b-x))./(2*pi*x*r),'LineWidth',2);
% axis([0 ceil(b) -.1 1.5]);
% hold off;