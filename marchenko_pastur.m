function y = marchenko_pastur(x, r, variance)

a = variance.*((1-r^(-0.5))^2);
b = variance.*((1+r^(-0.5))^2);
y = real( variance*1.0./(2*pi.*x.*r).*sqrt((b-x).*(x-a)));