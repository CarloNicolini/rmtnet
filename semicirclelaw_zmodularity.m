addpath(genpath('../communityalg'));
addpath(genpath('../algonet'));
clear all;
close all;
n=50;
t=10;
v=[];
dx=0.15;

pER=0.2;
for i=1:t
    A=randomGraph(n,pER);
    ci = [ones(n/2,1); 2*ones(n/2,1)];
    ci=ci(:)';
    C = double(bsxfun(@eq,ci, unique(ci)'));
    Dij = C'*C;
    xi = maxent_null_models('UBCM',A);
    Pij=xi*xi(:)'./(1+xi*xi(:)');
    B=((A-Pij)./(sqrt(Pij.*(1-Pij))));
    
    C = double(bsxfun(@eq,ci, unique(ci)'));
    Dij = C'*C;

    v = [v; eig(B.*Dij)];
end

[count, x]=hist(v);
cla reset;
bar(x,count/(t*n*dx),'y');
hold on;
plot(x,sqrt(4-x.^2)/(2*pi),'r','LineWidth',2);
