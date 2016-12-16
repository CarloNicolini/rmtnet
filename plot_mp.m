hold on;
for gamma=linspace(0,20,20)
    x=linspace(0,5,1000); y=marchenko_pastur(x,gamma); plot(x,y);
    xlim([-0.5,5]);
end