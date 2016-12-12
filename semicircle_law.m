n=1E3;
t=1;
v=[];
dx=0.05;

for i=1:t
    A=randn(n);
    S = (A+A')/2;
    v = [v; eig(S)];
end
v = v/sqrt(n/2);
[count, x]=hist(v,-2:dx:2);
cla reset;
bar(x,count/(t*n*dx),'y');
hold on;
plot(x,sqrt(4-x.^2)/(2*pi),'r','LineWidth',2);
