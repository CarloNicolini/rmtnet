n=3;
s=1E4;
d=0.1;
e=[];
for i=1:s
a = randn(n)+ sqrt(-1)*randn(n);
a=(a+a')/(2*sqrt(4*n));
v = eig(a);
e = [e v];
end

[m,x]=hist(e);
bar(x,m*pi/(2*d*n*s),'y');
axis('square');

hold on;
t=-1=0.01:1;
plot(t,sqrt(1-t.^2),'r','LineWidth',2);
%levels(n)
hold off;